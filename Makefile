# Makefile
# LuoXiaoqiu <qilvilu@gmail.com>

all: htcnetup

CC=gcc

INSTDIR = /usr/local/bin

htcnetup : htcnetup.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean :
	rm -rf htcnetup

install:htcnetup
	
	@if [ -d $(INSTDIR) ]; \
	then \
	echo “If your {idProduct} is not "0fb4", Please change it in 49-htcpnet.rules first.”; \
	echo “If your phone_usb_device is not "usb0", Please change it in htcnet.sh first.”; \
	cp htcnetup $(INSTDIR);\
	cp htcnet.sh $(INSTDIR);\
	cp 49-htcpnet.rules /etc/udev/rules.d;\
	chmod a+x $(INSTDIR)/htcnetup;\
	chmod a+x $(INSTDIR)/htcnet.sh;\
	echo “Installed in $(INSTDIR)“;\
	else \
	echo “Sorry, $(INSTDIR) does not exist”;\
	fi 

uninstall:
	@if [ -f $(INSTDIR)/htcnetup ]; \
	then \
	rm $(INSTDIR)/htcnetup;\
	echo “$(INSTDIR)/htcnetup is deleted.”;\
	else \
	echo “Sorry, $(INSTDIR)/htcnetup does not exist”;\
	fi
	@if [ -f $(INSTDIR)/htcnet.sh ]; \
	then \
	rm $(INSTDIR)/htcnet.sh;\
	echo “$(INSTDIR)/htcnet.sh is deleted.”;\
	else \
	echo “Sorry, $(INSTDIR)/htcnet.sh does not exist”;\
	fi
	@if [ -f /etc/udev/rules.d/49-htcpnet.rules ]; \
	then \
	rm /etc/udev/rules.d/49-htcpnet.rules;\
	echo “/etc/udev/rules.d/49-htcpnet.rules is deleted.”;\
	else \
	echo “Sorry, /etc/udev/rules.d/49-htcpnet.rules does not exist”;\
	fi

