Router.map ->
  @route '/api/:method',
    path: '/api/:method'
    where: 'server'
    action: ->
      switch @params.method
        when "getCurrentSemester"
          json = result: if moment().month() > 7 then 0 else 1

          @response.statusCode = 200
          @response.setHeader 'Content-Type', 'application/json'
          @response.end JSON.stringify json
      return
  return

Router.map ->
  @route '/api/rating/:method',
    path: '/api/rating/:method'
    where: 'server'
    action: ->
      switch @params.method
        when "postTotalScore"
          ratingDocument =
            userId: @params.query.userId
            group: @params.query.group
            totalScore: @params.query.totalScore

          if Ratings.find(userId: ratingDocument.userId).length() < 0
            Ratings.insert ratingDocument
          else
            Ratings.update userId: ratingDocument.userId,
              $set:
                totalScore: ratingDocument.totalScore

      @response.statusCode = 200
      @response.end "Happy Easter!"
      return
  return