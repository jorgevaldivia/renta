app.factory "Lease", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/properties/{{property_id}}/leases/{{id}}"
    name: "lease"
  )
]
