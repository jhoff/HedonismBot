# Description:
#   Have hubot say something for you in a room
#
# Commands:
#  :say <room> <statement>
#

module.exports = (robot) ->

  robot.respond /say (.+) (.+)/i, (msg) ->
    room = msg.match[1]
    statement = msg.match[2]

    if robot.adapter.say
      robot.adapter.say(room, statement)
