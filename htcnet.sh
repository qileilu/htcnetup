#!/bin/bash

#htcnet.sh
#LuoXiaoqiu <qilvilu@gmail.com>
#An activater for HTC android phone Internet pass-through.

#PC's internet interface
pc_internet_device="eth0"

#phone's connection  interface in pc
phone_usb_device="usb0"

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o $pc_internet_device -j MASQUERADE
sudo iptables -t nat -A PREROUTING -i $phone_usb_device -p udp -m udp --dport 53 -j DNAT --to-destination 8.8.8.8:53



get_ip ()
{
    arp -n | grep $phone_usb_device | awk '{print $1}'
}

#TODO: This needs a timeout and loop needs cleaning up, but works fine and borrowed from another post.
echo "waiting for IP on computer usb"
while [[ `get_ip` < 192 ]];do sleep 2; done
phoneip=`get_ip`
echo "IP adress is $phoneip "

#run activater process
htcnetup $phoneip