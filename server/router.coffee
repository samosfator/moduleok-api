Router.map ->
  @route '/',
    path: '/'
    where: 'server'
    action: ->
      result =
        result:
          description: "JSON API for TNEU Apps"
          repo: "https://github.com/samosfator/moduleok-api"
      returnJson.call this, result

Router.map ->
  @route '/api/:method',
    path: '/api/:method'
    where: 'server'
    action: ->
      switch @params.method
        when "getCurrentSemester"
          result =
            result: if moment().month() > 7 then 0 else 1
          returnJson.call this, result

        when "getNews"
          query =
            page: @params.query.page or 1
            count: @params.query.count or 15
            fullText: @params.query.fullText or false

          ((that) ->
            Meteor.call "getNews", query, (err, result) ->
              returnJson.call that, result: err or result)(this)


@returnJson = (json) ->
  @response.statusCode = 200
  @response.setHeader 'Access-Control-Allow-Origin', '*'
  @response.setHeader 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept'
  @response.setHeader 'Content-Type', 'application/json; charset=utf-8'
  @response.end JSON.stringify json