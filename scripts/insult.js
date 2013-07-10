//Description:
//  Hubot Insulter, inspired by http://i.imgur.com/dXCGBE0.png
//
//Dependencies:
//  None
//
//Configuration:
//  None
//
//Commands:
//  :insult <name> - give <name> the what-for
//
//Author:
//  jhoff

module.exports = function(robot) {
	robot.respond( /insult (.*)/i, function(msg) {
		var name = msg.match[ 1 ].trim(),
			namelc = name.toLowerCase();
		if( !namelc.match( /^bomb.*/i ) ) {
			if( [ 'yourself', 'you', robot.name, 'me' ].indexOf( namelc ) >= 0 ) name = msg.message.user.name;
			insult( msg, name );
		}
	});
}

var insult = function( msg, name ) {
	var one = shuffle( first );
	var two = shuffle( second );
	var three = shuffle( third );
	msg.send( name + " is a " + one.pop() + " " + two.pop() + " " + three.pop() + "." );
}

function shuffle(array) {
	var tmp, current, top = array.length;

	if(top) while(--top) {
		current = Math.floor(Math.random() * (top + 1));
		tmp = array[current];
		array[current] = array[top];
		array[top] = tmp;
	}

	return array;
}

var first = [
  "lazy",
  "stupid",
  "insecure",
  "idiotic",
  "slimy",
  "slutty",
  "pompous",
  "communist",
  "dicknose",
  "pie-eating",
  "racist",
  "elitist",
  "white trash",
  "drug-loving",
  "butterface",
  "tone deaf",
  "ugly",
  "creepy"
];

var second = [
  "douche",
  "ass",
  "turd",
  "rectum",
  "butt",
  "cock",
  "shit",
  "crotch",
  "bitch",
  "turd",
  "prick",
  "slut",
  "taint",
  "fuck",
  "dick",
  "boner",
  "shart",
  "nut",
  "sphincter"
];

var third = [
  "pilot",
  "canoe",
  "captain",
  "pirate",
  "hammer",
  "knob",
  "box",
  "jockey",
  "nazi",
  "waffle",
  "goblin",
  "blossum",
  "biscuit",
  "clown",
  "socket",
  "monster",
  "hound",
  "dragon",
  "balloon"
];