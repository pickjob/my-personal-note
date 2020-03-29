# Rust宏学习
- 元编程分类
    - 简单文本替换(C/C++宏)
    - 类型模板(C++模板)
    - 反射(Ruby, Java, Go, Rust)
    - 语法扩展(Ruby, Rust)
    - 代码自动生成(Go)
- Any
    ```rust
    pub trait Any: 'static {
        fn type_id(&self) -> TypeId;
    }
    impl dyn Any {
        pub fn is<T>(&self) -> bool;
        pub fn downcast_ref<T>(&self) -> Option<&T>;
        pub fn downcast_mut<T>(&mut self) -> Option<&mut T>;
    }
    impl<T> Any for T
    ```
- 宏
    - 声明宏(Declarative Macro)
        ```rust
        macro_rules! $name {
            ($arg: ty) => {$expansion};
            ...
        }
        //  $arg: ty
        //      item: 语言项, like a function, struct, module, etc.
        //      block: 代码块, surrounded by braces
        //      stmt: 语句, surrounded by semicolons
        //      pat: a pattern
        //      expr: an expression
        //      ty: a type
        //      ident: an identifier
        //      path: a path (e.g. foo, ::std::mem::replace, transmute::<_, int>, …)
        //      meta: 元信息 the things that go inside #[...] and #![...] attributes
        //      tt: a single token tree
        //      vis: 可见性, pub
        //      lifetime: 生命周期
        //  Repetitions
        //    $ ( ... ) sep rep
        //      sep is an optional separator token. Common examples are , and ;
        //      rep is the required repeat control. * (indicating zero or more repeats) or + (indicating one or more repeats)
        //  Debug
        //    #[feature(trace_macros)]
        //    trace_macros!(true);

        // 匹配最后一个分隔符
        macro_rules! match_exprs {
            (
                $($exprs:expr) , *  $(,)*
            ) => {
                let _cap = [()]::len(&[(), ()])
            };
        }
        // 递归回调宏
        macro_rules! invoke_with_callback {
            ( $callback:ident($($args:tt)* )) => {
                $callback!($($args)*)
            };
        }
        ```
    - 过程宏(Procedural Macro)
        ```rust
        #[proc_macro_derive]
        #[proc_macro_attribute]
        #[attr_with_args]
        ```
        - 自定义派生属性
        - 自定义属性
        - Bang宏
- 第三方包
    - syn
    - quote