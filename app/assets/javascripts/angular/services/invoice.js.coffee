app.factory "Invoice", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory(
    url: "/invoices/{{id}}"
    name: "invoice"
  )
]
