# Description:
#   Have hubot say something for you in a room
#
# Commands:
#  :say <room> <statement>
#

module.exports = (robot) ->

  robot.respond /say ([^\s]+) (.+)/i, (msg) ->
    room = msg.match[1]
    statement = msg.match[2]

    # Add hash to room
    if room.charAt(0) != '#'
      room = '#'+ room

    envelope = {}
    envelope.room = room

    robot.send(envelope, statement)
