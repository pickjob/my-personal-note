function genericOnClick(info, tab) {
    console.log("item " + info.menuItemId + " was clicked");
    console.log("info: " + JSON.stringify(info));
    console.log("tab: " + JSON.stringify(tab));
}

chrome.contextMenus.create({
    "title": "ExtensionX",
    "contexts":["all"],
    "onclick": genericOnClick
});

chrome.webRequest.onBeforeRequest.addListener(
    function(details) {
        console.log(details)
        return {cancel: details.url.indexOf("http://ityouknow.com/jfinal/wx/") != -1};
    },
    {urls: ["<all_urls>"]},
    ["blocking"]
);