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
    redirect,
    {urls:["<all_urls>"], types:["xmlhttprequest"]},
    ["blocking"]
);


function redirect(requestDetails) {
    var preUrl = requestDetails.url;
    var reg = /^https?:\/\/([^/^:]+)(:\d+)?\/(.*)/;
    var result = preUrl.match(reg);
    var url = preUrl;
    if (result && result.length == 4) {
        console.log(result)
        if (result[1] == 'localhost' && result[2] == ':8883') {
            return {};
        }
        url = preUrl.replace(result[1], 'localhost:8883');
        url = url.replace(result[2], ''); 
    }
    console.log("Redirecting: " + preUrl + " ==> " + url);
    return {
        redirectUrl: url
    };
}