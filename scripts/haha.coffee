# Description:
#   Responds to people laughing.
#

laughs = [
  "HAHAHAHAHAHA",
  "LOL",
  "heh heh",
  "http://i.imgur.com/WZ9v4k9.jpg"
]

module.exports = (robot) ->
  robot.hear /(^haha)|(^.+lol$)/i, (msg) ->
    lol = msg.random laughs
    msg.send lol

  robot.respond /want to hear something funny/i, (msg) ->
    user = msg.user.name
    msg.send "Fuck you #{user}"