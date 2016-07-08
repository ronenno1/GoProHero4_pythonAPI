# GoProHero4_pythonAPI

Hi everyone!
Here I develloped a very simple API for go pro hero 4 by python.

I wrote this code for helping my colleagues in my lab (http://in.bgu.ac.il/en/Labs/CNL/) with their study with archerfish.

My code include very simple package that called "goProHero4".

In this package I have 8 main functions:

Init: that gets the Ip if the camera (that connectd by wifi).

is_connect: that chacks if the camera are connected (after we try to init it).


still_mode: that lets us take pictures with the camera

video_mode: that lets us take videos with the camera

take_pic: that takes picture - it will works only if we changed the camera's mode to still mode!!

start_record / stop_record: that starts or stops record a video - it will works only if we changed the camera's mode to video mode!!


power_off: that turn off the camera (unfortunately, there is no way to turn on the camera - it makes sense :P)


for example you can see demo.py that:

1. inits the camera.

2. checks if the cammera is connected.

3. changes the mode of the camera to still mode.

4. takes a picture.

5. swiches the camera to video mode.

6. starts a new video

7. stops recording.

8. turns off the camera

(yes it is very simple to control your go pro hero 4 with python)


In the next future I plan to add an option to download all the files from the camera to the computer.

If you have any question: you are wellcome to send me an email to: ronen.no1@gmail.com

Enjoy!
