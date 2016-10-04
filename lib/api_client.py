import http.client


# main()
conn = http.client.HTTPConnection('localhost', 8888, timeout=10)
conn.request('GET', '/')
response = conn.getresponse()

data = response.read()

print(response.status, response.reason)
print(data)