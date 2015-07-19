app.factory "Property", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/properties/{{id}}"
    name: "property"
  )
]
