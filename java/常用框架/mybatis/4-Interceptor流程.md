# Interceptor使用
- 支持拦截方法
    - Executor: update, query, flushStatements, commit, rollback, getTransaction, close, isClosed
    - ParameterHandler: getParameterObject, setParameters
    - ResultSetHandler: handleResultSets, handleOutputParameters
    - StatementHandler: prepare, parameterize, batch, update, query
- 插件类实现Interceptor, 辅助类Plugin
    ```java
    // Interceptor
    public interface Interceptor {
        // 拦截方法调用
        Object intercept(Invocation invocation) throws Throwable;
        // 插件一层层包装,拦截
        Object plugin(Object target);
        // 插件属性
        void setProperties(Properties properties);
    }
    // Plugin
    public class Plugin implements InvocationHandler {
        private final Object target;
        private final Interceptor interceptor;
        private final Map<Class<?>, Set<Method>> signatureMap;
        public static Object wrap(Object target, Interceptor interceptor) {
            Map<Class<?>, Set<Method>> signatureMap = getSignatureMap(interceptor);
            Class<?> type = target.getClass();
            Class<?>[] interfaces = getAllInterfaces(type, signatureMap);
            if (interfaces.length > 0) {
            return Proxy.newProxyInstance(
                type.getClassLoader(),
                interfaces,
                new Plugin(target, interceptor, signatureMap));
            }
            return target;
        }
        @Override
        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            try {
            Set<Method> methods = signatureMap.get(method.getDeclaringClass());
            if (methods != null && methods.contains(method)) {
                return interceptor.intercept(new Invocation(target, method, args));
            }
            return method.invoke(target, args);
            } catch (Exception e) {
            throw ExceptionUtil.unwrapThrowable(e);
            }
        }
        private static Map<Class<?>, Set<Method>> getSignatureMap(Interceptor interceptor) {
            Intercepts interceptsAnnotation = interceptor.getClass().getAnnotation(Intercepts.class);
            ...
            Signature[] sigs = interceptsAnnotation.value();
            Map<Class<?>, Set<Method>> signatureMap = new HashMap<>();
            Set<Method> methods = signatureMap.computeIfAbsent(sig.type(), k -> new HashSet<>());
            Method method = sig.type().getMethod(sig.method(), sig.args());
            methods.add(method);
            ...
            return signatureMap;
        }
        private static Class<?>[] getAllInterfaces(Class<?> type, Map<Class<?>, Set<Method>> signatureMap) {
            Set<Class<?>> interfaces = new HashSet<>();
            while (type != null) {
            for (Class<?> c : type.getInterfaces()) {
                if (signatureMap.containsKey(c)) {
                interfaces.add(c);
                }
            }
            type = type.getSuperclass();
            }
            return interfaces.toArray(new Class<?>[interfaces.size()]);
        }
    }
    ```