@returnJson = (json) ->
  @response.statusCode = 200
  @response.setHeader 'Access-Control-Allow-Origin', '*'
  @response.setHeader 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept'
  @response.setHeader 'Content-Type', 'application/json; charset=utf-8'
  @response.end JSON.stringify json