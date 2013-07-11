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
//  :insult ~ <name> - Queue up an insult for next time the user says something
//
//Author:
//  jhoff

module.exports = function(robot) {
	robot.respond( /insult (~)?\s*(.*)/i, function(msg) {
		var queueFlag = msg.match[1],
      name = msg.match[ 2 ].trim(),
			namelc = name.toLowerCase(),
      queue = robot.brain.get('insultQueue') || {};

		if( !namelc.match( /^bomb.*/i ) ) {
			if( [ 'yourself', 'you', robot.name, 'me' ].indexOf( namelc ) >= 0 ) {
        name = msg.message.user.name;
        namelc = name.toLowerCase();
      }

      // Wildcard
      if (name == '*') {
        name = 0; // Start counter
        queueFlag = true;
      }

      // Queue up the insult
      if( queueFlag ){
        queue[namelc] = name;
        robot.brain.set('insultQueue', queue);
      }
      // Say immediately
      else {
			 insult( msg, name );
      }
		}
	});

  // Say queued insult
  robot.hear( /./, function(msg){
    var namelc = msg.message.user.name.toLowerCase(),
        queue = robot.brain.get('insultQueue') || {};

    // Handle wildcard
    if (typeof queue['*'] != 'undefined') {

      // Increment and wait (otherwise it'll respond as soon as the insult is queued)
      if (queue['*'] == 0) {
        queue['*'] = 1;
        robot.brain.set('insultQueue', queue);
      }

      // Insult the immediate user
      else {
        insult( msg, msg.message.user.name );
        delete queue['*'];
        robot.brain.set('insultQueue', queue);
      }
    }

    // Say queued insult for user
    else if (typeof queue[namelc] != 'undefined') {
      insult( msg, queue[namelc] );
      delete queue[namelc];
      robot.brain.set('insultQueue', queue);
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
  "balloon",
  "donkey fucker"
];