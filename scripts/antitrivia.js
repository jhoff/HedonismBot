//Description:
//  Anti Trivia-bot script
//
//Dependencies:
//  None
//
//Configuration:
//  None
//
//Commands:
//  None
//
//Author:
//  jhoff

module.exports = function(robot) {
	robot.respond( /^\!trivia .*/i, function(msg) {
  	msg.send( "!trivia reset" );
  	msg.send( "NO MORE GOD DAMN TRIVIA!" );
	});
}
