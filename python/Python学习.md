```python
#!/usr/bin/env python3
# -*- coding: utf8 -*-
# if elif / else
if expr:
elif expr:
else
# for
for w in words:
    expr
for i in range(5):
    expr 
# loop break pass
# *args unpackage list
# **d unpackage dict
# lambda lambda x: x + n
# list
squares = [1, 4, 9, 16, 25]
squares.append(6 ** 2)
squares.clear()
l = squares[:]
for i, v in enumerate(['tic', 'tac', 'toe']):
    print(i, v)
# set
s = set('a', 'b', 'c')
s = {x for x in 'absdkwejoiew' if x not in 'bxe'}
# dictionary
tel = {'a': 25, 'b': 15}
tel['a'] = 243
d = {x: x ** 2 for x in (2, 4, 6)}
for k, v in d.items():
    print(k, v)
# del
name = 'Python'
print(f'hello {name}')
# json
import json
json.dumps([1, 'simple', 'list'])
x = json.load(f)
# file
with open('workfile') as f:
    for line in f:
        print(line, end='')
if __name__ == "__main__":
    # execute only if run as a script
    main()
```