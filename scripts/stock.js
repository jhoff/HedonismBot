// Description:
//   Get a stock price
// 
// Dependencies:
//   None
// 
// Configuration:
//   None
// 
// Commands:
//   hubot stock <info|quote|price> for <ticker> - Get a stock price
// 
// Author:
//   eliperkins

module.exports = function(robot) {
  var checkStock;
  checkStock = function(symbol, msg) {
    symbol = escape(symbol);
    msg.http('http://finance.google.com/finance/info?client=ig&q=' + symbol).get()(function(err, res, body) {
      var message, result;
      result = JSON.parse(body.replace(/\/\/ /, ''));
      output = [];
      for (var i = 0; i < result.length; i++) {
        output[] = '' + result[i].t + ' - ' + result[i].l_cur + ' (' + result[i].c + ')';
      }
      msg.send( output.join( ' | ' ) );
    });
  };

  robot.respond(/stock( info| price| quote)?( for)? @?([\w .-_]+)/i, function(msg) {
    checkStock(msg.match[3], msg);
  });

  robot.respond(/stock$/i, function(msg) {
    checkStock("aapl,f,fb,goog,lnkd,tsla,twtr", msg);
  });
};