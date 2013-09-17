behat_phantom_quickstart
========================

A quickstart setup for installing and configuring Behat, Sahi, Selenium2 and Phantomjs.


Why?
----

Setting up the tools to run BDD tests through Behat can be a faff, and off-putting to some users. It's 
also time consuming. This project sets up and configures and number of tools so that you can get
BDDing in next-to-no-time at all.


What's in the box?
------------------

This project installs and configures the following components

- Behat: a BDD testing framework, including Mink, a couple of example profiles and a sample test (http://www.behat.org)
- Selenium2: a Java application which can control browsers (http://www.selenium.org)
- PhantomJS: a 'headerless' browser based on WebKit, functionally equivalent to Chrome (http://phantomjs.org)
- Sahi Open-source: a Java application, similar to Selenium which can control PhantomJS (http://www.sahi.in)


Requirements
--------------------------------------------------------

It's been tested on various flavours of Linux and OS/X. You'll need GNU Make, or similar and wget installed. Linux
users will most likely already have these installed, OS/X can install them through Homebrew or MacPorts. You'll also need a recent (5.3 or later) flavour of PHP installed.


How do I get started?
---------------------

Change into the current directory type 'make' and hit return, eg

cd /Users/myname/behat_phantom_quickstart
make

The make program will then run, downloading the components and configuring them. After it's done you'll be 
presented with this file.

Next, run the sample BDD story using Firefox and Selenium. 
----------------------------------------------------------

This quickstart ships with a simple BDD story which opens wikipedia, searches for BDD and checks that certain
text appears on the page. To test this in Firefox we first need to start Selenium, so open a new terminal
window, change into the quickstart/selenium subdirectory and run java -jar selenium-server-standalone-2.34.0.jar, eg:

cd /Users/myname/behat_phantom_quickstart/quickstart/selenium
java -jar selenium-server-standalone-2.34.0.jar

Keep this window open and open another terminal window. In this window we'll run behat using the firefox profile. To do
this change into the quickstart/behat subdirectory and run bin/behat -p firefox eg:

cd /Users/myname/behat_phantom_quickstart/quickstart/behat
bin/behat -p firefox

You'll see firefox start up and carry out the steps in the story. When the story has finished, Firefox will close and you'll 
see a list of steps that the story carried out and (hopefully) indication that they all passed!


Now, run the sample BDD story using PhantomJS and Sahi. 
-------------------------------------------------------

Running in a browser is great, but there are many times when running BDD stories in a headerless browser is more useful, eg
whilst running as part of a continuous integration suite. To run the same test in PhantomJSFirefox we first need to start Sahi,
so open a new terminal window, change into the quickstart/sahi/bin subdirectory and sh ./sahi.sh eg:

cd /Users/myname/behat_phantom_quickstart/sahi/bin
sh ./sahi.sh

Keep this window open and open another terminal window. In this window we'll run behat using the phantomjs profile. To do
this change into the quickstart/behat subdirectory and run bin/behat -p phantomjs eg:

cd /Users/myname/behat_phantom_quickstart/quickstart/behat
bin/behat -p phantomjs

This runs through the same steps in the story, but because it's in a headerless browser you won't actually 'see' the browser
doing anything. However, like we saw with firefox, when the story has finished, PhantomJS will close and you'll 
see a list of completed steps.


What's next?
------------

1. Move the components to a better location? All of the components have been installed into the quickstart subdirectory,
but because they're all independent of each other you can safely move the subdirectories to different locations.

2. Write some more stories. Stories (or scenarios) are stored in feature files which are located in the behat/features/test 
directory. They're written in Gherkin (http://behat.org), so go ahead and write some stories!
