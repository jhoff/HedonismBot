//Description:
//  Converts go/blah into http://go/blah
//
//Dependencies:
//  None
//
//Configuration:
//  None
//
//Author:
//  jhoff

module.exports = function(robot) {
  robot.hear( /[^\/]?(go\/[a-z\-_0-9]+)/i, function(msg){
    msg.send( 'http://' + msg.match[1] );
  });
}