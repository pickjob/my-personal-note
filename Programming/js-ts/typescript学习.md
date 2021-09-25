# Typescript学习
```typescript
// Basic types
let isDone: boolean = false;
let decimal: number = 6;
let color: string = "blue";
let sentence: string = `Hello, my name is ${ fullName }.I'll be ${ age + 1 } years old next month.`;
let list: number[] = [1, 2, 3];
let x: [string, number] = ["hello", 10]; // OK
enum Color {Red, Green, Blue}
let c: Color = Color.Green;
let notSure: any = 4;
let u: undefined = undefined;
let n: null = null;
let someValue: any = "this is a string";
let strLength: number = (<string>someValue).length;
// Destructuring
let input = [1, 2];
let [first, second] = input;
let o = {
    a: "foo",
    b: 12,
    c: "bar"
};
let { a, b } = o;
interface LabeledValue {
    label: string;
    color?: string;
    readonly x: number;
    (source: string, subString: string): boolean;
    [index: number]: string;
    [x: string]: Dog;
    new (hour: number, minute: number): ClockInterface;
}
class Clock implements ClockInterface {
    currentTime: Date = new Date();
    constructor(h: number, m: number) { }
}
interface Square extends Shape {
    sideLength: number;
}
class Greeter {
    #greeting: string;
    constructor(message: string) {
        this.greeting = message;
    }
    greet() {
        return "Hello, " + this.greeting;
    }
}
let greeter = new Greeter("world");
 class Employee {
    private _fullName: string;

    get fullName(): string {
        return this._fullName;
    }

    set fullName(newName: string) {
        if (newName && newName.length > fullNameMaxLength) {
            throw new Error("fullName has a max length of " + fullNameMaxLength);
        }
        
        this._fullName = newName;
    }
}
static origin = {x: 0, y: 0};

export interface StringValidator {
    isAcceptable(s: string): boolean;
}

import { StringValidator } from "./StringValidator";
function f() {
    console.log("f(): evaluated");
    return function (target, propertyKey: string, descriptor: PropertyDescriptor) {
        console.log("f(): called");
    }
}

function g() {
    console.log("g(): evaluated");
    return function (target, propertyKey: string, descriptor: PropertyDescriptor) {
        console.log("g(): called");
    }
}

class C {
    @f()
    @g()
    method() {}
}

// printDelayed is a 'Promise<void>'
async function printDelayed(elements: string[]) {
    for (const element of elements) {
        await delay(400);
        console.log(element);
    }
}

async function delay(milliseconds: number) {
    return new Promise<void>(resolve => {
        setTimeout(resolve, milliseconds);
    });
}


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