import requests

response = requests.get("https://dev-n69d386hw4b698w.api.raw-labs.com/3?country=UK&minYear=2004&maxYear=2006&code=L53.8")
print(response.status_code)
print(response.content)