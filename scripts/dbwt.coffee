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
    "% may look like an idiot and talk like an idiot but don't let that fool you. He really is an idiot.",
    "%'s mind is so open - so open that ideas simply pass through it.",
    "%, are you always this stupid or are you making a special effort today",
    "%, brains aren't everything. In fact in your case they're nothing",
    "% always finds himself lost in thought - it's an unfamiliar territory",
    "% doesn't know the meaning of the word "fear" - but then again he doesn't know the meaning of most words",
    "%, I don't know what makes you so dumb but it really works",
    "%, I don't think you are a fool, but what's my opinion compared to that of thousands of others",
    "% does the work of three men: Larry, Curly & Moe",
    "%, oh my God, look at you. Anyone else hurt in the accident?",
    "%, like a death at a birthday party, you ruin all the fun... Like a sucked and spat out smartie, you're no use to anyone.",
    "% has a face like a Saint - A Saint Bernard.",
    "% loves 'NATURE' - In spite of what it did to him.",
    "%, who picks your clothes - Stevie Wonder?",
    "%, can I borrow your face for a few days? My ass is going on holiday.",
    "See, that's what's meant by dark and handsome. When it's dark, % is handsome.",
    "%, do you still love nature, despite what it did to you?",
    "%, don't you need a license to be that ugly?",
    "%, every person has the right to be ugly, but you abused the privilege!",
    "%, I've seen people like you before, but I had to pay admission!"
]

module.exports = (robot) ->
  robot.enter (response) ->
    yomama = response.random rude
    response.send yomama.replace "%", response.message.user.name
    robot.adapter.command('MODE', response.message.user.room, '+o', response.message.user.name);