# JAXB(Java Architecture for XML Binding)学习
    ```java
    // package
    // @XmlSchema
    @XmlSchema ( 
        xmlns = {}, 
        namespace = "", 
        elementFormDefault = XmlNsForm.UNSET, 
        attributeFormDefault = XmlNsForm.UNSET
    )
    // @XmlAccessorType
    @XmlAccessorType (
        value = AccessType.PUBLIC_MEMBER 
    )
    // @XmlAccessorOrder
    @XmlAccessorOrder (
        value = AccessorOrder.UNDEFINED
    )
    // @XmlSchemaType
    @XmlSchemaType (
        namespace = "http://www.w3.org/2001/XMLSchema", 
        type = DEFAULT.class
    )
    @XmlSchemaTypes
    // class
    // @XmlType
    @XmlType (
        name = "##default", 
        propOrder = {""}, 
        namespace = "##default", 
        factoryClass = DEFAULT.class, 
        factoryMethod = ""
    )
    // @XmlRootElement
    @XmlRootElement (
        name = "##default", 
        namespace = "##default" 
    )
    // enum
    // @XmlEnum
    @XmlEnum ( value = String.class )
    @XmlEnumValue
    // Java Properties and Fields
    //  @XmlElement
    @XmlElement (
        name = "##default", 
        nillable = false, 
        namespace = "##default", 
        type = DEFAULT.class, 
        defaultValue = "\u0000"
    )
    // @XmlElements
    // @XmlElementRef
    @XmlElementRef (
        name = "##default", 
        namespace = "##default", 
        type = DEFAULT.class
    )
    // @XmlElementRefs
    // @XmlElementWrapper
    @XmlElementWrapper (
        name = "##default", 
        namespace = "##default", 
        nillable = false
    )
    // @XmlAnyElement
    @XmlAnyElement (
        lax = false, 
        value = W3CDomHandler.class
    )
    // @XmlAttribute
    @XmlAttribute (
        name = ##default, 
        required = false, 
        namespace = "##default" 
    )
    // @XmlAnyAttribute
    // @XmlTransient
    // @XmlValue
    // @XmlID
    // @XmlIDREF
    // @XmlList
    // @XmlMixed
    // @XmlMimeType
    // @XmlAttachmentRef
    // @XmlInlineBinaryData
    // @XmlElementDecl
    @XmlElementDecl (
        scope = GLOBAL.class, 
        namespace = "##default", 
        substitutionHeadNamespace = "##default", 
        substitutionHeadName = ""
    )
    // @XmlJavaTypeAdapter
    @XmlJavaTypeAdapter ( type = DEFAULT.class )
    // @XmlJavaTypeAdapters
    ```