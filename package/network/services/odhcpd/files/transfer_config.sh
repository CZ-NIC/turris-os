#!/bin/sh -x 

clean_up () {
    uci revert dhcp
    exit
}

trap clean_up SIGHUP SIGINT SIGTERM

uci set dhcp.odhcpd=odhcpd
uci set dhcp.odhcpd.maindhcp=0
uci set dhcp.odhcpd.leasefile=/tmp/hosts/odhcpd
uci set dhcp.odhcpd.leasetrigger=/usr/sbin/odhcpd-update

master_intf=`uci get 6relayd.@server[0].master`
[ -n "$master_intf" ] && uci set dhcp.$master_intf.master=1

rd=`uci get 6relayd.@server[0].rd`
dhcpv6=`uci get 6relayd.@server[0].dhcpv6`
ndp=`uci get 6relayd.@server[0].ndp`
management_offlink=`uci get 6relayd.@server[0].management_offlink`
management_level=`uci get 6relayd.@server[0].management_level`
management_preference=`uci get 6relayd.@server[0].management_preference`

networks=`uci get 6relayd.@server[0].network`

if [ -n "$networks" ]; then
        for network in $networks; do
            uci get -q dhcp.$network || {
                uci set dhcp.${network}=dhcp
                uci set dhcp.$network.interface=$network
                uci set dhcp.$network.ignore=1
            }
            [ -n "$rd" ] && uci set dhcp.$network.ra=$rd
            [ -n "$dhcpv6" ] && uci set dhcp.$network.dhcpv6=$dhcpv6
            [ -n "$ndp" ] && uci set dhcp.$network.ndp=$ndp
            [ -n "$management_level" ] && uci set dhcp.$network.ra_management=$management_level
            [ -n "$management_offlink" ] && uci set dhcp.$network.ra_offlink=$management_offlink
            [ -n "$management_preference" ] && uci set dhcp.$network.ra_preference=$management_preference
        done
fi

i=0
while uci get 6relayd.@lease[$i]; do
    id=`uci get 6relayd.@lease[$i].id`
    duid=`uci get 6relayd.@lease[$i].duid`
                
    uci add dhcp host
    uci set dhcp.@host[-1].name=$id
    uci set dhcp.@host[-1].hostid=$id
    uci set dhcp.@host[-1].duid=$duid

    i=$(($i + 1))
done 

uci commit
