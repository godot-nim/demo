import gdext/buildconf

--path: src

let setting = BuildSettings(
  name: "MovementDemo",
)

configure(setting):
  [icons]
  PolygonClass = "res://addons/icons/polygon_nim.png"
