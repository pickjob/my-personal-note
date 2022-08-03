# Http常用Header学习
- Referer: (正确拼写应该是Referrer)
    - Referrer-Polcy
        - no-referrer
        - no-referrer-when-downgrade (default)
        - origin
        - origin-when-cross-origin
        - same-origin
        - strict-origin
        - strict-origin-when-cross-origin
        - unsafe-url
    - 集成
        - <meta name="referrer" content="origin">
- Authorization: Basic xx(user:pass base64)
- Set-Cookie: <cookie-name>=<cookie-value>; Expires=<date>; Domain=<domain-value>; PATH=<path-value>; Secure; HttpOnly
- Cookie: name=value; name2=value2; name3=value3
- Content-Disposition: attachment; filename=filename.ext
- Content-Disposition: form-data; name="fieldName"; filename="filename.jpg"
- Content-Type: MIME
    - 格式
        - top-level type name / subtype name [ ; parameters ]
    - 常见实例
        - text/plain
        - text/html
        - text/css

        - image/gif
        - image/jpeg

        - video/mpeg

        - application/json
        - application/javascript
        - application/xml
        - application/zip
        - application/pdf
        - application/sql

        - application/msword (.doc)
        - application/vnd.openxmlformats-officedocument.wordprocessingml.document(.docx)
        - application/vnd.ms-excel (.xls)
        - application/vnd.openxmlformats-officedocument.spreadsheetml.sheet (.xlsx)
        - application/vnd.ms-powerpoint (.ppt)
        - application/vnd.openxmlformats-officedocument.presentationml.presentation (.pptx)
        - application/vnd.oasis.opendocument.text (.odt)
  
    - application/x-www-form-urlencoded
    - application/octet-stream

    - multipart/form-data;boundary=--AaB03x
