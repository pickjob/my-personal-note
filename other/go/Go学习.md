# Go学习
```go
// 环境变量:
//         GOPATH=~/repository/golang
//         GOARCH=amd64, 386 arm ppc64
//         GOOS=linux darwin windows
// Go mod:
//         go mod init <moduleName>: 初始化
//         go mod tidy:  增加缺少的module, 删除无用module
//         go mod vendor: 依赖复制到vendor下
//         go mod graph: 打印模块依赖图
// go install
package main
import "fmt"
func main() {
    fmt.Printf("Hello world")
}
// defer
defer fmt.Println("world")
// 基本数据类型:
//         bool
//         string
//         int  int8  int16  int32  int64
//         uint uint8 uint16 uint32 uint64 uintptr
//         byte // uint8 的别名
//         rune // int32 的别名 表示一个 Unicode 码点
//         float32 float64
//         complex64 complex128
//         uint()

// 函数
func split(sum int) (x, y int) {
    x = sum * 4 / 9
    y = sum - x
    return
}

if v := math.Pow(x, n); v < lim {
    return v
} else {
}

for i := 0; i < 10; i++ {
    sum += i
}

switch os := runtime.GOOS; os {
	case "darwin":
        fmt.Println("OS X.")
    case "linux":
        fmt.Println("Linux.")
    default:
        // freebsd, openbsd,
        // plan9, windows...
        fmt.Printf("%s.\n", os)
}

type Vertex struct {
    X int
    Y int
}

var a [2]string
a[0] = "Hello"
a[1] = "World"

// slice
// 		make() len() cap() append()
primes := [6]int{2, 3, 5, 7, 11, 13}
var s []int = primes[1:4]
b := make([]int, 0, 5) // len(b)=0, cap(b)=5
b = b[:cap(b)] // len(b)=5, cap(b)=5
b = b[1:]      // len(b)=4, cap(b)=4

// for
for i, v := range pow {
    fmt.Printf("2**%d = %d\n", i, v)
}
for i, _ := range pow
for _, value := range pow

// map
m = make(map[string]Vertex)
m[key] = elem
elem = m[key]
delete(m, key)
elem, ok = m[key]

type Vertex struct {
    X, Y float64
}

var m = map[string]Vertex{
    "Bell Labs": Vertex{
    	40.68433, -74.39967,
    },
    "Google": Vertex{
        37.42202, -122.08408,
    },
}

func (v Vertex) Abs() float64 {
    return math.Sqrt(v.X*v.X + v.Y*v.Y)
    
}

func (v *Vertex) Abs() float64 {
    return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

interface{}

// 类型判断
t, ok := i.(T)

switch v := i.(type) {
	case T:
		// v 的类型为 T
	case S:
		// v 的类型为 S
	default:
		// 没有匹配，v 与 i 的类型相同
}

// channel
go f(x, y, z)
ch := make(chan int, 100)
ch := make(chan int)
ch <- v    // 将 v 发送至信道 ch。
v := <-ch  // 从 ch 接收值并赋予 v。
v, ok := <-ch

select {
	case i := <-c:
		// 使用 i
	default:
		// 从 c 中接收会阻塞时执行
}
```


