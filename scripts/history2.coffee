# Description:
#   Keep a history of everything hubot hears which is accessible on the web at /history/ or /history/<room>/
#   This is based on the history script, but also tracks room and has a delightful web frontend.
#
# Dependencies:
#   "moment": "2.1.0"
#
# Configuration:
#   HUBOT_HISTORY_LINES - The number of lines to keep
#
# Commands:
#   hubot show [<lines> lines of] history - Shows <lines> of history, otherwise all history
#   hubot clear history - Clears the history
#   what did I miss - Show the last 5 lines of history
#
# Author:
#   jgillick (based on History, by wubr)

moment = require("moment")
querystring = require('querystring')

class History2
  constructor: (@robot, @keep) ->
    @cache = []
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.history2
        @robot.logger.info "Loading saved chat history"
        @cache = @robot.brain.data.history2

  add: (message) ->
    @cache.push message
    while @cache.length > @keep
      @cache.shift()
    @robot.brain.data.history2 = @cache

  show: (lines, inRoom) ->
    if (lines > @cache.length)
      lines = @cache.length
    reply = 'Showing the last ' + lines + ' lines of history:\n'

    count = 0
    for i in [@cache.length - 1..0] by -1
      message = @cache[i]

      # Not in the room we're interested in
      if inRoom and inRoom != message.room
        continue

      reply += @entryToString(message) + '\n'

      count++
      if count >= lines
        break

    return reply

  clear: ->
    @cache = []
    @robot.brain.data.history2 = @cache

  entryToString: (event) ->
    return "[#{event.hours}:#{event.minutes}] \##{event.room} <#{event.user}>: #{event.message}"

class History2Entry
  constructor: (@user, @message, @room) ->
    @time = new Date()
    @hours = @time.getHours()
    @minutes = @time.getMinutes()
    if @minutes < 10
      @minutes = '0' + @minutes

module.exports = (robot) ->

  options =
    lines_to_keep:  process.env.HUBOT_HISTORY_LINES

  unless options.lines_to_keep
    options.lines_to_keep = 500

  history = new History2(robot, options.lines_to_keep)

  # Log history
  robot.hear /(.*)/i, (msg) ->
    if msg.match[1] != ''
      user = msg.message.user
      room = msg.message.room
      historyentry = new History2Entry(user.name, msg.match[1], room)
      history.add historyentry

  # Last five lines of history
  robot.hear /what did I miss/i, (msg) ->
    msg.send history.show(5, msg.message.room)

  # Show history
  robot.respond /show ((\d+) lines of )?history2/i, (msg) ->
    if msg.match[2]
      lines = msg.match[2]
    else
      lines = history.keep
    msg.send history.show(lines)

  # Clear history
  robot.respond /clear history2/i, (msg) ->
    msg.send "Ok, I'm clearing the history."
    history.clear()

  # Show history HTML
  robot.router.get '/history2', (req, res) ->
    query = querystring.parse(req._parsedUrl.query)
    res.setHeader( 'content-type', 'text/html' );

    lines = history.cache.length
    listHtml = '';
    longestName = 5;

    # Room
    room = query.room
    roomTitle = "all rooms"
    if room
      roomTitle = room

    #
    # Build list HTML
    #
    userOddEven = -1
    rowOddEven = -1
    lastUser = false
    lastRoom = false
    for i in [history.cache.length - 1..0] by -1
      message = history.cache[i]
      user = message.user
      time = moment(message.time).fromNow()

      # Is this the same user as the last row
      sameUser = (lastUser == user && lastRoom == message.room)

      # From the correct room?
      if room and room != message.room
        continue

      # Format message text
      text = message.message
      text = text.replace(/</g, '&lt;');
      text = text.replace(/>/g, '&gt;');
      text = text.replace(/(https?:\/\/.*?)(\s|$)/ig, '<a href="$1" target="_blank">$1</a>$2') # link URLs

      # Room HTML line (only show if you're not viewing a specific room)
      roomEncoded = encodeURIComponent(message.room)
      roomHtmlLink = ""
      if !room
        if !message.room
          roomHtmlLink = "<span class='room to-bot'>#{robot.name}</span>"
        else
          roomHtmlLink = "<span class='room'><a href='/history2/?room=#{roomEncoded}''>#{message.room}</a></span>"


      # Zebra rows
      if !sameUser
        userOddEven *= -1;
      rowOddEven *= -1

      className = if (userOddEven == 1) then "user-odd" else "user-even"
      className += if (rowOddEven == 1) then "row-odd" else "row-even"

      # Don't include duplicate user
      userHTML = ""
      if !sameUser
        userHTML = "<dt class='#{className}''>#{message.user}</dt>"

      # List
      listHtml += """
      #{userHTML}
      <dd class="#{className}">
        <span class="meta">
          <time datetime="#{message.time}">#{time}</time>
          #{roomHtmlLink}
        </span>
        <span class="message">#{text}</span>
      </dd>
      """

      # Longest user name
      if message.user.length > longestName and message.user.length < 15
        longestName = message.user.length

      lastUser = message.user
      lastRoom = message.room
    #
    # Build entire HTML page
    #
    html = """
<!DOCTYPE html>
<head>
  <title>Hubot Transcript</title>
  <style type="text/css">
    body {
      background: #d3d6d9;
      color: #636c75;
      text-shadow: 0 1px 1px rgba(255, 255, 255, .5);
      font-family: Helvetica, Arial, sans-serif;
    }
    a {
      color: #486F96;
    }
    a:hover {
      color: #965148;
    }
    h1 {
      margin: 8px 0;
      padding: 0;
    }

    /* Mobile styles */
    dt {
      font-weight: bold;
      padding: 3px 5px;
      margin: 5px 0 0;
      font-family: courier;
      white-space: nowrap;
      background: #BDBDBD;
    }
    dd {
      margin: 3px 0 0 10px;
      padding: 3px 0 3px 3px;
    }
    dd time {
      margin: -2em 0 0 0;
      font-style: italic;
      font-size: 12px;
      display: block;
      width: 100%;
      text-align: center;
    }
    dd .room {
      font-size: 12px;
      margin: -1.3em 5px 0 0;
      float: right;
    }
    dd .message {
      display: block;
      margin-top: 3px;
    }
    dd .room:before {
      content: 'in ';
    }
    dd .room.to-bot:before {
      content: 'to ';
    }

    /* Only show the first time/room for a user's list of messages, for mobile */
    dt ~ dd time,
    dt ~ dd .room {
      display: none;
    }
    dt + dd time,
    dt + dd .room {
      display: block;
    }

    /* Desktop styles */
    @media (min-width: 650px) {
      dd {
        position: relative;
        border-top: 1px solid #B5BBC0;
      }
      dt + dd {
        border: none;
      }
      dd time {
        margin: 0 0 7px 7px;
        padding: 0;
        float: right;
        width: auto;
        color: #919AA3;
        display: inline-block !important;
      }
      dd .room {
        margin: 0;
        position: absolute;
        top: -1.8em;
        right: 5px;
      }
    }
  </style>
</head>
<body>

<h1>Hubot transcripts for #{roomTitle}</h1>

<dl>
  #{listHtml}
</dl>
</body>
</html>
    """

    res.end html