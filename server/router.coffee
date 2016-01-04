Router.map ->
  @route '/',
    path: '/'
    where: 'server'
    action: ->
      returnJson.call @, {
        description: 'JSON API for TNEU Apps'
        repo: 'https://github.com/vladgolubev/moduleok-api'
      }

  @route '/api/:method',
    path: '/api/:method'
    where: 'server'
    action: ->
      switch @params.method
        when 'getNews'
          query =
            page: @params.query.page or 1
            count: @params.query.count or 15
            fullText: @params.query.fullText or false

          Meteor.call 'getNews', query, (err, result) =>
            returnJson.call @, {result: err or result}


@returnJson = (json) ->
  @response.statusCode = 200
  @response.setHeader 'Access-Control-Allow-Origin', '*'
  @response.setHeader 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept'
  @response.setHeader 'Content-Type', 'application/json; charset=utf-8'
  @response.end JSON.stringify json