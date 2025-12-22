# Exports figure of variable(s) at depth over time.

Output is not compatible with ggplot2 functions or ggplotly(). Use
[`ss_ggplot_variables()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_ggplot_variables.md)
to work with those functions.

## Usage

``` r
ss_plot_variables(
  dat,
  title = "",
  color_palette = NULL,
  date_breaks_major = NULL,
  date_breaks_minor = NULL,
  date_labels_format = "%Y-%m-%d",
  standard_do_ylims = TRUE,
  standard_sal_ylims = TRUE,
  yaxis_newline = FALSE,
  alpha = 1,
  legend_name = "Depth (m)",
  legend_position = "right"
)
```

## Arguments

- dat:

  Water Quality data in long or wide format.

- title:

  Title for plot. Default is no title.

- color_palette:

  Color palette of hex colors onto which `sensor_depth_at_low_tide_m`
  will be mapped. Required if there are more than 6 levels in
  `sensor_depth_at_low_tide_m`. Default is
  `pal = rev(viridis(6, option = "D"))`.

- date_breaks_major:

  Intervals for major breaks. Default is selected by
  `get_xaxis_breaks()`.

- date_breaks_minor:

  Intervals for minor breaks. Default selected by `get_xaxis_breaks()`.

- date_labels_format:

  Format for the date labels. Default is YYYY-mm-dd.

- standard_do_ylims:

  If `TRUE`, the y-limits for dissolved oxygen are set to c(60, 130) %
  or c(0, 15) mg/L. If `FALSE`, the y-limits are set to the `ggplot`
  default. Alternatively, a vector giving custom y-limits for the
  dissolved oxygen panel.

- standard_sal_ylims:

  If `TRUE`, the y-limits for salinity are set to c(0, 35) PSU. If
  `FALSE`, the y-limits are set to the `ggplot` default. Alternatively,
  a vector giving custom y-limits for the salinity panel.

- yaxis_newline:

  Logical argument indicating whether the units in the y-axis label
  should be on a new line. Default is `TRUE`.

- alpha:

  Value indicating the transparency of the points. 0 is most
  transparent; 1 is opaque.

- legend_name:

  Name for the legend. Must be a character string. Default is
  `legend.name = "Depth (m)"`.

- legend_position:

  Position for the legend. Passed to `ggpubr`. Default is
  `legend.position = "right"`.

## Value

Returns \* object, a single figure with the plots for each variable in
`tidy.data` stacked in a column is returned.

## See also

Other plot:
[`ss_get_colour_palette()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_get_colour_palette.md)

## Author

Danielle Dempsey
