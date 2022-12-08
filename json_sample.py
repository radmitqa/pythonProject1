import json
import requests
import jsonpath

''' Test 1 '''
# my_dict = '{"K1":"Val1","K2":"Val2"}'
# json_result = json.loads(my_dict)
# print(json_result['K1'])

""" Test 2 """
api_url = "https://reqres.in/api/users?page=2"
response1 = requests.get(api_url)
# print(response1.text)
# print(response1.status_code)
# assert response1.status_code == 200
json_response = json.loads(response1.text)
# print(json_response)

""" Test 3 """
x = jsonpath.jsonpath(json_response,'total')
print(x)
print("---")
y = jsonpath.jsonpath(json_response,'data[1].first_name')
print(y)
print("---")
print(y[0])
print("---")

for val in json_response['data']:
    print(val['last_name'])
print("---")