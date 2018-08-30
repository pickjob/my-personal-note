# FXML学习
- FXMLLoader
    ```java
    URL location = getClass().getResource("example.fxml");
    ResourceBundle resources = ResourceBundle.getBundle("com.foo.example");
    FXMLLoader fxmlLoader = new FXMLLoader(location, resources);

    Pane root = (Pane)fxmlLoader.load();
    MyController controller = (MyController)fxmlLoader.getController();
    ```
- Instance Declarations
    ```xml
    <?import javafx.scene.control.Label?>
    <?import javafx.scene.control.*?>
    ```
- Resolution
    ```xml
    // Location
    <ImageView>
        <image>
            <Image url="@my_image.png"/>
        </image>
    </ImageView>
    // Resource
    <Label text="%myText"/>
    // Variable
    <RadioButton text="C" toggleGroup="$myToggleGroup"/>
    <TextField fx:id="textField"/>
    <Label text="${textField.text}"/>
    // FXML Controller
    <children>
        <Button text="Click Me!" onAction="#handleButtonAction"/>
    </children>
    <VBox fx:controller="com.foo.MyController"
        xmlns:fx="http://javafx.com/fxml">
        <children>
            <Button text="Click Me!" onAction="$controller.onActionHandler"/>
        </children>
    </VBox>
    ```
- xmlns:fx="http://javafx.com/fxml"
    ```xml
    <FXCollections fx:factory="observableArrayList">
        <String fx:value="A"/>
        <String fx:value="B"/>
        <String fx:value="C"/>
    </FXCollections>
    <Button>
        <minHeight><Double fx:constant="NEGATIVE_INFINITY"/></minHeight>
    </Button>
    <VBox>
        <fx:define>
            <ToggleGroup fx:id="myToggleGroup"/>
        </fx:define>
        <children>
            <RadioButton text="A" toggleGroup="$myToggleGroup"/>
            <RadioButton text="B" toggleGroup="$myToggleGroup"/>
            <RadioButton text="C" toggleGroup="$myToggleGroup"/>
        </children>
    </VBox>
    <fx:root type="javafx.scene.layout.VBox" xmlns:fx="http://javafx.com/fxml">
        <TextField fx:id="textField"/>
        <Button text="Click Me" onAction="#doSomething"/>
    </fx:root>
    ```
    - fx:id(id指定)
    - fx:value(无默认构造函数,调用静态方法value(String))
    - fx:factory(无默认构造函数,调用静态无参工厂方法)
    - fx:constant(引用一个类常量)
    - fx:controller(绑定一个Controller)
    - <fx:include>(引用其他的FXML)
    - <fx:reference>(创造已存在元素的新的引用)
    - <fx:define>(创建一些必须的申明)
    - <fx:root>(自定义组件)
- @FXML