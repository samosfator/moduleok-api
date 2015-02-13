Meteor.methods
  updateStudentsInfo: (ratingDocument) ->
    if Students.find(userId: ratingDocument.userId).fetch().length < 1
      Students.insert ratingDocument
    else if ratingDocument.totalScore != 0
      Students.update userId: ratingDocument.userId,
        $set:
          totalScore: ratingDocument.totalScore
          scoresCount: ratingDocument.scoresCount

  updateGroupInfo: (ratingDocument) ->
    groupData = Students.find(group: ratingDocument.group,
      totalScore: 1
      scoresCount: 1
      _id: 0
    ).fetch()

    groupTotalScore = _.chain(groupData)
      .map((item) -> parseInt item.totalScore, 10)
      .reduce((memo, num) ->
        memo + num
      , 0).value()
    groupScoresCount = _.chain(groupData)
      .map((item) -> parseInt item.scoresCount, 10)
      .reduce((memo, num) ->
        memo + num
      , 0).value()

    if Groups.find(name: ratingDocument.group).fetch().length < 1
      Groups.insert
        name: ratingDocument.group
        totalScore: groupTotalScore
        scoresCount: groupScoresCount
    else
      Groups.update name: ratingDocument.group,
        $set:
          totalScore: groupTotalScore
          scoresCount: groupScoresCount
