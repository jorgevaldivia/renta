app.factory "Property", [
  "$resource",
  ($resource) ->
    return $resource("/properties/:id", null,
      update:
        method: "PATCH",
    )
]