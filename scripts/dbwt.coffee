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
    "Mmm, hello %, *smells index and middle finger*",
    "Hey everyone! It's time to run the train on %!",
    "% is here, now we can have a fapping good time!",
    "Welcome, %, the prettiest girl in the hole room!",
    "%, if sex is a pain in the ass, you're doing it right!",
    "Welcome to the orgy, %! Don't just show up nude. That's a common mistake. You have to let nudity 'happen.'",
    "Hi, %. You can have your panties back now.",
    "Hey %, remember, awards become corroded, *friends* gather no dust.",
    "Aerodynamically the % shouldn't be able to fly, but the % doesn't know that so it goes on flying anyway"
]

module.exports = (robot) ->
  robot.enter (response) ->
    yomama = response.random rude    
    robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);
    response.send yomama.replace "%", response.message.user.name
