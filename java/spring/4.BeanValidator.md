# BeanValidator学习
- Validator
    ```java
    Validator validator = Validation.buildDefaultValidatorFactory()
                                        .getValidator();
    Set<ConstraintViolation<Person>> errors = validator.validate(new Person(null, null));
    for (ConstraintViolation<Person> err : errors) {
        logger.info("Person校验失败, 路径{}, 值:{}, 信息:{}", err.getPropertyPath(), err.getInvalidValue(), err.getMessage());
    }
    ```
- @Valid : 级联校验
- 自定义, 注解@Constraint, 实现ConstraintValidator
    ```java
    // CamelCase.java
    @Target({ METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE })
    @Retention(RUNTIME)
    @Documented
    @Constraint(validatedBy = CamelCaseValiditor.class)
    @Repeatable(List.class)
    public @interface CamelCase {
        String message() default "CamelCase Error";

        Class<?>[] groups() default { };

        Class<? extends Payload>[] payload() default { };

        @Target({ METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE })
        @Retention(RUNTIME)
        @Documented
        @interface List {
            CamelCase[] value();
        }
    }
    // CamelCaseValidator
    public class CamelCaseValiditor implements ConstraintValidator<CamelCase, String> {
        private static final Logger logger = LogManager.getLogger(CamelCaseValiditor.class);

        @Override
        public boolean isValid(String value, ConstraintValidatorContext context) {
            logger.info("value:{}", value);
            return false;
        }

    }
    ```