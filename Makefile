#where we're going to install behat
INSTALL_DIR=quickstart

#best guess at operating system
UNAME := $(shell uname)

#sahi download URL
SAHI_DOWNLOAD=http://sourceforge.net/projects/sahi/files/sahi-v44/sahi_20130429.zip/download

#phantom download
ifeq ($(UNAME), Darwin)
PHANTOM_DOWNLOAD_FILENAME=phantomjs-1.9.1-macosx.zip
PHANTOM_EXTRACTION=unzip -d $(INSTALL_DIR) $(INSTALL_DIR)/$(PHANTOM_DOWNLOAD_FILENAME)
endif

ifeq ($(UNAME), Linux)
PHANTOM_DOWNLOAD_FILENAME=phantomjs-1.9.1-linux-x86_64.tar.bz2
PHANTOM_EXTRACTION=tar -C $(INSTALL_DIR) -xjf $(INSTALL_DIR)/$(PHANTOM_DOWNLOAD_FILENAME)
endif



all: $(INSTALL_DIR) $(INSTALL_DIR)/sahi/bin/sahi.sh $(INSTALL_DIR)/phantomjs/phantomjs $(INSTALL_DIR)/phantom-sahi-bridge/phantom-sahi-bridge.js $(INSTALL_DIR)/sahi/userdata/config/browser_types.xml $(INSTALL_DIR)/behat/composer.json $(INSTALL_DIR)/behat/features/test/test.feature $(INSTALL_DIR)/readme.txt

clean:
	rm -rf $(INSTALL_DIR)

$(INSTALL_DIR):
	mkdir $(INSTALL_DIR)

$(INSTALL_DIR)/sahi/bin/sahi.sh:
	wget -O $(INSTALL_DIR)/sahi.zip $(SAHI_DOWNLOAD)
	unzip -d $(INSTALL_DIR) $(INSTALL_DIR)/sahi.zip

$(INSTALL_DIR)/phantomjs/phantomjs:
	wget -O $(INSTALL_DIR)/$(PHANTOM_DOWNLOAD_FILENAME) https://phantomjs.googlecode.com/files/$(PHANTOM_DOWNLOAD_FILENAME)
	$(PHANTOM_EXTRACTION)

$(INSTALL_DIR)/phantom-sahi-bridge/phantom-sahi-bridge.js:
	mkdir $(INSTALL_DIR)/phantom-sahi-bridge
	cp phantom-sahi-bridge/phantom-sahi-bridge.js $(INSTALL_DIR)/phantom-sahi-bridge/phantom-sahi-bridge.js

$(INSTALL_DIR)/sahi/userdata/config/browser_types.xml:
	cp sahi-config/browser_types-$(UNAME).xml $(INSTALL_DIR)/sahi/userdata/config/browser_types.xml

$(INSTALL_DIR)/behat/composer.json:
	mkdir $(INSTALL_DIR)/behat
	cp behat-config/composer.json $(INSTALL_DIR)/behat

$(INSTALL_DIR)/behat/bin/behat:
	cd $(INSTALL_DIR)/behat; curl http://getcomposer.org/installer | php; php composer.phar install

$(INSTALL_DIR)/behat/behat.yml: $(INSTALL_DIR)/behat/bin/behat
	cp behat-config/behat.yml $(INSTALL_DIR)/behat

$(INSTALL_DIR)/behat/features/test/test.feature: $(INSTALL_DIR)/behat/behat.yml
	mkdir -p $(INSTALL_DIR)/behat/features/test
	cp test-feature/test.feature $(INSTALL_DIR)/behat/features/test

$(INSTALL_DIR)/readme.txt: $(INSTALL_DIR)/behat/features/test
	cp instructions/readme.txt $(INSTALL_DIR)
	clear
	echo "behat_phantom_quickstart installed into the $(INSTALL_DIR) directory"
	cat $(INSTALL_DIR)/readme.txt
