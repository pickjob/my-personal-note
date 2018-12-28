# requests学习
  ```python
  import requests
  # GET
  payload = {'key1': 'value1', 'key2': 'value2'}
  headers = {'user-agent': 'my-app/0.0.1'}
  r = requests.get('https://api.github.com/user', params=payload, auth=('user', 'pass'), headers=headers)
  # POST
  r = requests.post('https://httpbin.org/post', data = {'key':'value'})
  # PUT
  r = requests.put('https://httpbin.org/put', data = {'key':'value'})
  # DELETE
  r = requests.delete('https://httpbin.org/delete')
  # HEAD
  r = requests.head('https://httpbin.org/get')
  # OPTIONS
  r = requests.options('https://httpbin.org/get')
  # SESSION
  s = requests.Session()
  s.get('https://httpbin.org/cookies/set/sessioncookie/123456789')
  r = s.get('https://httpbin.org/cookies')
  with requests.Session() as s:
    s.get('https://httpbin.org/cookies/set/sessioncookie/123456789')
  print(r.text)
  # RESPONSE
  r.status_code
  r.headers['content-type']
  r.encoding
  r.text
  r.content
  r.json()
  r.raw
  ```