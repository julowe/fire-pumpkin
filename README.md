# Fire Breathing Pumpkin!

Wherein we hook up a motion sensor to a servo which is mounted on a hairspray can, stick it in a spooooky pumpkin, put a tealight in front of it, and make **really** sure not to burn anyone.

## Current Version - Servo Driven

The root of this repo includes the arduino code to move a servo when triggered by a PIR sensor or a button, an STL file of a model that holds a servo and a can of hairspray, and the SCAD file for that model so you can edit dimensions if needed. Specific BOM is below.

The code and model are fairly simple. Code mostly cobbled together from product examples. Holder has the can angled in and friction fit, has 4 holes in the bottom to nail holder into a pumpkin/whatever. I left it up to you to deal with placement of arduino and wiring.

### Bill Of Materials

The 3D printed holder only depends on the dimensions fo the servo and hairspray can. I called out dimensions of both objects in the scad file, so it should be easy enough to change them, but buy the below if you just want to use the included stl file.

| Item              | Description/Comments | Link |
| ----------------- | -------------------- | ---- |
| Hairspray         | Tresemme Hairspray can, 1.5oz travel size | [Target](https://www.target.com/p/tresemme-tres-two-extra-hold-hairspray-travel-size-1-5oz/-/A-13294119) |
| Servo             | Tower Pro SG92R Microservo | [Adafruit](https://www.adafruit.com/product/169) |
| Arduino           | Arduino Uno used, but only three IO pins are used so almost any version should be fine |  |
| PIR Sensor        | Bought long ago from Radioshack, soo... Paralax Passive Infrared (PIR) Sensor, Rev B, SKU 555-28027 | [Parallax](https://www.parallax.com/product/pir-sensor-with-led-signal/) |
| Breadboard        | or any other means of connecting wires |  |
| Button & Resistor | if you want fire on demand w/o waving your hand in front of PIR |  |


## First Version - with Glade Dispenser

I had just enough pieces to hack something together the day of Halloween. And even found a pumpkin spice glade scented can! (For pumpkin scented flaming breath) I also added a button to manually trigger the flame breath, because.

The Glade Air Freshener dispenser worked pretty well, but I wanted more fire, for longer. I've moved all glade dispenser related files to a sub directory. The wiring diagram and code is unfortunately not tested - I'm not sure if the code is the final version, and I recreated the wiring diagram from memory and this code version.

I will hopefully be able to clean up my mess of a first version so you can still do this with easy enough to find and assemble parts (just a Glade Air Freshener, motion sensor, and an arduino - no 3d printer needed).

Also, if you don't want to do any electronics work, you can just connect wires to the Glade dispenser as I did, but then simply run them back to your apt/house and then just touch the bare ends together - viola, remote fire button. You probably don't even need to solder the wires to the button in the Glade dispenser, alligator clips might work?

## Other Versions

The code was originally copied from [Richard Osgood's version from the WayBack Machine](https://web.archive.org/web/20131106091413/http://www.richardosgood.com/blog/wp-content/uploads/2013/10/fireLantern_v1.ino), but I actually ended up not using any as I had a motion sensor, not a distance sensor. Code checked in to maintain a copy of it and to acknowledge the inspiration. A [great Youtube video is available](https://www.youtube.com/watch?v=qDRTbuhs05Q) showing his build process.

I recently saw [Markus Haack's version here](https://github.com/mhaack/halloween-pumpkin-fire) which is quite neat - uses wifi, MQTT, and wood/metal parts instead of 3d printing. I may look at this for remote operation (wifi vs bluetooth), but we'll see if that comes to pass at all.
