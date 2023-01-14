#1-INTERFACE PHYSICAL
config system virtual-switch
    edit "lan"
        set physical-switch "sw0"
        config port
            delete "port1"
            delete "port12"
        end
    next
end

config system interface
    edit "wan1"
        set vdom "root"
        set mode static
        set ip 10.203.64.4/24
        set allowaccess ping https ssh snmp
        set type physical
        set role wan
    next
    edit "Loopback0"
        set vdom "root"
        set ip 10.203.88.1/32
        set allowaccess ping https ssh snmp
        set type loopback 
    next
    edit "dmz"
        set status down
    next
    edit "wan2"
        set status down
    next
    edit "ha1"
        set status down
    next
    edit "ha2"
        set status down
    next
    edit "port1"
        set vdom "root"
        set ip 0.0.0.0/0
        set type physical
        set alias "TRK-FIELD-PENDOPO"
    next
    edit "port12"
        set vdom "root"
        set ip 1.5.73.253/30
        set allowaccess ping https
        set type physical
        set alias "PRTG-SERVER-LA"
        set lldp-transmission enable
        set role lan
    next
    edit "lan"
        set status down
    next
end

#2-INTERFACE VLAN 
config system interface
    edit "VLAN99-MGMT"
        set vdom "root"
        set ip 1.5.72.50/24
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 99
    next
    edit "VLAN59-MGMT"
        set vdom "root"
        set ip 1.11.14.197/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 59
    next
    edit "VLAN60-MGMT"
        set vdom "root"
        set ip 1.11.14.201/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 60
    next
    edit "VLAN61-MGMT"
        set vdom "root"
        set ip 1.11.14.205/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 61
    next
    edit "VLAN62-MGMT"
        set vdom "root"
        set ip 1.11.14.209/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 62
    next
    edit "VLAN63-MGMT"
        set vdom "root"
        set ip 1.11.14.213/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 63
    next
    edit "VLAN64-MGMT"
        set vdom "root"
        set ip 1.11.14.217/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 64
    next
    edit "VLAN65-MGMT"
        set vdom "root"
        set ip 1.11.14.221/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 65
    next
    edit "VLAN66-MGMT"
        set vdom "root"
        set ip 1.11.14.225/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 66
    next
    edit "VLAN67-MGMT"
        set vdom "root"
        set ip 1.11.14.229/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 67
    next
    edit "VLAN68-MGMT"
        set vdom "root"
        set ip 1.11.14.233/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 68
    next
    edit "VLAN69-MGMT"
        set vdom "root"
        set ip 1.11.14.237/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 69
    next
    edit "VLAN70-MGMT"
        set vdom "root"
        set ip 1.11.14.241/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 70
    next
    edit "VLAN71-MGMT"
        set vdom "root"
        set ip 1.11.14.245/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 71
    next
    edit "VLAN72-MGMT"
        set vdom "root"
        set ip 1.11.14.249/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 72
    next
    edit "VLAN73-MGMT"
        set vdom "root"
        set ip 1.11.14.253/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 73
    next
    edit "VLAN74-MGMT"
        set vdom "root"
        set ip 1.11.13.197/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 74
    next
    edit "VLAN75-MGMT"
        set vdom "root"
        set ip 1.11.13.201/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 75
    next
    edit "VLAN76-MGMT"
        set vdom "root"
        set ip 1.11.13.205/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 76
    next
end

config router static
    edit 1
        set gateway 10.203.64.1
        set distance 1
        set device "wan1"
    next
end

#3-DNS
config system dns
    set primary 10.203.64.55
    set secondary 10.12.3.222
    set domain "PERTAMINA-EP.NET"
end

#4-ROUTING POLICY
config router policy
    edit 1
        set input-device "VLAN59-MGMT" "VLAN60-MGMT" "VLAN61-MGMT" "VLAN62-MGMT" "VLAN63-MGMT" "VLAN64-MGMT" "VLAN65-MGMT" "VLAN66-MGMT" "VLAN67-MGMT" "VLAN68-MGMT" "VLAN69-MGMT" "VLAN70-MGMT" "VLAN71-MGMT" "VLAN72-MGMT" "VLAN73-MGMT" "VLAN74-MGMT" "VLAN75-MGMT" "VLAN76-MGMT"
        set src "10.203.88.0/21"
        set dst "10.0.0.0/8"
        set output-device "wan1"
    next
    edit 2
        set input-device "VLAN59-MGMT" "VLAN60-MGMT" "VLAN61-MGMT" "VLAN62-MGMT" "VLAN63-MGMT" "VLAN64-MGMT" "VLAN65-MGMT" "VLAN66-MGMT" "VLAN67-MGMT" "VLAN68-MGMT" "VLAN69-MGMT" "VLAN70-MGMT" "VLAN71-MGMT" "VLAN72-MGMT" "VLAN73-MGMT" "VLAN74-MGMT" "VLAN75-MGMT" "VLAN76-MGMT"
        set src "10.203.88.0/21"
        set dst "172.16.0.0/12"
        set output-device "wan1"
    next
    edit 3
        set input-device "VLAN59-MGMT" "VLAN60-MGMT" "VLAN61-MGMT" "VLAN62-MGMT" "VLAN63-MGMT" "VLAN64-MGMT" "VLAN65-MGMT" "VLAN66-MGMT" "VLAN67-MGMT" "VLAN68-MGMT" "VLAN69-MGMT" "VLAN70-MGMT" "VLAN71-MGMT" "VLAN72-MGMT" "VLAN73-MGMT" "VLAN74-MGMT" "VLAN75-MGMT" "VLAN76-MGMT"
        set src "10.203.88.0/21"
        set dst "192.168.51.0/24"
        set output-device "wan1"
    next
end

#5-ROUTING BGP
config router bgp
    set as 65000
    set router-id 10.203.64.4
    set graceful-restart enable
    config neighbor-group
        edit "sites-field-pendopo1"
            set soft-reconfiguration enable
            set remote-as 65000
        next
        edit "sites-field-pendopo2"
            set soft-reconfiguration enable
            set remote-as 65000
        next
    end
    config neighbor-range
        edit 1
            set prefix 1.11.14.192/26
            set neighbor-group "sites-field-pendopo1"
        next
        edit 2
            set prefix 1.11.13.192/28
            set neighbor-group "sites-field-pendopo2"
        next
    end
    config network
        edit 1
            set prefix 10.203.64.0/24
        next
        edit 2
            set prefix 1.5.72.0/24
        next
        edit 3
            set prefix 1.5.73.0/24
        next
        edit 4
            set prefix 1.11.14.192/26
        next
        edit 5
            set prefix 1.11.13.192/28
        next
        edit 6
            set prefix 10.203.88.1/32
        next
    end
end

#6-ADDRESS LIST
config firewall address
    edit "network-p2p-site-1"
        set subnet 1.11.14.192/26
    next
    edit "network-p2p-site-2"
        set subnet 1.11.13.192/28
    next
    edit "network-lan-field"
        set subnet 10.203.88.0/21
    next
    edit "network-wan-p2p-ict"
        set subnet 10.203.64.0/24
    next
    edit "prtg-server"
        set subnet 1.5.73.0/24
    next
    edit "vlan99-mgmt"
        set subnet 1.5.72.0/24
    next
end

config firewall addrgrp
    edit "all-network-field"
        set member "network-p2p-site-1" "network-p2p-site-2" "network-lan-field" "network-wan-p2p-ict" "prtg-server" "vlan99-mgmt"
    next
end

#7-FIREWALL POLICY
config firewall policy
    edit 1
        set name "OUT-TO-WAN-PERTAMINA"
        set srcintf "any"
        set dstintf "wan1"
        set action accept
        set srcaddr "all"
        set dstaddr "all"
        set schedule "always"
        set service "ALL"
        set nat disable
    next
    edit 2
        set name "IN-FROM-WAN-PERTAMINA"
        set srcintf "wan1"
        set dstintf "any"
        set action accept
        set srcaddr "all"
        set dstaddr "all"
        set schedule "always"
        set service "ALL"
        set nat disable
    next
    edit 3
        set name "INTRANET BETWEEN SITE"
        set srcintf "any"
        set dstintf "any"
        set action accept
        set srcaddr "all-network-field"
        set dstaddr "all-network-field"
        set schedule "always"
        set service "ALL"
        set nat disable
    next
    edit 4
        set name "IN MGMT SUNDRAY"
        set srcintf "any"
        set dstintf "VLAN99-MGMT"
        set action accept
        set srcaddr "all"
        set dstaddr "vlan99-mgmt"
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set nat disable
    next
    edit 5
        set name "OUT MGMT SUNDRAY"
        set srcintf "VLAN99-MGMT"
        set dstintf "any"
        set action accept
        set srcaddr "vlan99-mgmt"
        set dstaddr "all"
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set nat disable
    next
end
