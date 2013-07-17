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
    "Aerodynamically the % shouldn't be able to fly, but the % doesn't know that so it goes on flying anyway",
    "%, sudo make me a sandwich!",
    "%, when God gives you lemons, you find a new God",
    "% is here, time to make it rain",
    "Hi %! Have you seen the copious volume of my ejaculate? Would you like to learn how to produce more and impress any girl?",
    "%, my hot jack hammer rocked the hell out of Minnie. It could do you too ;)",
    "Coming up next, %, 3-legged babes show off their tools! Be sure to stick around.",
    "% is the obvious choice for adult pleasure.",
    "Gushing, Exploding, Squirting and Dripping: welcome to #dwbt, %!",
    "%, who drives a ferrari and dates a supermodel",
    "%, who drinks syrup from the bottle and eats his dandruff",
    "Hey look, it's your favorite neighborhood mongoloid, %. *waves*",
    "% when do you plan to introduce me to your parents? Or are you ashamed of me?!?",
    "Hello %! That's Dr. %, to the rest of you plebs."
]

doug = [
    "That. Mother. Fucker.",
    "Sonofabitch!",
    "Pigfucker.",
    "Stupid dumshit goddamn muther fucker!",
    "Uncle fucker!"
]

module.exports = (robot) ->
  robot.enter (response) ->
    yomama = response.random rude
    robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);
    response.send yomama.replace /%/g, response.message.user.name

  robot.hear /(doug)/i, (msg) ->
    fucker = msg.random doug
    msg.send fucker

  robot.hear /(oh snap)/i, (msg) ->
    msg.send "http://24.media.tumblr.com/4156c7abe5f4e4414181f74bc25eabae/tumblr_mjnzg2b5Gs1rt6mq9o1_400.gif"
