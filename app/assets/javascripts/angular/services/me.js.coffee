app.factory "Me", [
  "$resource",
  ($resource) ->
    return $resource("/me", null)
]