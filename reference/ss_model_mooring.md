# Model sensor string

Generates a mooring object, which can be used with the `mooring` package
to assess current knockdown and tension on the line (e.g., required
anchor weight).

## Usage

``` r
ss_model_mooring(
  station,
  depl_date,
  metadata = NULL,
  rope_type = "3/8in leaded polypropylene"
)
```

## Arguments

- station:

  Character string. Station name, as it appears in `metadata`.

- depl_date:

  Character string of the deployment date, in the order "yyyy-mm-dd".

- metadata:

  Default `NULL` will read in the metadata tracking sheet from the CMAR
  shared drive (user must be connected to the Perennia VPN). Otherwise,
  a dataframe with the relevant columns may be included (instrument,
  sensor_depth_m, sounding_m, vr2ar_lug_height_above_seafloor_m,
  anchor_type, float_type). Instrument, anchor type, and float_type must
  be compatible with the `mooring` package.

- rope_type:

  Character string. Default is "3/8in leaded polypropylene". Must be
  compatible with the `mooring` package.

## Value

A mooring object. Can be used with the functions in the mooring package.

## Details

For details on the model, see help files for the `mooring` package.

With the default arguments, string model is built using information from
the metadata tracking sheet (sensor types and depth, anchor and float
type).

Assumptions:

In the case where a hobo sensor was attached to the VR2AR sensor, the
hobo sensor is not included.

Does not distinguish between VR2AR and VR2AR-X sensors.

The bottom float is NOT included.

The rope length from the float to the shallowest sensor is hard-coded at
0.05 m.

If the sounding is shallower than the deepest sensor, the sounding is
set to the deepest depth + 2 m.
