app.factory "Lease", [
  "$resource", "currentAccount"
  ($resource, currentAccount) ->
    return $resource("/#{currentAccount.url_token}/leases/:id/.json", null,
      update:
        method: "PUT",
      query:  { method:'GET', isArray: false },
    )
]