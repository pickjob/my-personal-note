// let tabPorMap = new Map();

// let basicMap = new Map();
// let requestHeaderMap = new Map();
// let requestBodyMap = new Map();
// let responseHeaderMap = new Map();
// let responseBodyMap = new Map();

// let filterObj = {
//     urls: ["<all_urls>"],
//     // urls: ["https://10.10.2.32/*"],
//     types: ["xmlhttprequest"]
// };

// function filterFunc(info) {
//     if (info.basic.url.includes('portal/monitor/data')) {
//         // console.log(info.requestBody.formData.mdid);
//         if (info.requestBody.formData.mdid.some(s => s.includes('Async'))) {
//             return true;
//         }
//     }
//     return false;
// }

// browser.tabs
//     .query({})
//     .then(tabs => {
//         for (let tab of tabs) {
//             let port = browser.tabs.connect(
//                 tab.id,
//                 { name: "ExtensionX" }
//             );
//             tabPorMap.set(tab.id, port);
//         }
//     }, err => console.log(`Error: ${err}`));

// browser.webRequest.onBeforeRequest.addListener(
//     details => {
//         let basic = {};
//         basic.url = details.url;
//         basic.method = details.method;
//         basicMap.set(details.requestId, basic);
//         if (details.requestBody) {
//             requestBodyMap.set(details.requestId, details.requestBody);
//         }
//         let filter = browser.webRequest.filterResponseData(details.requestId);
//         let decoder = new TextDecoder("utf-8");
//         let encoder = new TextEncoder();
//         filter.ondata = event => {
//             let str = decoder.decode(event.data, { stream: true });
//             filter.write(encoder.encode(str));
//             filter.disconnect();
//             let res = str;
//             try {
//                 res = JSON.parse(str);
//             } catch (err) {
//                 // noop
//             }
//             responseBodyMap.set(details.requestId, res);
//         };
//         return {};
//     },
//     filterObj,
//     ["blocking", "requestBody"]
// );

// browser.webRequest.onBeforeSendHeaders.addListener(
//     details => {
//         let headers = {};
//         for (let header of details.requestHeaders) {
//             headers[header.name] = header.value;
//         }
//         requestHeaderMap.set(details.requestId, headers);
//     },
//     filterObj,
//     ["blocking", "requestHeaders"]
// );

// browser.webRequest.onCompleted.addListener(
//     details => {
//         setTimeout(() => {
//             let headers = {};
//             for (let header of details.responseHeaders) {
//                 headers[header.name] = header.value;
//             }
//             responseHeaderMap.set(details.requestId, headers);
//             let infoObj = {};
//             infoObj.basic = basicMap.get(details.requestId);
//             basicMap.delete(details.requestId);
//             infoObj.requestHeader = requestHeaderMap.get(details.requestId);
//             requestHeaderMap.delete(details.requestId);
//             infoObj.requestBody = requestBodyMap.get(details.requestId);
//             requestBodyMap.delete(details.requestId);
//             infoObj.responseHeader = responseHeaderMap.get(details.requestId);
//             responseHeaderMap.delete(details.requestId);
//             infoObj.responseBody = responseBodyMap.get(details.requestId);
//             responseBodyMap.delete(details.requestId);
//             console.log(infoObj);
//             if (filterFunc(infoObj)) {
//                 let port = tabPorMap.get(details.tabId);
//                 if (port) {
//                     port.postMessage(infoObj);
//                 }
//             }
//         }, 5000);
//     },
//     filterObj,
//     ["responseHeaders"]
// );

// browser.webRequest.onErrorOccurred.addListener(
//     details => {
//         let basic = basicMap.get(details.requestId);
//         console.log(`Error occurred, url: ${basic.url}, method: ${basic.method}`);
//         basicMap.delete(details.requestId);
//         requestHeaderMap.delete(details.requestId);
//         requestBodyMap.delete(details.requestId);
//         responseHeaderMap.delete(details.requestId);
//         responseBodyMap.delete(details.requestId);
//     },
//     filterObj
// );

console.log('xxxx')
// proxy urls
// browser.webRequest.onBeforeRequest.addListener(
//     details => {
//         let url = "http://127.0.0.1:8080/portal/monitor/data"
//         console.log("Redirecting " + details.url)
//         return {
//             redirectUrl: url
//         };
//     },
//     {
//         urls: ["https://*/portal/monitor/data"],
//         types: ["xmlhttprequest"]
//     },
//     ["blocking"]
// );

// Listen for a request to open a webpage
browser.proxy.onRequest.addListener(
    requestDetail => {
        console.log('PROXY: ' + requestDetail.url);
        if (requestDetail.url.indexOf("portal/monitor/data") != -1) {
            return {
                type: "http",
                host: "localhost",
                port: 1080
            };
        }
        return { type: "direct" };
    },
    {
        urls: ["<all_urls>"],
        types: ["xmlhttprequest", "main_frame"]
    }
);
