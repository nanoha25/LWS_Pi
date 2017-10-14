from sense_hat import SenseHat
import time
import httplib, urllib

while True:
    sense_nanoha = SenseHat()

    pressure = sense_nanoha.get_pressure()
    temp_ori = sense_nanoha.get_temperature()
    humidity = sense_nanoha.get_humidity()

    ftr = 1.39
    temp = temp_ori/ftr

    params = urllib.urlencode({'field1': temp, 'field2': humidity, 'field3':pressure, 'key': '9B1ZCDNMTLRHRXRP'})
    headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
    conn = httplib.HTTPConnection("api.thingspeak.com:80")
    conn.request("POST", "/update", params, headers)
    response = conn.getresponse()
    conn.close()


    time.sleep(30)



