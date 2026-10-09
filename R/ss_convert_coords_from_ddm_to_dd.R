#' Convert coordinate columns from degree decimal minutes to decimal degrees
#'
#' @description Finds every column in \code{dat} whose name ends in
#'   \code{_n_ddm}, \code{_s_ddm}, \code{_e_ddm} or \code{_w_ddm} (e.g.,
#'   \code{deployment_latitude_n_ddm}, \code{retrieval_longitude_w_ddm}) and
#'   converts it to decimal degrees.
#'
#'   The sign comes from the hemisphere letter in the column name: \code{_s_}
#'   and \code{_w_} columns are returned as negative values; \code{_n_} and
#'   \code{_e_} columns as positive values.
#'
#'   The result goes in a column with the hemisphere and \code{_ddm} removed
#'   (\code{deployment_latitude_n_ddm} becomes \code{deployment_latitude}). If
#'   that column already exists, only its \code{NA} values are filled in, so
#'   coordinates already recorded in decimal degrees are kept.
#'
#' @param dat Data frame with at least one \code{*_n_ddm}, \code{*_s_ddm},
#'   \code{*_e_ddm} or \code{*_w_ddm} column. Values must be in the form
#'   "degrees decimal-minutes", e.g., "45 21.651" or "64 2.063".
#'
#' @param keep_ddm Logical argument indicating whether to keep the
#'   \code{*_ddm} columns. Default is \code{TRUE}.
#'
#' @return Returns \code{dat} with the decimal-degree columns added or filled
#'   in.
#'
#' @importFrom dplyr all_of coalesce mutate select
#'
#' @export
#'
#' @examples
#' dat <- data.frame(
#'   station = c("Borgles Island", "Birchy Head"),
#'   deployment_latitude_n_ddm = c("44 46.345", "44 34.206"),
#'   deployment_longitude_w_ddm = c("62 43.565", "64 2.063")
#' )
#'
#' ss_convert_coords_from_ddm_to_dd(dat)
#'
#' # existing decimal-degree values are kept; only the NA values are filled in
#' dat$deployment_latitude <- c(44.77241, NA)
#' ss_convert_coords_from_ddm_to_dd(dat, keep_ddm = FALSE)

ss_convert_coords_from_ddm_to_dd <- function(dat, keep_ddm = TRUE) {

  # pull out columns with _n_ddm, _s_ddm, _e_ddm, or _w_ddm
  ddm_cols <- grep("_[nsew]_ddm$", colnames(dat), value = TRUE, ignore.case = TRUE)

  if (length(ddm_cols) == 0) {
    stop("No columns ending in _n_ddm, _s_ddm, _e_ddm or _w_ddm found in dat")
  }

  for (col_i in ddm_cols) {

    # this pulls out the direction and replaces the whole string with the single letter
    hemisphere <- tolower(sub(".*_([nsew])_ddm$", "\\1", col_i, ignore.case = TRUE))

    sign <- if (hemisphere %in% c("s", "w")) -1 else 1

    # remove the direction_ddm from the column name
    dd_col <- sub("_[nsew]_ddm$", "", col_i, ignore.case = TRUE)

    # convert the whole column to dd
    dd <- sign * convert_ddm_to_dd(dat[[col_i]])

    if (dd_col %in% colnames(dat)) {
      # only replaces missing values; does not overwrite values already entered
      dat <- mutate(dat, "{dd_col}" := coalesce(as.numeric(.data[[dd_col]]), dd))
    } else {
      dat <- mutate(dat, "{dd_col}" := dd)
    }
  }

  if (isFALSE(keep_ddm)) dat <- select(dat, -all_of(ddm_cols))

  dat
}


#' Convert a vector of degree decimal minutes to (unsigned) decimal degrees
#'
#' @param x Character vector, e.g., c("45 21.651", "64 2.063"). \code{NA} and
#'   blank values return \code{NA}.
#'
#' @return Numeric vector of decimal degrees, always positive. The caller
#'   decides the sign.
#' @noRd

convert_ddm_to_dd <- function(x) {

  x <- trimws(as.character(x)) # remove white space
  x[x == ""] <- NA             # if blank, convert to NA

  # split into degree, decimal minutes, and decimals
  # d is for digit, s is for white space
  parts <- regmatches(x, regexec("^(\\d+)\\s+(\\d+(\\.\\d+)?)$", x))
  good_coord <- lengths(parts) > 0

  bad_coord <- !good_coord & !is.na(x)
  if (any(bad_coord)) {
    warning(
      "Can't convert coordinates << ", paste(unique(x[bad_coord]), collapse = ", "),
      " >>. Expected degrees and decimal minutes, e.g., 45 21.651"
    )
  }

  # convert both parts to numeric
  deg <- vapply(parts[good_coord], function(p) as.numeric(p[2]), numeric(1))
  min <- vapply(parts[good_coord], function(p) as.numeric(p[3]), numeric(1))

  if (any(min >= 60)) warning("Minutes must be less than 60")

  out <- rep(NA_real_, length(x))

  out[good_coord] <- deg + min / 60

  out
}
