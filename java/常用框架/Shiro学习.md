# Shiro学习
- SecurityManager(org.apache.shiro.mgt.SecurityManager)
    - Subject(org.apache.shiro.subject.Subject)
    - Authentication(org.apache.shiro.authc.Authenticator)
        - ModularRealmAuthenticator
        - Authentication Sequence
            - Subject.login()
            - DelegatingSubject.login()
            - SecurityManager.login()
            - Authenticator.authenticate()
            - ModularRealmAuthenticator.authenticate()
            - Realm.support()  Realm.getAuthenticationInfo
        - Authentication Strategy(org.apache.shiro.authc.pam.AuthenticationStrategy)
            - AtLeastOneSuccessfulStrategy
            - FirstSuccessfulStrategy
            - AllSuccesssfulStrategy
    - Authorization(org.apache.shiro.authz.Authorizer)
        - ModularRealmAuthorizer
        - Authorization Sequence
            - Subject hasRole*, checkRole*, isPermitted*, checkPermission*
            - DelegatingSubject hasRole*, checkRole*, isPermitted*, checkPermission*
            - SecurityManager hasRole*, checkRole*, isPermitted*, checkPermission*
            - ModularRealmAuthorizer hasRole*, checkRole*, isPermitted*, or checkPermission*
            - Ream hasRole*, checkRole*, isPermitted*, or checkPermission*
        - RolePermissionResolver
        - PermissionResolver
            - WildcardPermissionResolver
    - Realms(org.apache.shiro.realm.Realm)
        - AuthorizingRealm
        - SimpleCredentialsMatcher
    - SessionManagement(org.apache.shiro.session.mgt.SessionManager)
        - DefaultSessionManager
        - SessionDAO(org.apache.shiro.session.mgt.eis.SessionDAO)
    - CacheManagement(org.apache.shiro.cache.CacheManager)
        - MemoryConstrainedCacheManager
    - Cryptography (org.apache.shiro.crypto.*)
        ```java
        // Subject
        Subject currentUser = SecurityUtils.getSubject();
        // AuthenticationToken
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        token.setRememberMe(true);
        // Authentication
        try {
            currentUser.login(token);
        } catch ( UnknownAccountException uae ) { ...
        } catch ( IncorrectCredentialsException ice ) { ...
        } catch ( LockedAccountException lae ) { ...
        } catch ( ExcessiveAttemptsException eae ) { ...
        } ...
        } catch ( AuthenticationException ae ) {
            //unexpected error?
        }
        // IS Remember Me
        subject.isRemembered();
        // IS Authentication
        subject.isAuthenticated();
        // Authorization
        if (currentUser.hasRole("administrator")) {
            //show the admin button
        } else {
            //don't show the button?  Grey it out?
        }
        currentUser.checkRole("bankTeller");
        Permission printPermission = new PrinterPermission("laserjet4400n", "print");
        if (currentUser.isPermitted(printPermission)) {
            //show the Print button
        } else {
            //don't show the button?  Grey it out?
        }
        // Session
        Session session = currentUser.getSession();
        session.setAttribute( "someKey", someValue);
        // Logout
        currentUser.logout();
        // Annotations
        //      @RequireAuthentication
        //      @RequireGuest
        //      @RequirePermissions
        //      @RequireRoles
        //      @RequireUser
- Servlet Support
    - Configuration
    ```xml
    <listener>
        <listener-class>org.apache.shiro.web.env.EnvironmentLoaderListener</listener-class>
    </listener>
    <context-param>
        <!-- Default IniWebEnvironment. -->
        <param-name>shiroEnvironmentClass</param-name>
        <param-value>com.foo.bar.shiro.MyWebEnvironment</param-value>
        <!-- ini location. Default WEB-INF/shiro.ini classpath:shiro.ini -->
        <param-name>shiroConfigLocations</param-name>
        <param-value>YOUR_RESOURCE_LOCATION_HERE</param-value>
    </context-param>
    <filter>
        <filter-name>ShiroFilter</filter-name>
        <filter-class>org.apache.shiro.web.servlet.ShiroFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>ShiroFilter</filter-name>
        <url-pattern>/*</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>FORWARD</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>ERROR</dispatcher>
    </filter-mapping>
    ```
    - DefaultFilters
        - anon(AnonymousFilter)
        - authc(FormAuthenticationFilter)
        - authcBasic(BasicHttpAuthenticationFilter)
        - logout(LogoutFilter)
        - noSessionCreation(NoSessionCreationFilter)
        - perms(PermissionsAuthorizationFilter)
        - port(PortFilter)
        - rest(HttpMethodPermissionFilter)
        - roles(RolesAuthorizationFilter)
        - ssl(SslFilter)
        - user(UserFilter)
    - Jsp tag
        ```xml
        <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
        <shiro:guest>
            Hi there!  Please <a href="login.jsp">Login</a> or <a href="signup.jsp">Signup</a> today!
        </shiro:guest>
        <shiro:user>
            Welcome back John!  Not John? Click <a href="login.jsp">here<a> to login.
        </shiro:user>
        <shiro:authenticated>
            <a href="updateAccount.jsp">Update your contact information</a>.
        </shiro:authenticated>
        <shiro:notAuthenticated>
            Please <a href="login.jsp">login</a> in order to update your credit card information.
        </shiro:notAuthenticated>
        Hello, <%= SecurityUtils.getSubject().getPrincipal().toString() %>, how are you today?
        User ID: <principal type="java.lang.Integer"/>
        Hello, <%= SecurityUtils.getSubject().getPrincipal().getFirstName().toString() %>, how are you today?
        Hello, <%= SecurityUtils.getSubject().getPrincipals().oneByType(com.foo.User.class).getFirstName().toString() %>, how are you today?
        <shiro:lacksRole name="administrator">
            Sorry, you are not allowed to administer the system.
        </shiro:lacksRole>
        <shiro:hasAnyRoles name="developer, project manager, administrator">
            You are either a developer, project manager, or administrator.
        </shiro:hasAnyRoles>
        <shiro:hasPermission name="user:create">
            <a href="createUser.jsp">Create a new User</a>
        </shiro:hasPermission>
        <shiro:lacksPermission name="user:delete">
            Sorry, you are not allowed to delete user accounts.
        </shiro:lacksPermission>
        ```
- Spring Web Support
    ```xml
    <!--  web.xml -->
    <!-- The filter-name matches name of a 'shiroFilter' bean inside applicationContext.xml -->
    <filter>
        <filter-name>shiroFilter</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
        <init-param>
            <param-name>targetFilterLifecycle</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>
    <!-- Make sure any request you want accessible to Shiro is filtered. /* catches all -->
    <!-- requests.  Usually this filter mapping is defined first (before all others) to -->
    <!-- ensure that Shiro works in subsequent filters in the filter chain:             -->
    <filter-mapping>
        <filter-name>shiroFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <!-- applicationContext.xml -->
    <!-- securityManager -->
    <bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
        <!-- Single realm app.  If you have multiple realms, use the 'realms' property instead. -->
        <property name="realm" ref="myRealm"/>
        <!-- By default the servlet container sessions will be used.  Uncomment this line
             to use shiro's native sessions (see the JavaDoc for more): -->
        <!-- <property name="sessionMode" value="native"/> -->
    </bean>
    <!-- shiroFilter -->
    <bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
        <property name="securityManager" ref="securityManager"/>
        <!-- override these for application-specific URLs if you like:
        <property name="loginUrl" value="/login.jsp"/>
        <property name="successUrl" value="/home.jsp"/>
        <property name="unauthorizedUrl" value="/unauthorized.jsp"/> -->
        <!-- The 'filters' property is not necessary since any declared javax.servlet.Filter bean  -->
        <!-- defined will be automatically acquired and available via its beanName in chain        -->
        <!-- definitions, but you can perform instance overrides or name aliases here if you like: -->
        <!-- <property name="filters">
            <util:map>
                <entry key="anAlias" value-ref="someFilter"/>
            </util:map>
        </property> -->
        <property name="filterChainDefinitions">
            <value>
                # some example chain definitions:
                /admin/** = authc, roles[admin]
                /docs/** = authc, perms[document:read]
                /** = authc
                # more URL-to-FilterChain definitions here
            </value>
        </property>
    </bean>
    <!-- Define any javax.servlet.Filter beans you want anywhere in this application context.   -->
    <!-- They will automatically be acquired by the 'shiroFilter' bean above and made available -->
    <!-- to the 'filterChainDefinitions' property.  Or you can manually/explicitly add them     -->
    <!-- to the shiroFilter's 'filters' Map if desired. See its JavaDoc for more details.       -->
    <bean id="someFilter" class="..."/>
    <!-- Define the Shiro Realm implementation you want to use to connect to your back-end -->
    <!-- security datasource: -->
    <bean id="myRealm" class="..."/>
    <!-- Enable Shiro Annotations for Spring-configured beans.  Only run after -->
    <!-- the lifecycleBeanProcessor has run: -->
    <bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"
        depends-on="lifecycleBeanPostProcessor">
        <bean class="org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor">
        <property name="securityManager" ref="securityManager"/>
    </bean>
    <bean id="lifecycleBeanPostProcessor" class="org.apache.shiro.spring.LifecycleBeanPostProcessor"/>
    <!-- Secure Spring remoting:  Ensure any Spring Remoting method invocations -->
    <!-- can be associated with a Subject for security checks. -->
    <bean id="secureRemoteInvocationExecutor" class="org.apache.shiro.spring.remoting.SecureRemoteInvocationExecutor">
        <property name="securityManager" ref="securityManager"/>
    </bean>
    <bean name="/someService" class="org.springframework.remoting.httpinvoker.HttpInvokerServiceExporter">
        <property name="service" ref="someService"/>
        <property name="serviceInterface" value="com.pkg.service.SomeService"/>
        <property name="remoteInvocationExecutor" ref="secureRemoteInvocationExecutor"/>
    </bean>
    <bean id="secureRemoteInvocationFactory" class="org.apache.shiro.spring.remoting.SecureRemoteInvocationFactory"/>
    <bean id="someService" class="org.springframework.remoting.httpinvoker.HttpInvokerProxyFactoryBean">
        <property name="serviceUrl" value="http://host:port/remoting/someService"/>
        <property name="serviceInterface" value="com.pkg.service.SomeService"/>
        <property name="remoteInvocationFactory" ref="secureRemoteInvocationFactory"/>
    </bean>
    ```