#' Model sensor string
#'
#' Generates a mooring object, which can be used with the \code{mooring} package
#' to assess current knockdown and tension on the line (e.g., required anchor
#' weight).
#'
#' For details on the model, see help files for the \code{mooring} package.
#'
#' With the default arguments, string model is built using information from the
#' metadata tracking sheet (sensor types and depth, anchor and float type).
#'
#' Assumptions:
#'
#' In the case where a hobo sensor was attached to the VR2AR sensor, the hobo
#' hobo sensor is not included.
#'
#' Does not distinguish between VR2AR and VR2AR-X sensors.
#'
#' The bottom float is NOT included.
#'
#' The rope length from the float to the shallowest sensor is hard-coded at 0.05
#' m.
#'
#'
#' @param station Character string. Station name, as it appears in
#'   \code{metadata}.
#' @param depl_date Character string of the deployment date, in the order
#'   "yyyy-mm-dd".
#' @param metadata Default \code{NULL} will read in the metadata tracking sheet
#'   from the CMAR shared drive (user must be connected to the Perennia VPN).
#'   Otherwise, a dataframe with the relevant columns may be included
#'   (instrument, sensor_depth_m, sounding_m, vr2ar_lug_height_above_seafloor_m,
#'   anchor_type, float_type). Instrument, anchor type, and float_type must be
#'   compatible with the \code{mooring} package.
#'
#' @param rope_type Character string. Default is "3/8in leaded polypropylene".
#'   Must be compatible with the \code{mooring} package.
#'
#' @returns A mooring object. Can be used with the functions in the mooring
#'   package.
#'
#' @importFrom dplyr case_when desc filter group_by mutate select ungroup
#' @importFrom mooring anchor float instrument mooring wire
#' @importFrom readxl read_excel
#'
#' @export
#'

model_mooring <- function(
    station,
    depl_date,
    metadata = NULL,
    rope_type = "3/8in leaded polypropylene"
    #segmentize_length = 1,
    #with_current = TRUE
) {

  if(is.null(metadata)) {
    metadata <- read_excel(
      "R:/tracking_sheets/metadata_tracking/water_quality_deployment_tracking.xlsx"
    ) |>
      select(county, station, deployment_date,
             deployment_latitude_n_ddm, deployment_longitude_w_ddm,
             sensor_type, sensor_serial_number, sensor_depth_m, sounding_m,
             vr2ar_lug_height_above_seafloor_m,
             primary_buoy_type, secondary_buoy_type, bottom_buoy_type,
             anchor_type, anchor_weight_kg
      ) |>
      filter(station == !!station, deployment_date == as_date(depl_date)) |>
      # remove hobo attached to VR2AR
      group_by(sensor_depth_m) |>
      mutate(n = n()) |>
      ungroup() |>
      filter(!(n == 2 & sensor_type == "HOBO Pro V2")) |>
      mutate(
        instrument = case_when(
          sensor_type == "HOBO Pro V2" ~ "Hobo Temp U22",
          sensor_type == "HOBO DO" ~ "Hobo DO U26",
          str_detect(sensor_type, "VR2AR") ~ "VR2AR reciever",
          TRUE ~ sensor_type
        ),

        # might make more sense to do this after unique() so only making the conversiom
        # once
        primary_buoy_type = gsub("\"", "in", primary_buoy_type),
        float_type = case_when(
          primary_buoy_type == "14in hard vinyl" ~ "14in centre hole tfloat",
          primary_buoy_type == "11in hard vinyl" ~ "11in centre hole tfloat",
        )
      )
  }

  # make sure sensors are ordered from deepest to most shallow
  metadata <- metadata |>
    arrange(desc(sensor_depth_m))

  # add warning if converted to NA or more than one value
  sounding_m <- unique(as.numeric(metadata$sounding_m))
  first_rope_length_m <- unique(as.numeric(metadata$vr2ar_lug_height_above_seafloor_m))

  #anchor_type <- gsub("[s]$", "", unique(metadata$anchor_type))
  anchor_type <- anchor(gsub("[s]$", "", unique(metadata$anchor_type)))

  float_type <- float(unique(metadata$float_type))

  ss <- NULL
  ss[[1]] <- anchor_type

  j <- 2
  # must start from BOTTOM UP
  for (i in 1:nrow(metadata)) {

    inst_i <- instrument(model = metadata[i, ]$instrument)

    # from anchor to vr2
    if (i == 1) {
      wire_i <- wire(model = rope_type, length = first_rope_length_m)
    } else {

      # from sensor i-1 to sensor i
      wire_i <- wire(
        model = rope_type,
        length = metadata[i-1, ]$sensor_depth_m - metadata[i, ]$sensor_depth_m - inst_i@height)
    }

    ss[[j]] <- wire_i
    j <- j+ 1

    ss[[j]] <- inst_i
    j <- j + 1
  }

  # rope from shallowest sensor to the float
  ss[[j]] <- wire(model = rope_type, length = 0.05)
  ss[[j + 1]] <- float_type
  ss[["waterDepth"]] <- sounding_m

  m <- do.call(mooring, ss)

  m

  # could add plot and/or segmentize + current here.
  # leaving in the mooring package for now
}

# m <- model_mooring(station, depl_date)
#
# plot(m, fancy = TRUE)
#
# msk <- m |>
#   segmentize(by = 100)
#
# msk <- msk |>
#   knockdown(u = 0.5)
# plot(msk, fancy = TRUE)
#
#
# plot(m, fancy = TRUE, showDepths = TRUE)
