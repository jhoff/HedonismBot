# Description:
#   Get a stock price
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot stock <info|quote|price> for <ticker> - Get a stock price
#
# Author:
#   eliperkins

module.exports = (robot) ->

  checkStock = (symbol) ->
    symbol = escape(symbol)
    msg.http('http://finance.google.com/finance/info?client=ig&q=' + symbol)
    .get() (err, res, body) ->
      result = JSON.parse(body.replace(/\/\/ /, ''))

      message = result[0].e + ":" + result[0].t + " - " + result[0].l_cur + " (#{result[0].c})"
      message += " | After hours: " + result[0].el_cur if result[0].el_cur
      msg.send message

  robot.respond /stock( info| price| quote)?( for)? @?([\w .-_]+)/i, (msg) ->
    checkStock msg.match[3]    

  robot.respond /stock$/i, (msg) ->
    checkStock "lnkd"
