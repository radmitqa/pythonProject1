import http.client

conn = http.client.HTTPSConnection("dev-n69d386hw4b698w.api.raw-labs.com")

payload = ""

headers = { }

conn.request("GET", "/2?country=UK&minYear=1999&maxYear=2000&code=L53.8", payload, headers)

res = conn.getresponse()
data = res.read()
print(payload)
print(res)
print(data)