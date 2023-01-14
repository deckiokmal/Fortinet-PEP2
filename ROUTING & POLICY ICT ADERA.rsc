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
        set ip 10.203.96.4/24
        set allowaccess ping https ssh snmp
        set type physical
        set role wan
    next
    edit "Loopback0"
        set vdom "root"
        set ip 10.203.108.1/32
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
        set alias "TRK-FIELD-ADERA"
    next
    edit "port12"
        set vdom "root"
        set ip 1.5.73.245/30
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
        set ip 1.5.72.70/24
        set allowaccess ping
        set interface "port1"
        set vlanid 99
    next
    edit "VLAN78-MGMT"
        set vdom "root"
        set ip 1.11.13.237/30
        set allowaccess ping
        set interface "port1"
        set vlanid 78
    next
    edit "VLAN79-MGMT"
        set vdom "root"
        set ip 1.11.13.209/30
        set allowaccess ping
        set interface "port1"
        set vlanid 79
    next
    edit "VLAN80-MGMT"
        set vdom "root"
        set ip 1.11.13.213/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 80
    next
    edit "VLAN81-MGMT"
        set vdom "root"
        set ip 1.11.13.217/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 81
    next
    edit "VLAN82-MGMT"
        set vdom "root"
        set ip 1.11.13.221/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 82
    next
    edit "VLAN83-MGMT"
        set vdom "root"
        set ip 1.11.13.225/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 83
    next
    edit "VLAN84-MGMT"
        set vdom "root"
        set ip 1.11.13.229/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 84
    next
    edit "VLAN85-MGMT"
        set vdom "root"
        set ip 1.11.13.233/30
        set allowaccess ping
        ##set snmp-index 35
        set interface "port1"
        set vlanid 85
    next
end

config router static
    edit 1
        set gateway 10.203.96.1
        set distance 1
        set device "wan1"
    next
end

#3-DNS
config system dns
    set primary 10.203.96.3
    set secondary 10.12.3.222
    set domain "PERTAMINA-EP.NET"
end

#4-ROUTING POLICY
config router policy
    edit 1
        set input-device "VLAN78-MGMT" "VLAN79-MGMT" "VLAN80-MGMT" "VLAN81-MGMT" "VLAN82-MGMT" "VLAN83-MGMT" "VLAN84-MGMT" "VLAN85-MGMT"
        set src "10.203.108.0/22"
        set dst "10.0.0.0/8"
        set output-device "wan1"
    next
    edit 2
        set input-device "VLAN78-MGMT" "VLAN79-MGMT" "VLAN80-MGMT" "VLAN81-MGMT" "VLAN82-MGMT" "VLAN83-MGMT" "VLAN84-MGMT" "VLAN85-MGMT"
        set src "10.203.108.0/22"
        set dst "172.16.0.0/12"
        set output-device "wan1"
    next
    edit 3
        set input-device "VLAN78-MGMT" "VLAN79-MGMT" "VLAN80-MGMT" "VLAN81-MGMT" "VLAN82-MGMT" "VLAN83-MGMT" "VLAN84-MGMT" "VLAN85-MGMT"
        set src "10.203.108.0/22"
        set dst "192.168.51.0/24"
        set output-device "wan1"
    next
end

#5-ROUTING BGP
config router bgp
    set as 65000
    set router-id 10.203.96.4
    #set ebgp-multipath enable
    set graceful-restart enable
    config neighbor-group
        edit "sites-field-adera"
            set soft-reconfiguration enable
            set remote-as 65000
        next
    end
    config neighbor-range
        edit 1
            set prefix 1.11.13.192/26
            set neighbor-group "sites-field-adera"
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
            set prefix 1.11.13.192/26
        next
        edit 5
            set prefix 10.203.108.1/32
    end
end

#6-ADDRESS LIST
config firewall address
    edit "network-p2p-site"
        set subnet 1.11.13.192/26
    next
    edit "network-lan-field"
        set subnet 10.203.108.0/22
    next
    edit "network-wan-p2p-ict"
        set subnet 10.203.96.0/24
    next
    edit "prtg-server"
        set subnet 1.5.73.244 255.255.255.252
    next
    edit "vlan99-mgmt"
        set subnet 1.5.72.0 255.255.255.0
    next
end

config firewall addrgrp
    edit "all-network-field"
        set member "network-p2p-site" "network-lan-field" "network-wan-p2p-ict" "prtg-server" "vlan99-mgmt"
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
