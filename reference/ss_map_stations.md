# Interactive map of station location(s)

Interactive map of station location(s)

## Usage

``` r
ss_map_stations(dat)
```

## Arguments

- dat:

  Data frame with columns `longitude`, `latitude`, `station`.

## Value

A leaflet object.

## Examples

``` r
if (requireNamespace("leaflet", quietly = TRUE)) {
  stations <- data.frame(
    station = c("Borgles Island", "Birchy Head"),
    latitude = c(44.77241, 44.5701),
    longitude = c(-62.72608, -64.034383)
  )

  # the map tiles load when the map is viewed (needs internet)
  ss_map_stations(stations)
}

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addProviderTiles","args":["Esri.OceanBasemap",null,null,{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addCircleMarkers","args":[[44.77241,44.5701],[-62.72608,-64.03438300000001],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":1,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.75},null,null,null,null,["Borgles Island","Birchy Head"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addScaleBar","args":[{"maxWidth":100,"metric":true,"imperial":false,"updateWhenIdle":true,"position":"bottomleft"}]}],"limits":{"lat":[44.5701,44.77241],"lng":[-64.03438300000001,-62.72608]}},"evals":[],"jsHooks":[]}
```
