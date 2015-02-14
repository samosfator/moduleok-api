Router.map ->
  @route '/',
    path: '/'
    where: 'server'
    action: ->
      result = result:
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
          result = result: if moment().month() > 7 then 0 else 1
          returnJson.call this, result

        when "getNews"
          query =
            limit: @params.query.limit
            limit: @params.query.limit