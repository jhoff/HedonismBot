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
    "Hi %! You're looking especially dapper today :)",
    "Oh, glorious day, % has arrived!",
    "%, I want you inside me",
    "%'s here! Consider the party started.",
    "My word, %, you are STUNNING today.",
    "%, I want to fall asleep inside you",
    "% is like, totes adorbs.",
    "Mmm, hello %, *smells index and middle finger*"
]

module.exports = (robot) ->
  robot.enter (response) ->
    yomama = response.random rude
    response.send yomama.replace "%", response.message.user.name
    robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);