# Swagger学习
- 注解
    ```java
    // 给 Controller 添加描述信息
    @Api(
        tags, // 控制器标签
        description // 控制器描述（该字段被申明为过期）
    )
    // 给接口添加描述信息
    @ApiOperation(
        value, // 接口说明。
        notes, // 接口发布说明。
        tags, // 标签。
        response, // 接口返回类型。
        httpMethod // 接口请求方式。
    )
    // Form参数描述信息
    @ApiImplicitParams / @ApiImplicitParam(
        paramType, // 查询参数类型，实际上就是参数放在那里。取值：
                    //  path：以地址的形式提交数据，根据 id 查询用户的接口就是这种形式传参。
                    //  query：Query string 的方式传参。
                    //  header：以流的形式提交。
                    //  form：以 Form 表单的形式提交。
        dataType, //参数的数据类型。取值：
                    // Long
                    // String
        name, // 参数名字。
        value, // 参数意义的描述。
        required, // 是否必填。取值：
                    // true：必填参数。
                    // false：非必填参数。
    )
    //  JSON对象类描述信息
    @ApiModel / @ApiModelProperty(
        value, // 字段说明。
        name, // 重写字段名称。
        dataType, // 重写字段类型。
        required, // 是否必填。
        example, // 举例说明。
        hidden, // 是否在文档中隐藏该字段。
        allowEmptyValue, // 是否允许为空。
        allowableValues // 该字段允许的值，当我们 API 的某个参数为枚举类型时，使用这个属性就可以清楚地告诉 API 使用者该参数所能允许传入的值。
    )
    @RequestParam / @RequestHeader
    ```
- Spring boot配置
    - Docket
        - select(): ApiSelectorBuilder
- 默认地址
    - api-docs
        - /v2/api-docs
    - Swagger UI
        - /swagger-ui.html
