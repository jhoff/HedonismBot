# Description:
#   Have hubot say something for you in a room
#
# Commands:
#  :say <room> <statement>
#

module.exports = (robot) ->

  robot.respond /say ([^\s]+) (.+)/i, (msg) ->
    room = msg.match[1]
    message = msg.match[2]

    envelope = {
      'room': room,
      'type': 'privmsg',
      'done': true
    }
    envelope.room = room
    envelope.type = 'privmsg'

    robot.send(envelope, message)

    if msg.router.end
      msg.router.end "Said #{message}"
