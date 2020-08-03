# Linux Desktop Entry
- 后缀名
    - .desktop
- 位置
    - /usr/share/applications
    - /usr/local/share/applications/
- 文件结构
    - Comment
    -  \#
    - [Desktop Entry]
        - Type (REQ)
            - Application : 应用程序
            - Link : 一个URL
            - Directory
        - Name(REQ) : 名称
        - GenericName (OPT)
        - NoDisplay (OPT) : true / false
            - this application exists, but don't display it in the menus
        - Comment
        - Icon
        - DBusActivatable : true / false
        - TryExec
        - Exec : 执行的命令
            - %f : A single file name
            - %F : A list of files
            - %u : A single URL
            - %U : 	A list of URLs
        - Path : the working directory
        - Actions
        - MimeType
        - URL : 指向的URL
        - StartupNotify : true / false
        - Terminal : true / false
        - Categories
            - AudioVideo	A multimedia (audio/video) application	 
            - Audio	An audio application
            - Video	A video application
            - Development	An application for development
                - Building	A tool to build applications
                - Debugger	A tool to debug applications
                - IDE	IDE application
                - GUIDesigner	A GUI designer application
                - Profiling	A profiling tool
                - RevisionControl	Applications like cvs or subversion
                - Translation	A translation tool
            - Education	Educational software	 
            - Game	A game	 
            - Graphics	Graphical application	 
            - Network	Network application such as a web browser	 
            - Office	An office type application	 
            - Settings	Settings applications
            - System	System application, "System Tools" such as say a log viewer or network          -monitor	 
            - Utility	Small utility application, "Accessories"
- Example
```bash
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Foo Viewer
    Comment=The best viewer for Foo objects available!
    TryExec=fooview
    Exec=fooview %F
    Icon=fooview
    MimeType=image/x-foo;
    Actions=Gallery;Create;

    [Desktop Action Gallery]
    Exec=fooview --gallery
    Name=Browse Gallery

    [Desktop Action Create]
    Exec=fooview --create-new
    Name=Create a new Foo!
    Icon=fooview-new
```