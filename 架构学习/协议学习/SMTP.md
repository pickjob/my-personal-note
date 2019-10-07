# SMTP学习
- 命令
  - HELO : 发送端主机名
  - MAIL FROM : 发信人
  - RCPT TO : 预期接信人
  - DATA : 邮件主题
  - QUIT : 退出
  - RSET : 重置
  - VRFY
  - ExPN
  - HELP
- 应答
  - 220 : 服务就绪
  - 221 : 服务关闭传输通道
  - 250 : 请求命令完成
  - 251 : 保温将被转发
  - 354 : 开始邮件输入
  - 450 : 邮件不可使用
  - 500 : 语法错误，不能识别命令
  - 502 : 命令为实现
  - 552 : 所请求操作异常终止
  - 553 : 所请求操作未发生
- 报文格式
  ```tcp
  # 信封
  MAIL FROM: csse@su.edu.cn(\r\n)
  RCPT TO: cs@pku.edu.cn(\r\n)
  # 首部
  From: software school(\r\n)
  To: computer science(\r\n)
  Date: 29/05/2010
  Subject: network book(\r\n)
  MIME-Version: 1.0
  Content-Type: image/jpeg
  # 主体
  Dear Sir:
  All my ...
  ...
  Zhang San
  (\r\n)
  ```