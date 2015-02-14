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

          Meteor.call "updateStudentsInfo", ratingDocument
          Meteor.call "updateGroupInfo", ratingDocument

          returnJson.call this, success: true
        when "getGroupsRating"
          returnJson.call this, Groups.find().fetch()
      return
  return