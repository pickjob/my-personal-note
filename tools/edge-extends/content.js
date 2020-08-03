// const cssSelectors = ['.lock', '#locker'];
// cssSelectors.forEach(selector => {
//     const lockerEles = document.querySelectorAll(selector);
//     lockerEles.forEach(ele => {
//         ele.removeAttribute("style");
//     })
// });
function retriveDomTree(rootEle) {
    const style = window.getComputedStyle(rootEle);
    const overflow = style.getPropertyValue('overflow');
    if (overflow && "hidden" == overflow) {
        // rootEle.removeAttribute("style");
        rootEle.setAttribute("style", "overflow:visible;");
    }
    const children = rootEle.children;
    for (let i = 0; i < children.length; i++) {
        retriveDomTree(children[i]);
    }
}
const bodys = document.getElementsByTagName('body');
retriveDomTree(bodys[0]);

const maskSelectors = ['.mask', '.info', '#unlockReadall'];
maskSelectors.forEach(selector => {
    var unlockEle = document.querySelector(selector)
    if (unlockEle) {
        unlockEle.parentElement.removeChild(unlockEle);
    }
});
