```c
//  数据类型
//      char
//      short int long
//      float  double
#include<stdio.h>
int main(int argc, char *argv[]) {
    char name[20];
    // printf:
    //      %s: 字符
    //      %d: 数组
    //      %p: 指针    
    printf("Enter your name:\n");
    scanf("%s", name);
    printf("Hello %s\n", name);
    return 0;
}
// 函数
//      [static/extern] [数据类型说明] 函数名称([参数]) {
//          return exp;
//      }
// 数组
//      数据类型  数组名称[数组长度]
// 字符
//      char str[] = "hello world";
// 指针
//      数据类型  *指针名称 = &数据类型;
// 枚举
//      typedef enum {
//          true,
//          false
//      } BOOLEAN;
// 结构
//      struct 结构名 {
//          // 变量
//      };
//      struct 结构名 变量名 = {}
//      typedef struct {
//
//      } 结构类型;
//      结构类型 变量名 = {};
// 函数指针
//      申明:
//          void (*p_func)(int, int, float) = NULL;
//          typedef void (*p_func)(int, int, float);
//      调用:
//          int val1 = p_func(1,2,3.0);
//          int val2 = (*p_func)(1,2,3.0);
```
