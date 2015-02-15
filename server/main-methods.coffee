Meteor.methods
  getNews: (query) ->
    try
      newsUrl = "http://www.tneu.edu.ua/news/page/#{query.page}/"

      cheerio = Meteor.npmRequire("cheerio")
      $ = cheerio.load HTTP.get(newsUrl).content

      #example: 13-02-2015
      yesterdayDate = "#{moment().subtract(1, "days").format("DD")}-
                  #{moment().format("MM")}-
                  #{moment().year()}".replace /\s/g, ""

      news = $(".short-1").slice(0, query.count).map(->
        post =
          title: $(this).find(".short-1-title a").text().replace /«|»/g, ""
          date: $(this).find(".short-2-date").text().replace("Вчера", yesterdayDate)
          description: $(this).find(".short-1-text p").text()
          image: $(this).find(".short-1-text p a").attr("href")
          readMoreLink: $(this).find(".short-1-text .short-1-more a").attr("href")

        post[key] = value?.trim() for own key, value of post

        if query.fullText
          $_postPage = cheerio.load HTTP.get(post.readMoreLink).content

          postHasAttachments = $_postPage('.attachment a').length > 0
          postHasPhotos = $_postPage(".photonews a").length > 0

          post.fullText =
            $_postPage(".shot-text div").eq(0).find("p").map(->
              $_postPage(this).text()?.trim()
            ).filter(-> this.length > 0).get().join "\\n"

          if postHasPhotos
            post.photos = $_postPage(".photonews a").map(-> $_postPage(this).attr "href").get()

          if postHasAttachments
            post.attachments = $_postPage('.attachment a').map(->
              attachment =
                name: $_postPage(this).text()
                link: $_postPage(this).attr "href"
            ).get()

        return post
      ).get()
      return news
    catch error
      throw new Meteor.Error error.message, error.reason