# httpx学习
```python
import httpx

# headers
headers = {
    'user-agent': 'my-app/0.0.1'
}
# basic authen
auth=("my_user", "password123")
# url params
params = {
    'key1': 'value1',
    'key2': 'value2'
}
# bady data
formData = {
    'key1': 'value1'
}
jsonData = {
    'key1': 'value1'
}

# file
files = {'upload-file': ('report.xls', open('report.xls', 'rb'), 'application/vnd.ms-excel')}


# Get
resp = httpx.get('https://httpbin.org/get', headers=headers, auth=auth, params=params)

# POST
resp = httpx.post('https://httpbin.org/post', data=formData, files=files)
resp = httpx.post('https://httpbin.org/post', json=jsonData, files=files)

# PUT
resp = httpx.put('https://httpbin.org/put', data=formData)

# DELETE
resp = httpx.delete('https://httpbin.org/delete')

# OHTER
resp = httpx.head('https://httpbin.org/get')
resp = httpx.options('https://httpbin.org/get')

# response status
resp.status_code
# response headers
resp.headers
# response.cookie
resp.cookies
# response text(unicode)
resp.text
# response binary content
resp.content
# response json
resp.json()

# session
with httpx.Client(headers=headers, params=params) as client:
    resp = client.get('https://example.com')
```