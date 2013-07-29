Congratulations, you've sucesfully installed Behat, Sahi and PhantomJS which enables you to do headerless behaviour-driven development testing. By default this has been installed in the quickstart subdirectory, but you can now move that directory to anywhere. To start the test carry out the following instructions:

1. In another terminal window run sahi by going to sahi/bin directory and running sahi.sh, eg
cd sahi/bin
sh ./sahi.sh

Keep that window open as it's running the Sahi proxy that will pass commands through to phantomjs, the headerless Chrome browser.

2. In this window run the test Behat feature by going to the behat directory and running ./bin/behat, eg
cd behat
./bin/behat

If all goes well Behat will run a simple test to look up 'BDD' in Google
