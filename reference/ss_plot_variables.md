# Exports figure of variable(s) at depth over time.

Output is not compatible with ggplot2 functions or ggplotly(). Use
[`ss_ggplot_variables()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_ggplot_variables.md)
to work with those functions.

## Usage

``` r
ss_plot_variables(
  dat,
  colour_palette = NULL,
  date_breaks_major = NULL,
  date_breaks_minor = NULL,
  date_labels_format = "%Y-%m-%d",
  standard_ylims = TRUE,
  ylims = NULL,
  yaxis_newline = FALSE,
  alpha = 1,
  legend_name = "Depth (m)",
  legend_position = "right"
)
```

## Arguments

- dat:

  Water Quality data in long or wide format.

- colour_palette:

  Colour palette of hex colours onto which `sensor_depth_at_low_tide_m`
  will be mapped. Default is `rev(viridis(6, option = "D"))`.

- date_breaks_major:

  Intervals for major breaks. Default is selected by
  `get_xaxis_breaks()`.

- date_breaks_minor:

  Intervals for minor breaks. Default selected by `get_xaxis_breaks()`.

- date_labels_format:

  Format for the date labels. Default is YYYY-mm-dd.

- standard_ylims:

  Logical argument indicating whether to use the standard y-limits from
  the controlled vocabulary (e.g., c(60, 160) for dissolved oxygen (%
  saturation), c(7.5, 8.5) for pH, and c(25, 34) for salinity). If
  `FALSE`, the y-limits are set to the `ggplot` default. Variables
  without standard limits (e.g., temperature) always use the `ggplot`
  default. Default is `TRUE`.

- ylims:

  Optional named list of custom y-limits. Each name must be a variable
  name (e.g., `"ph_ph"`) and each value a numeric vector of length 2.
  Use `NA` for one end to let `ggplot` choose it (e.g., `c(0, NA)`), or
  `NULL` to use the `ggplot` default for that variable. Custom limits
  replace the limits chosen by `standard_ylims` for the named variables
  only. Variables that are not in `dat` are ignored. Default is
  `ylims = NULL`.

- yaxis_newline:

  Logical argument indicating whether the units in the y-axis label
  should be on a new line. Default is `FALSE`.

- alpha:

  Value indicating the transparency of the points. 0 is most
  transparent; 1 is opaque.

- legend_name:

  Name for the legend. Must be a character string. Default is
  `legend_name = "Depth (m)"`.

- legend_position:

  Position for the legend. Passed to `patchwork`. Default is
  `legend_position = "right"`.

## Value

Returns a patchwork object, a single figure with the plots for each
variable in `dat` stacked in a column.

## Examples

``` r
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

ss_plot_variables(dat)


# the legend on the bottom, units on a second line, and custom DO limits
ss_plot_variables(
  dat,
  legend_position = "bottom",
  yaxis_newline = TRUE,
  ylims = list("dissolved_oxygen_percent_saturation" = c(100, 250))
)
#> Warning: Removed 84 rows containing missing values or values outside the scale range
#> (`geom_point()`).

# ggplot default y-limits for every variable
ss_plot_variables(dat, standard_ylims = FALSE)
```
