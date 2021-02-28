console.log('well, it works');

browser.runtime.onConnect.addListener(port => {
    if (port.name !== "ExtensionX") return;

    port.onMessage.addListener(msg => {
        console.log("msg from ExtensionX")
        console.log(msg);
    });

    port.onDisconnect.addListener(() => {
        console.log('disconnect');
    });
});
