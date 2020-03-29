# JavaFx学习
- 主程序类继承javafx.application.Application
- 常用类继承结构
  - javafx.stage.Window
    - javafx.stage.Stage
  - javafx.scene.Node
    - javafx.scene.Parent
      - javafx.scene.web.WebView
      - javafx.scene.layout.Regon
        - javafx.scene.control.Controller
        - javafx.scene.layout.Pane
          - javafx.scene.layout.BorderPane
          - javafx.scene.layout.HBox
          - javafx.scene.layout.VBox
          - javafx.scene.layout.StackPane
          - javafx.scene.layout.GridPane
          - javafx.scene.layout.FlowPane
          - javafx.scene.layout.TilePane
          - javafx.scene.layout.AnchorPane
    - javafx.scene.Shape


class Bill {
 
    // Define a variable to store the property
    private DoubleProperty amountDue = new SimpleDoubleProperty();
 
    // Define a getter for the property's value
    public final double getAmountDue(){return amountDue.get();}
 
    // Define a setter for the property's value
    public final void setAmountDue(double value){amountDue.set(value);}
 
     // Define a getter for the property itself
    public DoubleProperty amountDueProperty() {return amountDue;}
 
}

        IntegerProperty num1 = new SimpleIntegerProperty(1);
        IntegerProperty num2 = new SimpleIntegerProperty(2);
        NumberBinding sum = num1.add(num2);
        System.out.println(sum.getValue());
        num1.set(2);
        System.out.println(sum.getValue());

        IntegerProperty num1 = new SimpleIntegerProperty(1);
       IntegerProperty num2 = new SimpleIntegerProperty(2);
       NumberBinding sum = Bindings.add(num1,num2);
       System.out.println(sum.getValue());
       num1.setValue(2);
       System.err.println(sum.getValue());


        IntegerProperty num1 = new SimpleIntegerProperty(1);
       IntegerProperty num2 = new SimpleIntegerProperty(2);
       IntegerProperty num3 = new SimpleIntegerProperty(3);
       IntegerProperty num4 = new SimpleIntegerProperty(4);
       NumberBinding total =
         Bindings.add(num1.multiply(num2),num3.multiply(num4));
       System.out.println(total.getValue());
       num1.setValue(2);
       System.err.println(total.getValue());

Interfaces

ObservableList: A list that enables listeners to track changes when they occur

ListChangeListener: An interface that receives notifications of changes to an ObservableList

ObservableMap: A map that enables observers to track changes when they occur

MapChangeListener: An interface that receives notifications of changes to an ObservableMap

Classes

FXCollections: A utility class that consists of static methods that are one-to-one copies of java.util.Collections methods

ListChangeListener.Change: Represents a change made to an ObservableList

MapChangeListener.Change: Represents a change made to an ObservableMap

The following section explains how to use these interfaces and classes