- 变量
    - 预定义
        - ${workspaceFolder}: 当前目录路径
        - ${workspaceFolderBasename}: 当前目录名称
        - ${file}: 当前文件名
        - ${fileWorkspaceFolder}: 当前文件目录
        - ${relativeFile}: 当前文件相对当前目录路径
        - ${relativeFileDirname}: 当前文件相对当前目录文件名
        - ${fileBasename: 当前文件Basename
        - ${fileBasenameNoExtension}: 当前文件, 无Extname
        - ${fileDirname}: 当前文件Dirname
        - ${fileExtname}: 当前文件Extname
        - ${cwd}: Task运行当前目录
        - ${lineNumber}: 当前文件选中行
        - ${selectedText}: 当前文件选中内容
        - ${execPath}: Code 路径
        - ${defaultBuildTask}: 默认build任务
        - ${pathSeparator}: 路径分隔符
    - 环境变量
        - ${env:Name}
    - 用户输入
        - ${input:variableID}
            ```json
            "inputs": [
                {
                    "id": "variableID",
                    "type": "type of input variable"
                        // promptString: 用户输入
                        // pickString: 下拉选择
                        // command: Runs an arbitrary command
                    // type specific configuration attributes
                }
            ]
            ```
- .vscode下文件说明
    - tasks.json: 外部工具继承配置
        ```json
        {
            "version": "2.0.0",
            "tasks": [
                {
                    "label": "Run tests",
                    "type": "shell",
                    "command": "./scripts/test.sh",
                    "windows": {
                        "command": ".\\scripts\\test.cmd"
                    },
                    "group": "test",
                    "presentation": {
                        "reveal": "always",
                        "panel": "new"
                    }
                    // optons
                    // runOptions
                    // dependsOn
                }
            ]
        }
        ```
    - launch.json: 调试配置
        ```json
        {
            "version": "0.2.0",
            "configurations": [
                {
                    "type": "node",
                    "request": "launch", // launch attach
                    "name": "Launch Program",
                    "skipFiles": ["<node_internals>/**"],
                    "program": "${workspaceFolder}\\app.js"
                    // "preLaunchTask": "${defaultBuildTask}"
                }
            ]
        }
        ```
- C/C++扩展
    - c_cpp_properties.json: 编译器 和 IntelliSense 配置
        ```json
        {
            "configurations": [
                {
                    "name": "CLANG",
                    "includePath": ["${workspaceFolder}/**"],
                    "defines": ["_DEBUG", "UNICODE", "_UNICODE"],
                    "compilerPath": "${env:CLANG}/bin/clang",
                    "cStandard": "c17",
                    "cppStandard": "c++17",
                    "intelliSenseMode": "windows-clang-x64"
                }
            ],
            "version": 4
        }
        ```