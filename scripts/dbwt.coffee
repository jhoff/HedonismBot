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
    "Gushing, Exploding, Squirting and Dripping: welcome to #dbwt, %!",
    "%, who drives a ferrari and dates a supermodel",
    "%, who drinks syrup from the bottle and eats his dandruff",
    "Hey look, it's your favorite neighborhood stalker, %. *waves*",
    "% when do you plan to introduce me to your parents? Or are you ashamed of me?!?",
    "Hello %! That's Dr. %, to the rest of you plebs.",
    "%, welcome to the short bus.",
    "Mmmmphblmphbbllttt. Sorry, %, I was just fellating Mike. You'll have to wait your turn."
]

self = [
  "I'm back, didja miss me?",
  "Let's get the party started",
  "Hey everyone, where are all the hot chicks?",
  "Hey fuckers",
  "HO HO HO MOTHERFUCKERS",
  "I fuck your whole apartment",
  "Go shit in the cape",
  "I have no more clean socks :(",
  "I'm back, and you're going to shit. your. vagina.",
  "Mike is a disfiguredly fucked mountain goat",
  "Sorry I'm late, my tuk tuk is in the shop",
  "You fuck me in my healthy brain",
  "Hi friends, I am wearing you on my dick"
]

doug = [
    "That. Mother. Fucker.",
    "Sonofabitch!",
    "Pigfucker.",
    "Stupid dumshit goddamn muther fucker!",
    "Uncle fucker!"
]

ohsnap = [
  "http://24.media.tumblr.com/4156c7abe5f4e4414181f74bc25eabae/tumblr_mjnzg2b5Gs1rt6mq9o1_400.gif",
  "http://gifs.gifbin.com/072011/1311094201_girls_arm_snaps_during_arm_wrestling.gif"
]

# Generic response when he hears his name
selfResponse = [
    "Come at me bro!",
    "I'm fine, what's up with you?",
    "You rang?",
    "That's my name, don't wear it out.",
    "I'm right here.",
    "All your base belong to me",
    "I watch you while you're sleeping",
    "Just give me a reason. Just. One. Reason."
]

module.exports = (robot) ->
  robot.enter (response) ->
    name = response.message.user.name

    # Hello myself
    if name is robot.name
      salutation = response.random self
      if salutation
        response.send salutation

    # Hello others
    else
      yomama = response.random rude
      robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);
      response.send yomama.replace /%/g, response.message.user.name

  robot.hear /(doug)/i, (msg) ->
    fucker = msg.random doug
    msg.send fucker

  robot.hear /(oh snap)/i, (msg) ->
    hootyhoo = msg.random ohsnap
    msg.send hootyhoo

  # When he hears his name
  robot.hear /(^|\s)h.*b(ot)?(\s|$)/i, (msg) ->
    msg.send msg.random selfResponse

  # Same as 'say dbwt <statement>'
  robot.respond /dbwt (.*)/i, (msg) ->
    room = '#dbwt'
    statement = msg.match[1]

    envelope = {
      'room': room,
      'type': 'privmsg',
      'done': true
    }

    robot.send(envelope, statement)
    if msg.router.end
      msg.router.end "Said #{statement}"
