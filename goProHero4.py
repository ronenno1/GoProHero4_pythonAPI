import requests
class goPro:
    ip        = '';
    connected = False;
    def __init__(self, ip = 'http://10.5.5.9'):
        self.ip = ip
        print ip
        try:
            r = requests.get(ip)
            self.connected = True;
        except:
            self.connected = False;
    
    def is_connect(self):
        return self.connected
    
    def power_off(self):
        return self.bacpac_api('PW', '0')
    
    def take_pic(self):
        return self.camera_api('SH', '2')

    def start_record(self):
        return self.camera_api('SH', '1')

    def stop_record(self):
        return self.camera_api('SH', '0')

    def still_mode(self):
        return self.camera_api('CM', '1')

    def video_mode(self):
        return self.camera_api('CM', '0')

    def camera_api(self, method, intParam):
        return self.general_api('camera', method, intParam)
    
    def bacpac_api(self, method, intParam):
        return self.general_api( 'bacpac', method, intParam)
        
    def general_api(self, api, method, intParam):
        url = 'http://' + self.ip + '/' + api + '/' + method + '?p=%0' + intParam
        requests.get(url)
