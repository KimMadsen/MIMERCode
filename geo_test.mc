// geo_test.mc - Test geographic functions
// Copyright 2026 Components4Developers - Kim Bo Madsen

program GeoTest
  // ---- Geodesic ----
  WriteLn("--- Geodesic ---")

  // Copenhagen to New York
  var CPH_LAT := 55.6761
  var CPH_LON := 12.5683
  var NYC_LAT := 40.7128
  var NYC_LON := -74.0060

  var Dist := geo_distance(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON)
  WriteLn(f"Copenhagen to NYC: {Round(Dist)} km")

  var Brg := geo_bearing(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON)
  WriteLn(f"Bearing CPH->NYC: {Round(Brg)} degrees")

  var Mid := geo_midpoint(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON)
  WriteLn(f"Midpoint: lat={Mid['lat']}, lon={Mid['lon']}")

  // Destination: 100km due east from Copenhagen
  var Dest := geo_destination(CPH_LAT, CPH_LON, 90, 100)
  WriteLn(f"100km East of CPH: lat={Dest['lat']}, lon={Dest['lon']}")

  // Interpolate: 25% along CPH->NYC
  var Q1 := geo_interpolate(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON, 0.25)
  WriteLn(f"25% CPH->NYC: lat={Q1['lat']}, lon={Q1['lon']}")

  // Great circle arc
  var Arc := geo_great_circle(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON, 5)
  WriteLn(f"Great circle (6 pts): {Length(Arc)} points")
  WriteLn(f"  Start: lat={Arc[0]['lat']}, lon={Arc[0]['lon']}")
  WriteLn(f"  End:   lat={Arc[5]['lat']}, lon={Arc[5]['lon']}")
  WriteLn("")

  // ---- Projection ----
  WriteLn("--- Projection ---")
  var Bounds := [-180, -85, 180, 85]

  // Project Copenhagen
  var Px := geo_mercator(CPH_LAT, CPH_LON, 800, 500, Bounds)
  WriteLn(f"CPH pixel: x={Round(Px['x'])}, y={Round(Px['y'])}")

  // Project NYC
  var Px2 := geo_mercator(NYC_LAT, NYC_LON, 800, 500, Bounds)
  WriteLn(f"NYC pixel: x={Round(Px2['x'])}, y={Round(Px2['y'])}")

  // Round-trip: project then unproject
  var Back := geo_mercator_inv(Px['x'], Px['y'], 800, 500, Bounds)
  WriteLn(f"Round-trip CPH: lat={Back['lat']}, lon={Back['lon']}")
  WriteLn(f"  Match: {near(Back['lat'], CPH_LAT, 0.01) and near(Back['lon'], CPH_LON, 0.01)}")

  // Equator/prime meridian should be center
  var Center := geo_mercator(0, 0, 800, 500, Bounds)
  WriteLn(f"Equator/PM: x={Round(Center['x'])}, y={Round(Center['y'])}")
  WriteLn("")

  // ---- Geometry ----
  WriteLn("--- Geometry ---")

  // Triangle around Denmark
  var Triangle := [
    dict{"lat": 57.75, "lon": 10.0},
    dict{"lat": 55.0, "lon": 8.0},
    dict{"lat": 55.0, "lon": 13.0}
  ]
  var Area := geo_area(Triangle)
  WriteLn(f"Triangle area: {Round(Area)} km2")

  var Cen := geo_centroid(Triangle)
  WriteLn(f"Centroid: lat={Cen['lat']}, lon={Cen['lon']}")

  var Bnd := geo_bounds(Triangle)
  WriteLn(f"Bounds: {Bnd['min_lat']}-{Bnd['max_lat']} lat, {Bnd['min_lon']}-{Bnd['max_lon']} lon")

  // Point in polygon: Aarhus (56.15, 10.21) should be inside
  WriteLn(f"Aarhus in triangle: {geo_contains(Triangle, 56.15, 10.21)}")
  // London should be outside
  WriteLn(f"London in triangle: {geo_contains(Triangle, 51.5, -0.12)}")
  WriteLn("")

  // ---- Conversion ----
  WriteLn("--- Conversion ---")
  WriteLn(f"Marathon: {geo_km_to_miles(42.195)} miles")
  WriteLn(f"100 miles: {geo_miles_to_km(100)} km")
  WriteLn(f"DMS 55d 40m 34s = {geo_dms(55, 40, 34)} degrees")
  WriteLn("")

  // ---- Identity checks ----
  WriteLn("--- Identity checks ---")
  // Distance A->B = Distance B->A
  var D1 := geo_distance(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON)
  var D2 := geo_distance(NYC_LAT, NYC_LON, CPH_LAT, CPH_LON)
  WriteLn(f"dist symmetry: {near(D1, D2)}")

  // Interpolate at 0 = start, at 1 = end
  var P0 := geo_interpolate(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON, 0)
  var P1 := geo_interpolate(CPH_LAT, CPH_LON, NYC_LAT, NYC_LON, 1)
  WriteLn(f"interp(0) = start: {near(P0['lat'], CPH_LAT, 0.001)}")
  WriteLn(f"interp(1) = end: {near(P1['lat'], NYC_LAT, 0.001)}")

  // km -> miles -> km round trip
  WriteLn(f"km round-trip: {near(geo_miles_to_km(geo_km_to_miles(42.195)), 42.195)}")
end
