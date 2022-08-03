# 环境变量
#   NINJA_STATUS: [%f/%t]
#       %f: finished number of edges
#       %t: total number of edges
#       %e: Elapsed time in seconds
# 构建
ninja
# 其他参数
#   -t: 工具
#       clean: remove built files
#       browse: browse the dependency graph in a web browser
ninja -t browse --port=8000 --no-browser mytarget
