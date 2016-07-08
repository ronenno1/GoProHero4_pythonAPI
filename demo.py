from goProHero4 import goPro
camera = goPro();
if (camera.is_connect()!=True):
    exit(-1)
print camera.still_mode();
print camera.take_pic();
print camera.video_mode();
print camera.start_record();
print camera.stop_record();
print camera.power_off();
