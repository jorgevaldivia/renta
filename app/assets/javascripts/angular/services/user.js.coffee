app.factory "User", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/users"
    name: "user"
  )
]
