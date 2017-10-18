from sense_hat import SenseHat
import time
import httplib, urllib

while True:
    sense_nanoha = SenseHat()

    pressure = sense_nanoha.get_pressure()
    temp = sense_nanoha.get_temperature()
    humidity = sense_nanoha.get_humidity()

    params = urllib.urlencode({'field1': 8, 'field2': 24, 'field3':15, 'key': '9B1ZCDNMTLRHRXRP'})
    headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
    conn = httplib.HTTPConnection("api.thingspeak.com:80")
    conn.request("POST", "/update", params, headers)
    response = conn.getresponse()
    conn.close()

    time.sleep(30)

    # put = input("Type 1 to terminate")
    # brk = int(put)
    # if brk==1:
    #    break


