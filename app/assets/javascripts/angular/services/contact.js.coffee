app.factory "Contact", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/contacts/{{id}}"
    name: "contact"
  )
]
