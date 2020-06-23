# BootstrapFX学习
```java
// CSS class
// Text
//      b, strong
//      i, em, italic, dfn
//      small
//      code, kbd, pre, samp
//      h1, h2, h3, h4, h5, h6
//      lead
//      p
//      text-mute
//      text-primary, text-success, text-info, text-warning, text-danger
//      bg-primary, bg-success, bg-info, bg-warning, bg-danger
// Buttons
//      btn
//      btn-default, btn-primary, btn-success, btn-info, btn-warning, btn-danger
//      btn-lg, btn-sm, btn-xs
// SplitMenu Buttons
//      split-menu-btn
//      split-menu-btn-default, split-menu-btn-primary, split-menu-btn-success, split-menu-btn-info, split-menu-btn-warning, split-menu-btn-danger
//      split-menu-btn-lg, split-menu-btn-sm, split-menu-btn-xs
// Labels
//      lbl
//      lbl-default, lbl-primary, lbl-success, lbl-info, lbl-warning, lbl-danger
// Panels
//      panel
//      panel-default, panel-primary, panel-success, panel-info, panel-warning, panel-danger
//      panel-heading
//      panel-title
//      panel-body
//      panel-footer
// Alerts
//      alert
//      alert-success, alert-info, alert-warning, alert-danger
// Groups
//      btn-group-horizontal
//      btn-group-vertical
// Progress Bars
//      progress-bar-primary
//      progress-bar-success
//      progress-bar-info
//      progress-bar-warning
//      progress-bar-danger
// Tooltips
//      tooltip-primary
//      tooltip-success
//      tooltip-info
//      tooltip-warning
//      tooltip-danger
// Miscellaneous
//      badge
scene.getStylesheets().add("org/kordamp/bootstrapfx/bootstrapfx.css");
```
```xml
<!-- alert -->
<TextFlow styleClass="alert, alert-success">
    <Text text="Well done!" styleClass="strong"/>
    <Text text=" You successfully read this important alert message."/>
</TextFlow>
<!-- panel -->
<Panel styleClass="panel-default">
    <heading>
        <Label styleClass="h3" text="Panel title"/>
    </heading>
    <body>
        <Label text="Panel body"/>
    </body>
</Panel>
<!-- SplitMenuButton -->
<SplitMenuButton styleClass="split-menu-btn, split-menu-btn-lg, split-menu-btn-primary" text="Primary"/>
```