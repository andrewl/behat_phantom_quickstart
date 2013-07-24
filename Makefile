#where we're going to install behat
INSTALL_DIR=behat

#sahi download URL
SAHI_DOWNLOAD=http://sourceforge.net/projects/sahi/files/sahi-v44/sahi_20130429.zip/download

#phantom download
PHANTOM_DOWNLOAD=https://phantomjs.googlecode.com/files/phantomjs-1.9.1-macosx.zip

all: $(INSTALL_DIR) $(INSTALL_DIR)/sahi/bin/sahi.sh $(INSTALL_DIR)/phantomjs/phantomjs $(INSTALL_DIR)/phantom-sahi-bridge/phantom-sahi-bridge.js $(INSTALL_DIR)/sahi/userdata/config/browser_types.xml $(INSTALL_DIR)/behat/composer.json $(INSTALL_DIR)/behat/features/test/test.feature

clean:
	rm -rf $(INSTALL_DIR)

$(INSTALL_DIR):
	mkdir $(INSTALL_DIR)

$(INSTALL_DIR)/sahi/bin/sahi.sh:
	wget -O $(INSTALL_DIR)/sahi.zip $(SAHI_DOWNLOAD)
	unzip -d $(INSTALL_DIR) $(INSTALL_DIR)/sahi.zip

$(INSTALL_DIR)/phantomjs/phantomjs:
	wget -O $(INSTALL_DIR)/phantomjs.zip $(PHANTOM_DOWNLOAD)
	mkdir $(INSTALL_DIR)/phantomjs
	unzip -j -d $(INSTALL_DIR)/phantomjs $(INSTALL_DIR)/phantomjs.zip

$(INSTALL_DIR)/phantom-sahi-bridge/phantom-sahi-bridge.js:
	mkdir $(INSTALL_DIR)/phantom-sahi-bridge
	cp phantom-sahi-bridge/phantom-sahi-bridge.js $(INSTALL_DIR)/phantom-sahi-bridge

$(INSTALL_DIR)/sahi/userdata/config/browser_types.xml:
	cp sahi-config/browser_types.xml $(INSTALL_DIR)/sahi/userdata/config/browser_types.xml

$(INSTALL_DIR)/behat/composer.json:
	mkdir $(INSTALL_DIR)/behat
	cp behat-config/composer.json $(INSTALL_DIR)/behat

$(INSTALL_DIR)/behat/bin/behat:
	cd $(INSTALL_DIR)/behat; composer install

$(INSTALL_DIR)/behat/features: $(INSTALL_DIR)/behat/bin/behat
	cd $(INSTALL_DIR)/behat;  ./bin/behat --init

$(INSTALL_DIR)/behat/behat.yml: $(INSTALL_DIR)/behat/features
	cp behat-config/behat.yml $(INSTALL_DIR)/behat

$(INSTALL_DIR)/behat/features/test: $(INSTALL_DIR)/behat/behat.yml
	mkdir $(INSTALL_DIR)/behat/features/test

$(INSTALL_DIR)/behat/features/test/test.feature: $(INSTALL_DIR)/behat/features/test
	cp test-feature/test.feature $(INSTALL_DIR)/behat/features/test
