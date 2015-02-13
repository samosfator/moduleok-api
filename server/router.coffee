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
            scoresCount: @params.query.scoresCount

          if Ratings.find(userId: ratingDocument.userId).fetch().length < 1
            Ratings.insert ratingDocument
          else if ratingDocument.totalScore != 0
            Ratings.update userId: ratingDocument.userId,
              $set:
                totalScore: ratingDocument.totalScore
                scoresCount: ratingDocument.scoresCount

      @response.statusCode = 200
      @response.end "Happy Easter!"
      return
  return