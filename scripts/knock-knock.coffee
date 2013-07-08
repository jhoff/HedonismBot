# Description:
#   Have Hedonism play along to a knock knock joke.
#
# Commands:
#   hubot knock knock - hubot responds "Who's there?"

responses = [
  "Funny knock knock joke, bro!",
  "HAHAHAHAHAHA",
  "LOL",
  "heh heh",
  "You're dead to me"
  "*facepalm*",
  "http://i.stack.imgur.com/jiFfM.jpg",
  "http://i.imgur.com/WZ9v4k9.jpg"
]

module.exports = (robot) ->

  # Start the knock knock joke
  robot.respond /knock[\s,]+knock.*/i, (msg) ->
    robot.brain.set 'knockKnocking', 1
    msg.send "Who's there?"

  # If a knock knock joke has started, respond to the next two statements
  robot.hear /(.+)/, (msg) ->
    isKnocking = robot.brain.get('knockKnocking')

    # Second response 'xyz who?'
    if isKnocking is 2
      who = msg.match[1]
      msg.send "#{who} who?"

    # Final response
    if isKnocking is 3
      response = msg.random responses
      msg.send response
      robot.brain.set 'knockKnocking', 0

    # Increment knocking counter
    if isKnocking > 0
      robot.brain.set 'knockKnocking', isKnocking + 1


