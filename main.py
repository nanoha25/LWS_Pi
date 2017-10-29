from sense_hat import SenseHat
import time
import httplib, urllib

class MainFuc:

    while True:

        def setup(self):
            sense_nanoha = SenseHat()

            pressure = sense_nanoha.get_pressure()
            temp_ori = sense_nanoha.get_temperature()
            humidity = sense_nanoha.get_humidity()
            print('Got data!\n')
            return temp_ori, pressure, humidity

        def modifier(self, temp_ori):
            ftr = 1.39
            temp = temp_ori/ftr
            print('Data modified!\n')
            return temp

        def send_data(self, temp, pressure, humidity):
            params = urllib.urlencode({'field1': temp, 'field2': humidity, 'field3':pressure, 'key': '9B1ZCDNMTLRHRXRP'})
            headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
            conn = httplib.HTTPConnection("api.thingspeak.com:80")
            conn.request("POST", "/update", params, headers)
            response = conn.getresponse()
            conn.close()
            print('Data sent!\n')
            return response

        def timer(self):
            time.sleep(30)
            print('Woke up!\n')
            return 0

            # put = input("Type 1 to terminate")
            # brk = int(put)
            # if brk==1:
            #    break

    setup()
    modifier()
    send_data()
    timer()