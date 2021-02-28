# Zeal docset文件格式学习
- 根目录(*.docset)
    - Contents
        - Info.plist(xml)
        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>CFBundleName</key>
            <string>Vim</string>
            <key>DocSetPlatformFamily</key>
            <string>cheatsheet</string>
            <key>dashIndexFilePath</key>
            <string>index.html</string>
            <key>isJavaScriptEnabled</key>
            <true/>
        </dict>
        </plist>
        ```
        - Resources
            - Documents
            - docSet.dsidx(sqlite)
                - CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT)
    - meta.json
        - name
        - title
        - version
        - revision
    - icon.png icon@2x.png
