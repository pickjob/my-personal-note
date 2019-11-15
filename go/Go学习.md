# Go学习
```go
// 基本数据类型:
//      bool:  false true
//      number: 0
//          unsigned:  uint8 uint16 uint32 uint64 uintptr
//          signed:     int8  int16  int32  int64
//          byte:      uint8的别名
//          rune:      int32的别名  表示一个 Unicode 码点
//          float:     float32 float64
//          complex:   complex64   complex128
//      string: ""
package main
import (
    "fmt"
)
func main() {
    fmt.Println("Hello World")
}
// 流程控制语句
if initExp; conditionExp {
}
for initExp; conditionExp; acc {
}
switch initExp; key {
	case 0:
    case f():
	default:
		fmt.Printf("%s.\n", os)
}
// 其他数据类型:
//   array: [N]T
var a [5]int;
numbers := make([]int, 5, 10);
numbers = append(numbers, 1, 2, 3, 4);
[3]bool{true, true, false}
//   slice: []T nil
[]bool{true, true, false}
a := make([]int, 5)
//   len() cap() append()
var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}
for i, v := range pow {
    fmt.Printf("2**%d = %d\n", i, v)
}
//   map
var m map[string]int;
m := make(map[string]int)
//   adding key/value
m["clearity"] = 2
m["simplicity"] = 3
m[key] = elem
elem = m[key]
delete(m, key)
elem, ok = m[key]
//    function
func add(x int, y int) int {
	return x + y
}
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}
func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}
//   struct
type Vertex struct {
	X, Y float64
}
func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X * v.X + v.Y * v.Y)
}
v := Vertex{16, 4}
//   interface
type Abser interface {
	Abs() float64
}
func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X * v.X + v.Y * v.Y)
}
interface{}
//  类型断言
t := i.(T)
//	类型选择
switch v := i.(type) {
	case T:
		// v 的类型为 T
	case S:
		// v 的类型为 S
	default:
		// 没有匹配，v 与 i 的类型相同
}
//  chan
ch := make(chan int)
ch := make(chan int, 100)
ch <- v      //将v发送至信道 ch
v  := <-ch   //从ch接收值并赋予 v
v, ok := <-ch
//  读取
for i := range ch 
select {
	case c <- x:
		x, y = y, x+y
	case <-quit:
		fmt.Println("quit")
        return
    default
}
```