if ((url = phantom.args[0]) === undefined) {
  console.log('Usage: phantomjs <url>');
  phantom.exit();
}
else {
  console.log('Loading ' + url);
  page = new WebPage();
  page.open(url, function(status) {
    if (status === 'success') {
      title = page.evaluate(function() {
        return document.title;
      });
      console.log('SUCCESS: Loaded ' + url + ' ' + title);
    }
    else {
      console.log('FAIL: Failed to load ' + url);
    }
  });
}
