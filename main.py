from sense_hat import SenseHat
import time
import httplib, urllib



def weather_station():
    # setup board and sensors.
    sense_nanoha = SenseHat()

    pressure = sense_nanoha.get_pressure()
    temp_ori = sense_nanoha.get_temperature()
    humidity = sense_nanoha.get_humidity()
    #add a modifier to let the final result closer to the actual value.
    ftr = 1.39
    temp = temp_ori / ftr
    #send data to thingspeak.
    #params = urllib.urlencode({'field1': temp, 'field2': humidity, 'field3': pressure, 'key': '9B1ZCDNMTLRHRXRP'})
    params = urllib.urlencode({'field1': temp, 'field2': humidity, 'field3': pressure, 'key': ' 9L28IP6LTIYXR19O'})
    headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
    conn = httplib.HTTPConnection("api.thingspeak.com:80")
    conn.request("POST", "/update", params, headers)
    response = conn.getresponse()
    conn.close()
    #add a timer as per requirement from thingspeak.
    time.sleep(30)

    print('Sent.\n')  #provide terminal output indicating data is sent.
    return 0



while True:
    weather_station() #run the function.
