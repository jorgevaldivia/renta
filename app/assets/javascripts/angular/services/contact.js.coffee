app.factory "Contact", [
  "$resource", "currentAccount"
  ($resource, currentAccount) ->
    return $resource("/#{currentAccount.url_token}/contacts/:id/.json", null,
      update:
        method: "PUT",
      query:  { method:'GET', isArray: false },
    )
]