# Description:
#   Hopefully this gives hubot the ability to grant chanops
#
# opme.coffee

module.exports = (robot) ->
  robot.enter (response) ->
    robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);

# module.exports = (robot) ->
#   robot.respond /op me/i, (msg) ->
#     robot.adapter.command('MODE', msg.message.user.room, '+o', msg.message.user.name);
#   robot.respond /deop me/i, (msg) ->
#     robot.adapter.command('MODE', msg.message.user.room, '-o', msg.message.user.name);