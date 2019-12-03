# BeanValidator学习
- javax.validation.constraints
    - @AssertFalse
    - @AssertTrue
    - @DecimalMax
    - @DecimalMin
    - @Digits
    - @Future
    - @Max
    - @Min
    - @NotNull
    - @Null
    - @Past
    - @Pattern
    - @Size
- 自定义
    ```java
    // annotation
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
    // validator
    public class CamelCaseValiditor implements ConstraintValidator<CamelCase, String> {
        @Override
        public boolean isValid(String value, ConstraintValidatorContext context) {
            if (StringUtils.isNotBlank(value)) {
                if (value.charAt(0) >= 'a' && value.charAt(0) <= 'z') return true;
            }
            return false;
        }
    }
    ```