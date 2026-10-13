# Plot variables at depth

Plot variables at depth

## Usage

``` r
ss_ggplot_variables(
  dat,
  superchill = NULL,
  colour_palette = NULL,
  colour_col = "sensor_depth_at_low_tide_m",
  legend_name = "Depth (m)",
  legend_position = "right",
  date_breaks_major = NULL,
  date_breaks_minor = NULL,
  date_labels_format = "%Y-%m-%d",
  yaxis_newline = FALSE,
  point_size = 0.25,
  convert_sn_to_factor = TRUE
)
```

## Arguments

- dat:

  Data frame of sensor string data in wide or long format.

- superchill:

  Logical argument indicating whether to adding shading to indicate
  temperatures below the superchill threshold (\<= - 0.7 degrees C). If
  `superchill = NULL` (the default), shading will be applied if any
  temperature values are less than or equal to the threshold.

- colour_palette:

  Optional vector of hex colors onto which depth will be mapped.

- colour_col:

  Character string indicating the column to use to colour the
  observations.

- legend_name:

  Name for the depth legend. Default is `legend_name = "Depth (m)"`.

- legend_position:

  Position for the depth legend. Default is `legend_position = "right"`.

- date_breaks_major:

  Intervals for major breaks. Default is selected by
  `get_xaxis_breaks()`.

- date_breaks_minor:

  Intervals for minor breaks. Default selected by `get_xaxis_breaks()`.

- date_labels_format:

  Format for the date labels. Default is YYYY-mm-dd.

- yaxis_newline:

  Logical argument indicating whether the units in the y-axis label
  should be on a new line. Default is `FALSE`.

- point_size:

  Numeric value indicating size of points.

- convert_sn_to_factor:

  Logical argument indicating whether to convert column
  `sensor_serial_number` to a factor. Only used when
  `colour_col = "sensor_serial_number"`. Set to `FALSE` if making
  separate plots with some overlapping serial numbers. In this case, the
  `sensor_serial_number` should be converted to a factor before calling
  the plot function.

## Value

Returns a ggplot object of ocean variables plotted over time and
coloured by sensor depth.

## Examples

``` r
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

ss_ggplot_variables(dat)


# colour by sensor serial number, with larger points and the legend on the
# bottom

ss_ggplot_variables(
  dat,
  colour_col = "sensor_serial_number",
  legend_name = "Serial number",
  legend_position = "bottom",
  point_size = 1
)


# a ggplot object, so it can be changed with ggplot2 functions
p <- ss_ggplot_variables(dat, date_breaks_major = "1 month")
p + ggplot2::ggtitle("Borgles Island")
```
