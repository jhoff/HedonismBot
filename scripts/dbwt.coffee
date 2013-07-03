# Description:
#   Hopefully this gives hubot the ability to grant chanops
#
# opme.coffee
#
# First draft:
# module.exports = (robot) ->
#   robot.respond /op me/i, (msg) ->
#     robot.adapter.command('MODE', msg.message.user.room, '+o', msg.message.user.name);
#   robot.respond /deop me/i, (msg) ->
#     robot.adapter.command('MODE', msg.message.user.room, '-o', msg.message.user.name);

rude = [
    "%s mama is so fat, I took a picture of her last christmas, and its still printing",
    "%s mama is so fat, her belly button gets home 15 minutes before she does",
    "% may look like an idiot and talk like an idiot but don't let that fool you. He really is an idiot."
]

module.exports = (robot) ->
  robot.enter (response) ->
    yomama = response.random rude
    response.send yomama.replace "%", response.message.user.name
    robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);