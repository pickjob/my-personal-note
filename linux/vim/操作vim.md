# 移动
- 基本方向
    h(左) j(下) k(上) l(右)
- 行首/行尾
    ^ / $
- 括号匹配
    %
- 文件首/尾
    gg / GG
- 百分比
    50%
- 当前页面
    H(Home) / M(Middle) / L(Last)
   zz(当前行位于中间)
- 翻页
    CTRL-F(forward) / B(backward)
# 新建一行
    o(下面) / O(上面)
# 删除
- 删除一个字符
    x
- 删除一个单词
    dw
- 删除到当行结尾
    d$
- 删除一行
    dd
- 删除换行字符
    J
# 查找
    /(正向) / ?(反向)
# 复制
- 一个字符
    y
- 一个字符
    yw
- 到行尾
    y$
- 一行
    yy
# 粘贴
    p(前面) / p(后面)
# 替换
    :substitute
    .所有行中替换
        :%substitute/four/4/g
    .特殊字符
        \<  开始
        \>  结束
# 撤销
    u
# 重做
    CTRL-R
# 可是视图
- 行选择
    V
- 列选择
    CTRL-V
# 保存
- :w
- :saveas
# 退出
    :q
- 保存退出
    ZZ
#分割窗口
    :split
    :vsplit
- 大小
    CTRL-W + / -
- 跳转
    CTRL-W
    CTRL-W h / j / k / l / t / b
- 移动窗口
    CTRL-W H / J / K / L
- 关闭
    :close
- 关闭其他
    :only
# 折叠
    zfap
    zo(Open a fold)
    zc(Close a fold)
    zr(Reduce fold)
    zR(Reduce all fold)
    zM(More fold)
    zM(More all fold)
# 标签页
    :tabedit thatfile
    :tab split
    :gt
# 剪贴板
    "+y
    "+p
# 执行外部命令
    :!sort
# 二进制文件
    vim -b datafile
    set display=uhex
    :%!xxd
    :%!xxd -r
    显示当前光标字符十六进制
        ga
