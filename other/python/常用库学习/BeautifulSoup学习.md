# BeautifulSoup学习
```python
import bs4

soup = BeautifulSoup(text, 'html5lib')
for a in soup.select('css.selector'):
    print(a.string)
    print(a['href'])
```