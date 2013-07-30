# Description:
#   Responds to people laughing.
#

laughs = [
  "HAHAHAHAHAHA",
  "LOL",
  "heh heh",
  "ROFLMAO"
]

module.exports = (robot) ->
  robot.hear /(^haha)|(^.+lol$)/i, (msg) ->
    lol = msg.random laughs
    msg.send lol

  robot.respond /want to hear something funny/i, (msg) ->
    user = msg.message.user.name
    msg.send "Fuck you #{user}"