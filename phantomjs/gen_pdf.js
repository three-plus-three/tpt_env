var webPage = require('webpage');
var page = webPage.create();

var system = require('system')
console.log(system.args)

page.viewportSize = { width: 1280, height: 1080 };
page.open(system.args[1] + ".html", function start(status) {
  page.paperSize = { format: 'A4', orientation: 'portrait', margin: '0.8cm' }
  page.settings.loadImages = true;
  //page.settings.userAgent = 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36';
  page.render(system.args[1].replace("file:///", "") + ".pdf", {format: 'pdf', quality: '100'});
  phantom.exit();
});