import httplib, urllib
params = urllib.urlencode({'field1': 12, 'field2': 11, 'key':'BD6xM4sZEyT8'})
headers = {"Content-type": "application/x-www-form-urlencoded","Accept": "text/plain"}
conn = httplib.HTTPConnection("api.thingspeak.com:80")
conn.request("POST", "/update", params, headers)
response = conn.getresponse()
conn.close()
params = urllib.urlencode({'field1': 3, 'field2': 2, 'key':'BD6xM4sZEyT8'})
conn = httplib.HTTPConnection("api.thingspeak.com:80")
conn.request("POST", "/update", params, headers)
response = conn.getresponse()
conn.close()
