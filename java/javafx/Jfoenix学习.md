# Jfoenix学习
```css
// JFXRippler
.jfx-rippler {
    -jfx-rippler-fill: Color;
    -jfx-rippler-radius: Number;
    -jfx-mask-type: CIRCLE | RECT;
}
// JFXButton
.jfx-button {
    -jfx-button-type: FLAT(default) | RAISED;
}
// JFXCheckBox
.jfx-check-box {
    -jfx-checked-color: Color;
    -jfx-unchecked-color: Color;
}
// JFXComboBox
.jfx-combo-box {
    -jfx-focus-color: Color;
    -jfx-unfocus-color: Color;
    -jfx-label-float: Boolean;
}
// JFXHamburger
.jfx-hamburger {
}
// JFXTextField JFXPasswordField JFXTextArea
.jfx-text-field, .jfx-password-field, .jfx-text-area {
    -jfx-focus-color: Color;
    -jfx-unfocus-color: Color;
    -jfx-label-float: Boolean;
    -jfx-disable-animation: Boolean;
}
// JFXProgressBar
.jfx-process-bar
// JFXRadioButton
.jfx-radio-button {
    -jfx-selected-color: Color;
    -jfx-unselected-color: Color;
}
// JFXSlider
.jfx-slider {
    -jfx-indicator-position: LEFT | RIGHT;
}
// JFXSpinner
.jfx-spinner {
    -jfx-radius: Number;
    -jfx-starting-angle: Number;
}
// JFXTabPane
.jfx-tab-pane
// JFXToggleButton JFXToggleNode
.jfx-toggle-button, .jfx-toggle-node {
    -jfx-toggle-color: Color;
    -jfx-untoggle-color: Color;
    -jfx-toggle-line-color: Color;
    -jfx-untoggle-line-color: Color;
}
// JFXListView
.jfx-list-view {
    -jfx-cell-horizontal-margin: Number;
    -jfx-cell-vertical-margin: Number;
    -jfx-vertical-gap: Number;
    -jfx-expanded: Boolean;
}
// JFXDatePicker JFXColorPicker
.jfx-date-picker, .jfx-color-picker {
    -jfx-default-color: Color;
    -jfx-overlay: Boolean;
}
// JFXDialog
.jfx-dialog {
    -jfx-dialog-transition: CENTER | TOP | RIGHT | BOTTOM | LEFT;
}
// JFXPopup
.jfx-popup
// JFXDrawer
.jfx-drawer
// JFXDecorator
.jfx-decorator
// JFXBadge
// JFXSnackbar
// JFXChipView
// JFXTreeViewPath
// JFXAutoCompletePopup 
// JFXAlert JFXDialog
// JFXToolbar
// JFXTooltip
```
```java
// JFXHamburger transitions
//      HamburgerSlideCloseTransition
//      HamburgerBackArrowBasicTransition
//      HamburgerBasicCloseTransition
//      HamburgerNextArrowBasicTransition
JFXHamburger hamburger = new JFXHamburger();
HamburgerSlideCloseTransition burgerTask = new HamburgerSlideCloseTransition(hamburger);
burgerTask.setRate(-1);
hamburger.addEventHandler(MouseEvent.MOUSE_PRESSED, (e)->{
    burgerTask.setRate(burgerTask.getRate()*-1);
    burgerTask.play();
});
// JFXDrawer direction:
//          LEFT(1)
//          RIGHT(-1)
//          TOP(1)
//          BOTTOM(-1)
JFXDrawer topDrawer = new JFXDrawer();
StackPane topDrawerPane = new StackPane();
topDrawerPane.getChildren().add(new JFXButton("Top Content"));
topDrawer.setDirection(DrawerDirection.TOP);
topDrawer.setDefaultDrawerSize(150);
topDrawer.setSidePane(topDrawerPane);
topDrawer.setOverLayVisible(false);
topDrawer.setResizableOnDrag(true);
```