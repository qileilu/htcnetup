# Makefile
# LuoXiaoqiu <qilvilu@gmail.com>

CC=gcc

htcnetup : htcnetup.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean :
	rm -rf htcnetup
