app.factory "Me", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/me"
    name: "me"
  )
]
