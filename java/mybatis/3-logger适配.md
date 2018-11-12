# logger适配
- 日志框架的自动配置
    ```java
    // LogFactory
    static {
        tryImplementation(LogFactory::useSlf4jLogging);
        tryImplementation(LogFactory::useCommonsLogging);
        tryImplementation(LogFactory::useLog4J2Logging);
        tryImplementation(LogFactory::useLog4JLogging);
        tryImplementation(LogFactory::useJdkLogging);
        tryImplementation(LogFactory::useNoLogging);
    }
    private static void tryImplementation(Runnable runnable) {
        if (logConstructor == null) {
            try {
                runnable.run();
            } catch (Throwable t) {
                // ignore
            }
        }
    }
    public static synchronized void useLog4J2Logging() {
        setImplementation(org.apache.ibatis.logging.log4j2.Log4j2Impl.class);
    }
    // 尝试创建，成功就设置，未成功就继续尝试
    private static void setImplementation(Class<? extends Log> implClass) {
        try {
            Constructor<? extends Log> candidate = implClass.getConstructor(String.class);
            Log log = candidate.newInstance(LogFactory.class.getName());
            if (log.isDebugEnabled()) {
                log.debug("Logging initialized using '" + implClass + "' adapter.");
            }
            logConstructor = candidate;
        } catch (Throwable t) {
            throw new LogException("Error setting Log implementation.  Cause: " + t, t);
        }
    }
    ```
- Sql日志记录
    - 代理实现(JDK代理),记录sql日志
    - ConnectionLogger
        ```java
        public Object invoke(Object proxy, Method method, Object[] params) throws Throwable {
            try {
                if (Object.class.equals(method.getDeclaringClass())) {
                    return method.invoke(this, params);
                }
                if ("prepareStatement".equals(method.getName())) {
                    if (isDebugEnabled()) {
                    debug(" Preparing: " + removeBreakingWhitespace((String) params[0]), true);
                    }        
                    PreparedStatement stmt = (PreparedStatement) method.invoke(connection, params);
                    stmt = PreparedStatementLogger.newInstance(stmt, statementLog, queryStack);
                    return stmt;
                } else if ("prepareCall".equals(method.getName())) {
                    if (isDebugEnabled()) {
                    debug(" Preparing: " + removeBreakingWhitespace((String) params[0]), true);
                    }        
                    PreparedStatement stmt = (PreparedStatement) method.invoke(connection, params);
                    stmt = PreparedStatementLogger.newInstance(stmt, statementLog, queryStack);
                    return stmt;
                } else if ("createStatement".equals(method.getName())) {
                    Statement stmt = (Statement) method.invoke(connection, params);
                    stmt = StatementLogger.newInstance(stmt, statementLog, queryStack);
                    return stmt;
                } else {
                    return method.invoke(connection, params);
                }
            } catch (Throwable t) {
                throw ExceptionUtil.unwrapThrowable(t);
            }
        }
        ```
    - StatementLogger
        ```java
        public Object invoke(Object proxy, Method method, Object[] params) throws Throwable {
            try {
                if (Object.class.equals(method.getDeclaringClass())) {
                    return method.invoke(this, params);
                }    
                if (EXECUTE_METHODS.contains(method.getName())) {
                    if (isDebugEnabled()) {
                        debug(" Executing: " + removeBreakingWhitespace((String) params[0]), true);
                    }
                    if ("executeQuery".equals(method.getName())) {
                        ResultSet rs = (ResultSet) method.invoke(statement, params);
                        return rs == null ? null : ResultSetLogger.newInstance(rs, statementLog, queryStack);
                    } else {
                        return method.invoke(statement, params);
                    }
                } else if ("getResultSet".equals(method.getName())) {
                    ResultSet rs = (ResultSet) method.invoke(statement, params);
                    return rs == null ? null : ResultSetLogger.newInstance(rs, statementLog, queryStack);
                } else {
                    return method.invoke(statement, params);
                }
            } catch (Throwable t) {
                throw ExceptionUtil.unwrapThrowable(t);
            }
        }
        ```
    - PreparedStatementLogger
        ```java
        public Object invoke(Object proxy, Method method, Object[] params) throws Throwable {
            try {
                if (Object.class.equals(method.getDeclaringClass())) {
                    return method.invoke(this, params);
                }          
                if (EXECUTE_METHODS.contains(method.getName())) {
                    if (isDebugEnabled()) {
                    debug("Parameters: " + getParameterValueString(), true);
                    }
                    clearColumnInfo();
                    if ("executeQuery".equals(method.getName())) {
                    ResultSet rs = (ResultSet) method.invoke(statement, params);
                    return rs == null ? null : ResultSetLogger.newInstance(rs, statementLog, queryStack);
                    } else {
                    return method.invoke(statement, params);
                    }
                } else if (SET_METHODS.contains(method.getName())) {
                    if ("setNull".equals(method.getName())) {
                    setColumn(params[0], null);
                    } else {
                    setColumn(params[0], params[1]);
                    }
                    return method.invoke(statement, params);
                } else if ("getResultSet".equals(method.getName())) {
                    ResultSet rs = (ResultSet) method.invoke(statement, params);
                    return rs == null ? null : ResultSetLogger.newInstance(rs, statementLog, queryStack);
                } else if ("getUpdateCount".equals(method.getName())) {
                    int updateCount = (Integer) method.invoke(statement, params);
                    if (updateCount != -1) {
                    debug("   Updates: " + updateCount, false);
                    }
                    return updateCount;
                } else {
                    return method.invoke(statement, params);
                }
            } catch (Throwable t) {
                throw ExceptionUtil.unwrapThrowable(t);
            }
        }
        ```
    - ResultSetLogger
        ```java
        public Object invoke(Object proxy, Method method, Object[] params) throws Throwable {
            try {
                if (Object.class.equals(method.getDeclaringClass())) {
                    return method.invoke(this, params);
                }    
                Object o = method.invoke(rs, params);
                if ("next".equals(method.getName())) {
                    if (((Boolean) o)) {
                    rows++;
                    if (isTraceEnabled()) {
                        ResultSetMetaData rsmd = rs.getMetaData();
                        final int columnCount = rsmd.getColumnCount();
                        if (first) {
                        first = false;
                        printColumnHeaders(rsmd, columnCount);
                        }
                        printColumnValues(columnCount);
                    }
                    } else {
                    debug("     Total: " + rows, false);
                    }
                }
                clearColumnInfo();
                return o;
            } catch (Throwable t) {
                throw ExceptionUtil.unwrapThrowable(t);
            }
        }
        ```