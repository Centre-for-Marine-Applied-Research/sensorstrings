# Need this so that package will play nice with dplyr package
# https://community.rstudio.com/t/how-to-solve-no-visible-binding-for-global-variable-note/28887
# more technical solution here: https://cran.r-project.org/web/packages/dplyr/vignettes/programming.html

# other technical solution here:
# https://dplyr.tidyverse.org/articles/programming.html


utils::globalVariables(
  c(
    # ss_compile_hobo_data
    "variable",
    "sensor_serial_number",
    "sensor_type",
    "depth",
    "timestamp_",
    "deployment_range",

    # ss_compile_aquameasure_data
    "Sensor",
    "Temp(Water)",
    "Record Type",
    "Record Number",

    # "do_percent_saturation",
   # "dissolved_oxygen_percent_saturation",
    "temperature_degree_c",
    "sensor_depth_at_low_tide_m",
   # "sensor_depth_measured_m",

    # ss_compile_vemco_date
    "Description",
    "Units",
    "Data",

    # ss_compile_deployment_data
    "county",
    "waterbody",
    "station",
    "lease",
    "latitude",
    "longitude",

    # ss_read_log
    "numeric_depth",
    "log_sensor",
    "Waterbody",
    "string_configuration",
    "Depl_Date",

    # make_column_names
    "col_name",

    # ss_pivot
    "value",

    # ss_create_variable_labels
    "variable_label",
    "label_new_line",
    "label_no_new_line",

    # ss_generate_depl_filepath
    "depl_date",

    # ss_read_nsdfa_metadata
    "Depl_Lat",
    "Depl_Lon",
    "Recv_Date",

    # ss_export
    "timestamp_utc",

    # ss_write_report_table
    "Deployment Date",
    "Retrieval Date",
    "Latitude",
    "Longitude",
    "Station",
    "Depth (m)",
    "report_entry",

    # ss_check_station_locations
    "retrieval_latitude",
    "retrieval_longitude",

    #ss_coords_to_dd
    "deployment_latitude_n_ddm",
    "deployment_longitude_w_ddm",
    "coord_dm",

    ## ss_hobo_ph
    "ph_ph",
    "timestamp_ast/adt",
    "timestamp_at",
    "timestamp_adt",

    # ss_vr2ar
    "DEPTH_DESC",
    "Device Time (UTC)",
    "FIELD.6",
    "Model",
    "RECORD TYPE",
    "Serial Number",


    "region",

    # ss_model_mooring
    "anchor_weight_kg",
    "bottom_buoy_type",
    "deployment_date",
    "primary_buoy_type",
    "secondary_buoy_type",
    "vr2ar_lug_height_above_seafloor_m",

   # ss_create_log_from_metadata
   "retrieval_date",
   "deployment_latitude",
   "deployment_longitude",
   "sensor_depth_m"
  )
)
