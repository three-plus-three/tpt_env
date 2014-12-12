var webPage = require('webpage');
var page = webPage.create();

var system = require('system')
console.log(system.args)


console.log(system.args[1] + ".html");
page.viewportSize = { width: 1280, height: 1080 };
page.open(system.args[1] + ".html", function start(status) {
  //page.paperSize = { format: 'A4', orientation: 'portrait', margin: '0.8cm' }
  //page.settings.loadImages = true;
  page.render(system.args[1].replace("file:///", "") + '.jpeg', {format: 'jpeg', quality: '100'});
  phantom.exit();
});