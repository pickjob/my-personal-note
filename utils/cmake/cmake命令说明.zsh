# 
# cmake常用命令
# 
#   构建文件生成
#       -G <generator-name>: $CMAKE_GENERATOR
#           "MinGW Makefiles"
#           "Ninja"
cmake [<options>] <path-to-source>
cmake [<options>] -S <path-to-source> -B <path-to-build>
#   构建
cmake --build <dir>
#   安装
#       --install <dir>
#       --prefix <prefix>
cmake --install <dir> [<options>]
