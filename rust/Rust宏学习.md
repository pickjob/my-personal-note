# Rust 学习
```rust
macro_rules! $name {
   ($pattern) => {$expansion};
   ($pattern) => {$expansion};
   ($pattern) => {$expansion};
}
//  Captures
//    $e: xx
//      item: an item, like a function, struct, module, etc.
//      block: a block (i.e. a block of statements and/or an expression, surrounded by braces)
//      stmt: a statement
//      pat: a pattern
//      expr: an expression
//      ty: a type
//      ident: an identifier
//      path: a path (e.g. foo, ::std::mem::replace, transmute::<_, int>, …)
//      meta: a meta item; the things that go inside #[...] and #![...] attributes
//      tt: a single token tree

//  Repetitions
//    $ ( ... ) sep rep
//      $ is a literal dollar token
//      ( ... ) is the paren-grouped pattern being repeated
//      sep is an optional separator token. Common examples are , and ;
//      rep is the required repeat control. * (indicating zero or more repeats) or + (indicating one or more repeats)
//  Example:
//   $(...)*
//   $(...);*

//  Debug
//    #[feature(trace_macros)]
//    trace_macros!(true);
macro_rules! vec_strs {
    (
        $( $ele: expr ) , *
    ) => {
        {
            let mut v = Vec::new();
            ${ v.push(format!("{}", $ele)); }*
            v
        }
    }
}
// callback
macro_rules! callback {
    ( $callback:ident($($args:tt)* )) => {
        $callback!($($args)*)
    };
}
// incremental TT munchers
macro_rules! mixed_rules {
    () => {};
    (trace $name:ident; $($tail:tt)*) => {
        {
            println!(concat!(stringify!($name), " = {:?}"), $name);
            mixed_rules!($($tail)*);
        }
    };
    (trace $name:ident = $init:expr; $($tail:tt)*) => {
        {
            let $name = $init;
            println!(concat!(stringify!($name), " = {:?}"), $name);
            mixed_rules!($($tail)*);
        }
    };
}
// internal
macro_rules! crate_name_util {
    (@as_expr $e:expr) => {$e};
    (@as_item $i:item) => {$i};
    (@count_tts) => {0usize};
    // ...
}
// Push-down Accumulation
macro_rules! init_array {
    (@accum (0, $_e:expr) -> ($($body:tt)*))
        => {init_array!(@as_expr [$($body)*])};
    (@accum (1, $e:expr) -> ($($body:tt)*))
        => {init_array!(@accum (0, $e) -> ($($body)* $e,))};
    (@accum (2, $e:expr) -> ($($body:tt)*))
        => {init_array!(@accum (1, $e) -> ($($body)* $e,))};
    (@accum (3, $e:expr) -> ($($body:tt)*))
        => {init_array!(@accum (2, $e) -> ($($body)* $e,))};
    (@as_expr $e:expr) => {$e};
    [$e:expr; $n:tt] => {
        {
            let e = $e;
            init_array!(@accum ($n, e.clone()) -> ())
        }
    };
}
// Repetition replacement
macro_rules! replace_expr {
    ($_t:tt $sub:expr) => {$sub};
}
macro_rules! count_tts {
    ($($tts:tt)*) => {<[()]>::len(&[$(replace_expr!($tts ())),*])};
}
macro_rules! tuple_default {
    ($($tup_tys:ty),*) => {
        (
            $(
                replace_expr!(
                    ($tup_tys)
                    Default::default()
                ),
            )*
        )
    };
}
// Trailing separators
macro_rules! match_exprs {
    ($($exprs:expr),* $(,)*) => {...};
}
// TT Bundling
macro_rules! count_tts {
    () => {0usize};
    ($_head:tt $($tail:tt)*) => {1usize + count_tts!($($tail)*)};
}
macro_rules! count_tts {
    ($_a:tt $_b:tt $_c:tt $_d:tt $_e:tt
     $_f:tt $_g:tt $_h:tt $_i:tt $_j:tt
     $_k:tt $_l:tt $_m:tt $_n:tt $_o:tt
     $_p:tt $_q:tt $_r:tt $_s:tt $_t:tt
     $($tail:tt)*)
        => {20usize + count_tts!($($tail)*)};
    ($_a:tt $_b:tt $_c:tt $_d:tt $_e:tt
     $_f:tt $_g:tt $_h:tt $_i:tt $_j:tt
     $($tail:tt)*)
        => {10usize + count_tts!($($tail)*)};
    ($_a:tt $_b:tt $_c:tt $_d:tt $_e:tt
     $($tail:tt)*)
        => {5usize + count_tts!($($tail)*)};
    ($_a:tt
     $($tail:tt)*)
        => {1usize + count_tts!($($tail)*)};
    () => {0usize};
}
macro_rules! call_a_or_b_on_tail {
    ((a: $a:expr, b: $b:expr), call a: $($tail:tt)*) => {
        $a(stringify!($($tail)*))
    };

    ((a: $a:expr, b: $b:expr), call b: $($tail:tt)*) => {
        $b(stringify!($($tail)*))
    };

    ($ab:tt, $_skip:tt $($tail:tt)*) => {
        call_a_or_b_on_tail!($ab, $($tail)*)
    };
}
fn compute_len(s: &str) -> Option<usize> {
    Some(s.len())
}
fn show_tail(s: &str) -> Option<usize> {
    println!("tail: {:?}", s);
    None
}
macro_rules! count_idents {
    ($($idents:ident),* $(,)*) => {
        {
            #[allow(dead_code, non_camel_case_types)]
            enum Idents { $($idents,)* __CountIdentsLast }
            const COUNT: u32 = Idents::__CountIdentsLast as u32;
            COUNT
        }
    };
}
// AST Coercion
macro_rules! as_expr { ($e:expr) => {$e} }
macro_rules! as_item { ($i:item) => {$i} }
macro_rules! as_pat  { ($p:pat) =>  {$p} }
macro_rules! as_stmt { ($s:stmt) => {$s} }
// Enum parsing
macro_rules! parse_unitary_variants {
    (@as_expr $e:expr) => {$e};
    (@as_item $($i:item)+) => {$($i)+};
    // Exit rules.
    (
        @collect_unitary_variants ($callback:ident ( $($args:tt)* )),
        ($(,)*) -> ($($var_names:ident,)*)
    ) => {
        parse_unitary_variants! {
            @as_expr
            $callback!{ $($args)* ($($var_names),*) }
        }
    };
    (
        @collect_unitary_variants ($callback:ident { $($args:tt)* }),
        ($(,)*) -> ($($var_names:ident,)*)
    ) => {
        parse_unitary_variants! {
            @as_item
            $callback!{ $($args)* ($($var_names),*) }
        }
    };
    // Consume an attribute.
    (
        @collect_unitary_variants $fixed:tt,
        (#[$_attr:meta] $($tail:tt)*) -> ($($var_names:tt)*)
    ) => {
        parse_unitary_variants! {
            @collect_unitary_variants $fixed,
            ($($tail)*) -> ($($var_names)*)
        }
    };
    // Handle a variant, optionally with an with initialiser.
    (
        @collect_unitary_variants $fixed:tt,
        ($var:ident $(= $_val:expr)*, $($tail:tt)*) -> ($($var_names:tt)*)
    ) => {
        parse_unitary_variants! {
            @collect_unitary_variants $fixed,
            ($($tail)*) -> ($($var_names)* $var,)
        }
    };
    // Abort on variant with a payload.
    (
        @collect_unitary_variants $fixed:tt,
        ($var:ident $_struct:tt, $($tail:tt)*) -> ($($var_names:tt)*)
    ) => {
        const _error: () = "cannot parse unitary variants from enum with non-unitary variants";
    };
    // Entry rule.
    (enum $name:ident {$($body:tt)*} => $callback:ident $arg:tt) => {
        parse_unitary_variants! {
            @collect_unitary_variants
            ($callback $arg), ($($body)*,) -> ()
        }
    };
}
```