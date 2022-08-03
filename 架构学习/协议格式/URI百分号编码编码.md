# URI百分号编码
- URI百分号编码
  - 'a' - 'z', 'A' - 'Z', '0' - '9' 不变
  - '.', '-', '_', '~'不变
  - 其余字符按编码转为字节，每个字节按"%xy"十六进制格式表达
  - Quirks
    - 表单application/x-www-form-urlencoded中' ' 转换为 '+'
