from sense_hat import SenseHat

sense_nanoha = SenseHat()
sense_nanoha.clear()

pressure = sense_nanoha.get_pressure()
print(pressure)

temp = sense_nanoha.get_temperature()
print(temp)

humidity = sense_nanoha.get_humidity()
print(humidity)

