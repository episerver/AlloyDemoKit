var page = require('webpage').create(),
system = require('system'),
pageLink = system.args[1],
pageImage = system.args[2],
authCookie = system.args[4].split('|'),

sessionCookie = {
    'name': 'ASP.NET_SessionId',
    'value': system.args[3],
    'domain': system.args[5]
},

applicationCookie = {
    'name': authCookie[0],
    'value': authCookie[1],
    'domain': system.args[5]
};

//Force process to exit when encountering an error. Prevents process from freezing.
phantom.onError = function () {
    exit(1);
};

phantom.addCookie(sessionCookie);
phantom.addCookie(applicationCookie);

page.viewportSize = { width: 1024, height: 768 };

page.open(pageLink, function () { });

page.onLoadFinished = function () {
    var me = this;
    setTimeout(function () {
        page.zoomFactor = 0.75;
        page.render(pageImage);
        phantom.exit();
    }, 1000);
};
