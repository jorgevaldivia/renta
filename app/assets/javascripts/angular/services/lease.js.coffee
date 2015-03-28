app.factory "Lease", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/properties/{{property_id}}/leases"
    name: "lease"
  )
]
