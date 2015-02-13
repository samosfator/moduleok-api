Router.map ->
  @route '/api/:method',
    path: '/api/:method'
    where: 'server'
    action: ->
      @response.statusCode = 200
      @response.setHeader 'Access-Control-Allow-Origin', '*'
      @response.setHeader 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept'

      switch @params.method
        when "getCurrentSemester"
          json = result: if moment().month() > 7 then 0 else 1

          @response.setHeader 'Content-Type', 'application/json; charset=utf-8'
          @response.end JSON.stringify json
      return
  return

Router.map ->
  @route '/api/rating/:method',
  path: '/api/rating/:method'
  where: 'server'
  action: ->
    @response.statusCode = 200
    @response.setHeader 'Access-Control-Allow-Origin', '*'
    @response.setHeader 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept'

    switch @params.method
      when "postTotalScore"
        ratingDocument =
          userId: @params.query.userId
          group: @params.query.group
          totalScore: @params.query.totalScore
          scoresCount: @params.query.scoresCount

        Meteor.call "updateStudentsInfo", ratingDocument
        Meteor.call "updateGroupInfo", ratingDocument

        @response.end "Happy Easter!"
      when "getGroupsRating"
        @response.setHeader 'Content-Type', 'application/json; charset=utf-8'
        @response.end JSON.stringify Groups.find().fetch()
    return
  return