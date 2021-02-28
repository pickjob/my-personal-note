# Kotlin学习
```kotlin
// Number:
//      Byte Short Int Long
//      Float Double
//      true false
fun main() {
    println("Hello world!")
}
// val var
val a: Int = 1
var x = 5
x += 1
// nullable
var x: Int? = null
// for
for (item in items) {
    println(item)
}
// while
while (index < items.size) {
    println("item at $index is ${items[index]}")
    index++
}
// when
when (obj) {
    1          -> "One"
    "Hello"    -> "Greeting"
    is Long    -> "Long"
    !is String -> "Not a string"
    else       -> "Unknown"
}
when {
    "orange" in items -> println("juicy")
    "apple" in items -> println("apple is fine too")
}
// ranges
if (x in 1..y+1) {
    println("fits in range")
}
// function
fun sum(a: Int, b: Int): Int {
    return a + b
}
// default value
fun foo(a: Int = 0, b: String = "") { ... }
fun sum(a: Int, b: Int) = a + b
fun printSum(a: Int, b: Int): Unit {
    println("sum of $a and $b is ${a + b}")
}
// DTO、POJO
data class Customer(val name: String, val email: String)
// singleton
object Resource {
    val name = "Name"
}
// ?. ?:
println(files?.size)
println(files?.size ?: "empty")
value?.let {
    ... // execute this block if not null
}
// scope function:
//      let: it - Executing a lambda on non-null objects
//      run: this - Object configuration and computing the result
//      with: this - Grouping function calls on an object
//      apply: this - Object configuration
//      also: it - Additional effects
// with
class Turtle {
    fun penDown()
    fun penUp()
    fun turn(degrees: Double)
    fun forward(pixels: Double)
}
// class
// primary constructor
class Person(firstName: String) { /*...*/ }
class Customer public @Inject constructor(name: String) { /*...*/ }
open class Shape {
    open fun draw() { /*...*/ }
    fun fill() { /*...*/ }
}
class Circle() : Shape() {
    override fun draw() { /*...*/ }
    var <propertyName>[: <PropertyType>] [= <property_initializer>]
    [<getter>]
    [<setter>]
}
var stringRepresentation: String
    get() = this.toString()
    set(value) {
        setDataFromString(value) // parses the string and assigns values to other properties
    }

val myTurtle = Turtle()
with(myTurtle) { //draw a 100 pix square
    penDown()
    for (i in 1..4) {
        forward(100.0)
        turn(90.0)
    }
    penUp()
}

val myRectangle = Rectangle().apply {
    length = 4
    breadth = 5
    color = 0xFAFAFA
}

// Single Abstract Method (SAM)
fun interface KRunnable {
   fun invoke()
}


    - List
        - listOf<T>
        - mutableListOf<T>
        - emptyList()
    - Set
        - setOf<T>
        - mutableSetOf<T>
        - emptySet()
    - Map
        - mapOf<T>
        - mutableMapOf<T>
        - emptyMap()



fun main() {
    println("Hello world!")
}
// val var
val a: Int = 1
var x = 5 // `Int` type is inferred
x += 1
// null
fun parseInt(str: String): Int? {
    // ...
}
// for
for (item in items) {
    println(item)
}
// while
while (index < items.size) {
    println("item at $index is ${items[index]}")
    index++
}
// when
when (obj) {
    1          -> "One"
    "Hello"    -> "Greeting"
    is Long    -> "Long"
    !is String -> "Not a string"
    else       -> "Unknown"
}
when {
    "orange" in items -> println("juicy")
    "apple" in items -> println("apple is fine too")
}
// ranges
if (x in 1..y+1) {
    println("fits in range")
}
// function
fun sum(a: Int, b: Int): Int {
    return a + b
}
// default value
fun foo(a: Int = 0, b: String = "") { ... }
fun sum(a: Int, b: Int) = a + b
fun printSum(a: Int, b: Int): Unit {
    println("sum of $a and $b is ${a + b}")
}
// DTO、POJO
data class Customer(val name: String, val email: String)
// singleton
object Resource {
    val name = "Name"
}

// if not null
println(files?.size)
println(files?.size ?: "empty")
value?.let {
    ... // execute this block if not null
}
// if null
val email = values["email"] ?: throw IllegalStateException("Email is missing!")

// with
class Turtle {
    fun penDown()
    fun penUp()
    fun turn(degrees: Double)
    fun forward(pixels: Double)
}

val myTurtle = Turtle()
with(myTurtle) { //draw a 100 pix square
    penDown()
    for (i in 1..4) {
        forward(100.0)
        turn(90.0)
    }
    penUp()
}

val myRectangle = Rectangle().apply {
    length = 4
    breadth = 5
    color = 0xFAFAFA
}
```