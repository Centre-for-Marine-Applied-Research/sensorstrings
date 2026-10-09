# October 6, 2026

ss_vars <- data.frame(
  variable = c(
    "temperature_degree_c",
    "dissolved_oxygen_percent_saturation",
    "dissolved_oxygen_uncorrected_mg_per_l",
    "dissolved_oxygen_mg_per_l",
    "ph_ph",
    "salinity_psu",
    "chlorophyll_blue_ug_per_l",
    "chlorophyll_red_ug_per_l",
    "sensor_depth_measured_m",
    "tilt_degree"
  ),

  label_new_line = c(
    "Temperature \n(\u00B0C)",
    "Dissolved Oxygen \n(% sat)",
    "Uncorrected \nDissolved Oxygen \n(mg/L)",
    "Dissolved Oxygen \n(mg/L)",
    "pH",
    "Salinity \n(PSU)",
    "Chlorophyll Blue \n(\u03BCg/L)",
    "Chlorophyll Red \n(\u03BCg/L)",
    "Sensor Depth \n(m)",
    "Tilt \n(\u00B0)"
  ),

  label_no_new_line = c(
    "Temperature (\u00B0C)",
    "Dissolved Oxygen (% sat)",
    "Uncorrected\nDissolved Oxygen (mg/L)",
    "Dissolved Oxygen (mg/L)",
    "pH",
    "Salinity (PSU)",
    "Chlorophyll Blue (\u03BCg/L)",
    "Chlorophyll Red (\u03BCg/L)",
    "Sensor Depth (m)",
    "Tilt (\u00B0)"
  ),

  report_entry = c(
    "temperature",
    "dissolved oxygen (% sat)",
    "unccorrected dissolved oxygen (mg/L)",
    "dissolved oxygen (mg/L)",
    "pH",
    "salinity",
    "chlorophyll blue",
    "chlorophyll red",
    "depth",
    "tilt"
  )
)

usethis::use_data(ss_vars, internal = TRUE, overwrite = TRUE)
