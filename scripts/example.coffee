#-------------------------------------------------------------------------------
# Bot can tell you more about the day
#-------------------------------------------------------------------------------

module.exports = (robot) ->
  robot.hear /today/i, (res) ->
    robot.http("https://www.checkiday.com/api/3/?d=today")
      .header('Accept', 'application/json')
      .get() (err, httpRes, body) ->
        if httpRes.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :lion_face:"
          return

        data = JSON.parse body
        res.send "Date: #{data.date}"
        for i in data.holidays
          do (i) ->
            res.send "Today is #{i.name}!\n (#{i.url})\n\n"
        return
