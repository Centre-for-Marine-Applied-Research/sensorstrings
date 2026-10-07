#' Convert coordinates from degree-minute-decimal to decimal degree
#'
#' To apply to multiple columns using \code{dplyr::across}:
#'
#' 1. Define variables to convert:
#'
#' coords_ddm <- c("deployment_latitude_n_ddm", "deployment_longitude_w_ddm",
#' "retrieval_latitude_n_ddm", "retrieval_longitude_w_ddm")
#'
#' 2. Use the .names argument to specify new column names so that the original
#' columns are not over-written:
#'
#' \code{dat <- dat_raw |> mutate(across(any_of(coords_ddm),
#' ~ss_convert_coords_from_ddm_to_dd(.x), .names = "{str_remove(.col, '_w_ddm|_n_ddm')}"
#' ))}
#'
#' @param coords_ddm Vector of coordinate values in degree decimal minutes (xx
#'   xx.xxxx, e.g., 45 21.651 or 64 2.063). These will be converted to decimal
#'   degrees.
#'
#' @param west Logical argument indicating if the coordinates are in the Western
#'   hemisphere. If \code{TRUE} (the default), the returned longitudes will have
#'   a negative sign.
#'
#' @return Returns a vector of coordinates in decimal-degree format.
#'
#' @importFrom dplyr across mutate rename select
#' @importFrom tidyr separate
#'
#' @export

ss_convert_coords_from_ddm_to_dd <- function(coords_ddm, west = TRUE) {

  coords_out <- coords_ddm |>
    data.frame() |>
    rename(degree_decimal_minutes = 1) |>
    separate(
      degree_decimal_minutes,
      into = c("coord_deg", "coord_dm"), sep = " ", remove = FALSE
    ) |>
    mutate(
      across(contains("coord_"), ~ as.numeric(.x)),
      decimal_degree = coord_deg + coord_dm / 60
    )

  coords_out <- coords_out$decimal_degree

  if(isTRUE(west)) {
    coords_out[seq(2, length(coords_out), 2)] <- coords_out[seq(2, length(coords_out), 2)] * -1
  }

  coords_out
}
