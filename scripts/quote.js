// quote module
// usage: :quote UserName Message

module.exports = function(robot) {
  
  var USER_QUOTES = 'userQuotes',

      quotes = robot.brain.get(USER_QUOTES) || {};

  robot.hear(/quote ([^\s]+)/, function(msg) {
    var user = msg.match[1],
        userQuotes = null;
    if (quotes.hasOwnProperty(user)) {
      userQuotes = quotes[user];
      msg.send(userQuotes[Math.floor(Math.random() * userQuotes.length)] + ' - ' + user);
    }
  });

  robot.hear(/quote ([^\s]+) ([\w]+)/, function(msg) {
    var user = msg.match[1];
    if (!quotes.hasOwnProperty(user)) {
      quotes[user] = [];
    }
    quotes[user].push(msg.match[2]);
    robot.brain.set(USER_QUOTES, quotes);
  });

};
