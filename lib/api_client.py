import http.client

host = "localhost"
port = 8888
timeout = 5

# main()
conn = http.client.HTTPConnection(host, port, timeout=timeout)
conn.request('GET', '/')
response = conn.getresponse()

data = response.read()

print("HTTP response to {0}:{1} : {2} - {3} ".format(host, 
	port, response.status, response.reason))