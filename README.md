# Fire Breathing Pumpkin!
Wherein we hook up a motion sensor to a servo which is mounted on a hairspray can, stick it in a spooooky pumpkin, put a tealight in front of it, and make **really** sure not to burn anyone.

## Upcoming Version - Servo Driven
I have added the arduino code to drive a servo to depress a nozzle on a can, also a button to actuate the servo/press the nozzle on demand. I hope to soon add some STL files so we can 3d print a holder for a travel size hairspray can, a tealight, and a mount for the servo that depresses the nozzle. Maybe also some relatively water-resistant housings for the motion sensor and arduino with spikes to stab/mount into the pumpkin?

## First Version - with Glade Dispenser
The code was originally copied from [Richard Osgood's version from the WayBack Machine](https://web.archive.org/web/20131106091413/http://www.richardosgood.com/blog/wp-content/uploads/2013/10/fireLantern_v1.ino), but I actually ended up not using any as I had a motion sensor, not a distance sensor. Code checked in to maintain a copy of it and to acknowledge the inspiration. A [great Youtube video is available](https://www.youtube.com/watch?v=qDRTbuhs05Q) showing his build process.

I had just enough pieces to hack something together the day of Halloween. And even found a pumpkin spice glade scented can! (For pumpkin scented flaming breath) I also added a button to manually trigger the flame breath, because.

The Glade Air Freshener dispenser worked pretty well, but I wanted more fire, for longer. I've moved all glade dispenser related files to a sub directory. The wiring diagram and code is unfortunately not tested - I don't think the code is the final version, and I recreated the wiring diagram from memory and this code version.

I will hopefully be able to clean up my mess of a first version so you can still do this with easy enough to find and assemble parts (just a Glade Air Freshener, motion sensor, and an arduino - no 3d printer needed).

Also, if you don't want to do any electronics work, you can just connect wires to the Glade dispenser as I did, but then simply run them back to your apt/house and then just touch the bare ends together - viola, remote fire button. You probably don't even need to solder the wires to the button in the Glade dispenser, alligator clips might work?
