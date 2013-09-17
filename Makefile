#where we're going to install behat
INSTALL_DIR=quickstart

#best guess at operating system
UNAME := $(shell uname)

#sahi download URL
SAHI_DOWNLOAD=http://sourceforge.net/projects/sahi/files/sahi-v44/sahi_20130429.zip/download

#selenium filename
SELENIUM_FILENAME=selenium-server-standalone-2.34.0.jar

#phantom download
ifeq ($(UNAME), Darwin)
PHANTOM_DOWNLOAD_FILENAME=phantomjs-1.9.1-macosx.zip
PHANTOM_EXTRACTION=unzip -d $(INSTALL_DIR) $(INSTALL_DIR)/$(PHANTOM_DOWNLOAD_FILENAME)
endif

ifeq ($(UNAME), Linux)
PHANTOM_DOWNLOAD_FILENAME=phantomjs-1.9.1-linux-x86_64.tar.bz2
PHANTOM_EXTRACTION=tar -C $(INSTALL_DIR) -xjf $(INSTALL_DIR)/$(PHANTOM_DOWNLOAD_FILENAME)
endif

all: $(INSTALL_DIR) sahi phantomjs selenium behat instructions

clean:
	rm -rf $(INSTALL_DIR)

$(INSTALL_DIR):
	mkdir $(INSTALL_DIR)

#install sahi 
sahi: $(INSTALL_DIR)/sahi/bin/sahi.sh
	cp sahi-config/browser_types-$(UNAME).xml $(INSTALL_DIR)/sahi/userdata/config/browser_types.xml

$(INSTALL_DIR)/sahi/bin/sahi.sh:
	wget -O $(INSTALL_DIR)/sahi.zip $(SAHI_DOWNLOAD)
	unzip -d $(INSTALL_DIR) $(INSTALL_DIR)/sahi.zip

#install phantomjs and sahi bridge
phantomjs: $(INSTALL_DIR)/phantomjs/phantomjs
	mkdir $(INSTALL_DIR)/phantom-sahi-bridge
	cp phantom-sahi-bridge/phantom-sahi-bridge.js $(INSTALL_DIR)/phantom-sahi-bridge/phantom-sahi-bridge.js

$(INSTALL_DIR)/phantomjs/phantomjs: 
	wget -O $(INSTALL_DIR)/$(PHANTOM_DOWNLOAD_FILENAME) https://phantomjs.googlecode.com/files/$(PHANTOM_DOWNLOAD_FILENAME)
	$(PHANTOM_EXTRACTION)

#install selenium
selenium:
	mkdir -p $(INSTALL_DIR)/selenium
	wget -O $(INSTALL_DIR)/selenium/$(SELENIUM_FILENAME) http://selenium.googlecode.com/files/$(SELENIUM_FILENAME)

#install sauce connect
sauce_connect: $(INSTALL_DIR)/sauce_connect/Sauce-Connect.jar

$(INSTALL_DIR)/sauce_connect/Sauce-Connect.jar:
	mkdir -p $(INSTALL_DIR)/sauce_connect
	wget -O $(INSTALL_DIR)/sauce_connect/sauce_connect.zip http://saucelabs.com/downloads/Sauce-Connect-latest.zip
	unzip -d $(INSTALL_DIR)/sauce_connect $(INSTALL_DIR)/sauce_connect/sauce_connect.zip

#install behat
behat: $(INSTALL_DIR)/behat/bin/behat
	cp behat-config/behat.yml $(INSTALL_DIR)/behat
	mkdir -p $(INSTALL_DIR)/behat/features/test
	cp test-feature/test.feature $(INSTALL_DIR)/behat/features/test

$(INSTALL_DIR)/behat/composer.json:
	mkdir $(INSTALL_DIR)/behat
	cp behat-config/composer.json $(INSTALL_DIR)/behat

$(INSTALL_DIR)/behat/bin/behat: $(INSTALL_DIR)/behat/composer.json
	cd $(INSTALL_DIR)/behat; curl http://getcomposer.org/installer | php; php composer.phar install

#install and show instructions
instructions: $(INSTALL_DIR)
	cp README.md $(INSTALL_DIR)
	clear
	echo "behat_phantom_quickstart installed into the $(INSTALL_DIR) directory"
	cat $(INSTALL_DIR)/README.md
