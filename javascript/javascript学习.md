# javascript学习
```javascript
let [a, b, c] = [1, 2, 3];
let {foo, bar } = { foo: 'aaa', bar: 'bbb' };
let {x: y = 3} = {x: 5};
// JS原生方法拦截
function hookAJAX() {
    XMLHttpRequest.prototype.nativeOpen = XMLHttpRequest.prototype.open;
    XMLHttpRequest.prototype.open = function (method, url, async, user, password) {
        // do something
        this.nativeOpen(method, url, async, user, password);
    };
};
function hookImg() {
    const property = Object.getOwnPropertyDescriptor(Image.prototype, 'src');
    const nativeSet = property.set;
    Object.defineProperty(Image.prototype, 'src', {
        set: function(url) {
            // do something
            nativeSet.call(this, url);
        }
    });
};
function hookOpen() {
    const nativeOpen = window.open;
    window.open = function (url) {
        // do something
        nativeOpen.call(this, url);
    };
};
function hookFetch() {
    var fet = Object.getOwnPropertyDescriptor(window, 'fetch')
    Object.defineProperty(window, 'fetch', {
        value: function (a, b, c) {
            // do something
            return fet.value.apply(this, args)
        }
    });
};
```