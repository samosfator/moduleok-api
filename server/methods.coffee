Meteor.methods
  getNews: (query) ->
    try
      newsUrl = "http://www.tneu.edu.ua/news/page/#{query.page}/"

      $ = cheerio.load HTTP.get(newsUrl).content

      #example: 13-02-2015
      yesterdayDate = "#{moment().subtract(1, "days").format("DD")}-
                  #{moment().format("MM")}-
                  #{moment().year()}".replace /\s/g, ""

      news = $("#dle-content .well").slice(0, query.count).map(->
        post =
          title: $(this).find("h4").text().replace /«|»/g, ""
          date: $(this).find(".highlight").text().replace("Вчера", yesterdayDate).replace("Дата: ", "")
          description: $(this).find(".timg").text()
          image: $(this).find(".highslide").attr("href")
          readMoreLink: $(this).find("div[style=\"text-align: right;\"] a").attr("href")

        post[key] = value?.trim() for own key, value of post

        if query.fullText is "true"
          $_postPage = cheerio.load HTTP.get(post.readMoreLink).content

          postHasAttachments = $_postPage('.attachment a').length > 0
          postHasPhotos = $_postPage(".photonews a").length > 0

          post.fullText =
            $_postPage("#article .timg").eq(0).map(->
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