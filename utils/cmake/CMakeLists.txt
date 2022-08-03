# 
# 最低版本要求
# cmake_minimum_required(VERSION <min>[...<policy_max>] [FATAL_ERROR])
# 
cmake_minimum_required(VERSION 3.10)

# 
# 设置项目信息
# project(<PROJECT-NAME>
#         [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
#         [DESCRIPTION <project-description-string>]
#         [HOMEPAGE_URL <url-string>]
#         [LANGUAGES <language-name>...])
project(Tutorial VERSION 1.0)

# 
# 设置变量
# set(<variable> <value>... CACHE <type> <docstring> [FORCE])
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# 
# 子目录
# add library
#     <library-name>/CMakeLists.txt
#           add_library(<library-name> <library-source.cxx>)
add_subdirectory(<library-name>)

# 
# 可执行程序
# add_executable(<name> [WIN32] [MACOSX_BUNDLE]
#                [EXCLUDE_FROM_ALL]
#                [source1] [source2 ...])
add_executable(Tutorial tutorial.c)

#
# 库
# add_library(<name> [STATIC | SHARED | MODULE]
#            [EXCLUDE_FROM_ALL]
#            [<source>...])
add_library(Tutorial STATIC tutorial.c)

# 
# 链接库
# target_link_libraries(<target> ... <item>... ...)
# 
target_link_libraries(Tutorial
                        PUBLIC
                        <library-name>
                    )

# install rules
# <library-name>/CMakeLists.txt
#       install(TARGETS MathFunctions DESTINATION lib)
#       install(FILES MathFunctions.h DESTINATION include)
install(TARGETS Tutorial DESTINATION bin)

