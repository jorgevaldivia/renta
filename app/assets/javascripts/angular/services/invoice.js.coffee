app.factory "Invoice", [
  "$resource"
  ($resource) ->
    return $resource("/080070c44a/invoices/:id/.json", null,
      update:
        method: "PUT",
      query:  { method:'GET', isArray: false },
    )
]