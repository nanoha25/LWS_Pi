from sense_hat import SenseHat
import time

while True:
    sense_nanoha = SenseHat()

    pressure = sense_nanoha.get_pressure()

    temp = sense_nanoha.get_temperature()

    humidity = sense_nanoha.get_humidity()

    time.sleep(5)

    put = input("Type 1 to terminate")
    brk = int(put)
    if brk==1:
        break


