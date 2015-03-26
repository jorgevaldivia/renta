app.factory "Property", [
  "$resource", "currentAccount"
  ($resource, currentAccount) ->
    return $resource("/#{currentAccount.url_token}/properties/:id/.json", null,
      update:
        method: "PUT",
      query:  { method:'GET', isArray: false },
    )
]