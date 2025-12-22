# Package index

## All functions

- [`add_deployment_columns()`](https://dempsey-cmar.github.io/sensorstrings/reference/add_deployment_columns.md)
  : Add and reorder columns

- [`check_n_rows()`](https://dempsey-cmar.github.io/sensorstrings/reference/check_n_rows.md)
  : Check number of rows of data file

- [`convert_timestamp_to_datetime()`](https://dempsey-cmar.github.io/sensorstrings/reference/convert_timestamp_to_datetime.md)
  : Convert timestamp to datetime

- [`extract_aquameasure_tz()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_aquameasure_tz.md)
  : Extract the timezone of aquameasure timestamps

- [`extract_aquameasure_vars()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_aquameasure_vars.md)
  : Extract the variables included in aquameasure file from the column
  names

- [`extract_deployment_dates()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_deployment_dates.md)
  : Extract deployment dates

- [`extract_file_extension()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_file_extension.md)
  : Extracts the extension of a file name

- [`extract_hobo_ph_units()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_hobo_ph_units.md)
  : Extract units from column names of hobo pH data

- [`extract_hobo_sn()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_hobo_sn.md)
  : Extract hobo serial number from the data file

- [`extract_hobo_units()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_hobo_units.md)
  : Extract units from column names of hobo data

- [`extract_vemco_tz()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_vemco_tz.md)
  : Extract the timezone of vemco timestamps

- [`filter_dat_to_plot()`](https://dempsey-cmar.github.io/sensorstrings/reference/filter_dat_to_plot.md)
  : Filter data before plotting to zoom in on interesting features

- [`make_column_names()`](https://dempsey-cmar.github.io/sensorstrings/reference/make_column_names.md)
  : Paste variable name and units to create column names

- [`set_up_compile()`](https://dempsey-cmar.github.io/sensorstrings/reference/set_up_compile.md)
  :

  Set up parameters, Errors, and Warnings for the `compile_**` functions

- [`ss_assemble_region_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_assemble_region_data.md)
  : Assemble region data

- [`ss_check_station_drift()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_check_station_drift.md)
  : Check station deployment and retrieval locations are within
  acceptable distance

- [`ss_check_station_in_ocean()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_check_station_in_ocean.md)
  : Check station location is in the ocean (not on land)

- [`ss_check_station_radius()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_check_station_radius.md)
  : Check station location is within buffer of official coordinates

- [`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md)
  : Compile data from aquameasure sensors

- [`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md)
  : Compile aquameasure, hobo, tidbit, and vemco data from a single
  deployment

- [`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md)
  : Compile and format data from hobo or tidbit sensors

- [`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md)
  : Compile and format data from hobo pH sensors (MX2501)

- [`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md)
  : Format temperature data from Vemco deployment

- [`ss_convert_depth_to_ordered_factor()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_convert_depth_to_ordered_factor.md)
  : Converts values in the depth column to an ordered factor

- [`ss_convert_old_log()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_convert_old_log.md)
  : Convert column names from old log into the new format

- [`ss_coords_from_ddm_to_dd()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_coords_from_ddm_to_dd.md)
  : Convert coordinates from degree-minute-decimal to decimal degree

- [`ss_create_log_from_metadata()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_create_log_from_metadata.md)
  : Writes a deployment log from the metadata tracking sheet

- [`ss_create_old_log_from_metadata()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_create_old_log_from_metadata.md)
  : Writes a deployment log from the metadata tracking sheet

- [`ss_create_variable_labels()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_create_variable_labels.md)
  : Create plot labels from variable names

- [`ss_create_variable_labels_no_newline()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_create_variable_labels_no_newline.md)
  : Create plot labels from variable names without new lines

- [`ss_download_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_download_data.md)
  : Download deployment data from Google drive to the shared CMAR server

- [`ss_export_county_files()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_export_county_files.md)
  : Export data into a csv and/or rds file

- [`ss_export_path()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_export_path.md)
  : Generate file path and name to export compiled sensor string data

- [`ss_get_colour_palette()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_get_colour_palette.md)
  : Returns colour palette based on the unique values of
  sensor_depth_at_low_tide_m

- [`ss_ggplot_variables()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_ggplot_variables.md)
  : Plot variables at depth

- [`ss_import_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_import_data.md)
  : Import Water Quality data from rds files

- [`ss_import_path()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_import_path.md)
  : Generate file path to import raw sensor string deployment data

- [`ss_leaflet_station_map()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_leaflet_station_map.md)
  : Interactive map of station location

- [`ss_open_trimdates_app()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_open_trimdates_app.md)
  : Open interactive plot

- [`ss_parse_log()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_parse_log.md)
  : Extract information from deployment log

- [`ss_pivot_longer()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_pivot_longer.md)
  : Pivot sensor string data from long to wide format

- [`ss_pivot_wider()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_pivot_wider.md)
  : Pivot sensor string data from wide to long format

- [`ss_plot_variables()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_plot_variables.md)
  : Exports figure of variable(s) at depth over time.

- [`ss_read_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_aquameasure_data.md)
  : Import data from aquameasure csv files

- [`ss_read_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_hobo_data.md)
  : Import data from hobo or tidbit csv file

- [`ss_read_log()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log.md)
  : Read in deployment log

- [`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)
  : Extract information from old deployment log

- [`ss_read_nsdfa_metadata()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_nsdfa_metadata.md)
  : Import TempMetaData tab from the NSDFA tracking sheet

- [`ss_read_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_vemco_data.md)
  : Import data from vemco csv files

- [`ss_reformat_old_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_reformat_old_data.md)
  : Convert old data structure to sensorstrings format

- [`ss_set_up_folders()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_set_up_folders.md)
  : Create folders for the raw sensor string data from a given
  deployment

- [`ss_write_report_table()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_write_report_table.md)
  : Writes deployment table for county report

- [`ss_xaxis_breaks()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_xaxis_breaks.md)
  : Returns nice major and minor breaks and label format based on
  timespan of the data

- [`trim_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/trim_data.md)
  : Trim data to specified start and end dates.
