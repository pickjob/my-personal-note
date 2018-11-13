# 动态sql
- LanguageDriver
    ```java
    public interface LanguageDriver {
        ParameterHandler createParameterHandler(MappedStatement mappedStatement, Object parameterObject, BoundSql boundSql);
        // 解析xml Mapper时调用
        SqlSource createSqlSource(Configuration configuration, XNode script, Class<?> parameterType);
        // 解析注解 Mapper时调用
        SqlSource createSqlSource(Configuration configuration, String script, Class<?> parameterType);
    }
    ```
- 内置XMLLanguageDriver构建
    ```java
    //  XMLLanguageDriver 实际委托xml解析
    public SqlSource createSqlSource(Configuration configuration, XNode script, Class<?> parameterType) {
        XMLScriptBuilder builder = new XMLScriptBuilder(configuration, script, parameterType);
        return builder.parseScriptNode();
    }
    public SqlSource createSqlSource(Configuration configuration, String script, Class<?> parameterType) {
        if (script.startsWith("<script>")) {
            XPathParser parser = new XPathParser(script, false, configuration.getVariables(), new XMLMapperEntityResolver());
            return createSqlSource(configuration, parser.evalNode("/script"), parameterType);
        } else {
            script = PropertyParser.parse(script, configuration.getVariables());
            TextSqlNode textSqlNode = new TextSqlNode(script);
            if (textSqlNode.isDynamic()) {
                return new DynamicSqlSource(configuration, textSqlNode);
            } else {
                return new RawSqlSource(configuration, script, parameterType);
            }
        }
    }
    // XMLScriptBuilder
    private void initNodeHandlerMap() {
        // 支持的动态元素
        nodeHandlerMap.put("trim", new TrimHandler());
        nodeHandlerMap.put("where", new WhereHandler());
        nodeHandlerMap.put("set", new SetHandler());
        nodeHandlerMap.put("foreach", new ForEachHandler());
        nodeHandlerMap.put("if", new IfHandler());
        nodeHandlerMap.put("choose", new ChooseHandler());
        nodeHandlerMap.put("when", new IfHandler());
        nodeHandlerMap.put("otherwise", new OtherwiseHandler());
        nodeHandlerMap.put("bind", new BindHandler());
    }
    public SqlSource parseScriptNode() {
        MixedSqlNode rootSqlNode = parseDynamicTags(context);
        SqlSource sqlSource = null;
        if (isDynamic) {
            sqlSource = new DynamicSqlSource(configuration, rootSqlNode);
        } else {
            sqlSource = new RawSqlSource(configuration, rootSqlNode, parameterType);
        }
        return sqlSource;
    }
    protected MixedSqlNode parseDynamicTags(XNode node) {
        List<SqlNode> contents = new ArrayList<>();
        NodeList children = node.getNode().getChildNodes();
        for (int i = 0; i < children.getLength(); i++) {
        XNode child = node.newXNode(children.item(i));
        if (child.getNode().getNodeType() == Node.CDATA_SECTION_NODE || child.getNode().getNodeType() == Node.TEXT_NODE) {
            String data = child.getStringBody("");
            TextSqlNode textSqlNode = new TextSqlNode(data);
            if (textSqlNode.isDynamic()) {
                contents.add(textSqlNode);
                isDynamic = true;
            } else {
                contents.add(new StaticTextSqlNode(data));
            }
        } else if (child.getNode().getNodeType() == Node.ELEMENT_NODE) { // issue #628
            String nodeName = child.getNode().getNodeName();
            NodeHandler handler = nodeHandlerMap.get(nodeName);
            if (handler == null) {
                throw new BuilderException("Unknown element <" + nodeName + "> in SQL statement.");
            }
            handler.handleNode(child, contents);
            isDynamic = true;
        }
        }
        return new MixedSqlNode(contents);
    }
    private interface NodeHandler {
        void handleNode(XNode nodeToHandle, List<SqlNode> targetContents);
    }
    ```
- sqlSource实际解析
    ```java
    // DynamicSqlSource
    public BoundSql getBoundSql(Object parameterObject) {
        DynamicContext context = new DynamicContext(configuration, parameterObject);
        rootSqlNode.apply(context);
        SqlSourceBuilder sqlSourceParser = new SqlSourceBuilder(configuration);
        Class<?> parameterType = parameterObject == null ? Object.class : parameterObject.getClass();
        SqlSource sqlSource = sqlSourceParser.parse(context.getSql(), parameterType, context.getBindings());
        BoundSql boundSql = sqlSource.getBoundSql(parameterObject);
        for (Map.Entry<String, Object> entry : context.getBindings().entrySet()) {
        boundSql.setAdditionalParameter(entry.getKey(), entry.getValue());
        }
        return boundSql;
    }
    // SqlNode
    public interface SqlNode {
        boolean apply(DynamicContext context);
    }
    // MixSqlNode
    public boolean apply(DynamicContext context) {
        for (SqlNode sqlNode : contents) {
        sqlNode.apply(context);
        }
        return true;
    }
    // StaticSqlNode
    public boolean apply(DynamicContext context) {
        context.appendSql(text);
        return true;
    }
    // IfSqlNode
    public boolean apply(DynamicContext context) {
        if (evaluator.evaluateBoolean(test, context.getBindings())) {
            contents.apply(context);
            return true;
        }
        return false;
    }
    ```