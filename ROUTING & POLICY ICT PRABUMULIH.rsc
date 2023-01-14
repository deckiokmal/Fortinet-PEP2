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
        set ip 10.203.4.2/30
        set allowaccess ping https ssh snmp
        set type physical
        set role wan
    next
    edit "Loopback0"
        set vdom "root"
        set ip 10.203.48.1/32
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
        set alias "TRK-FIELD-PRABUMULIH"
    next
    edit "port12"
        set vdom "root"
        set ip 1.5.73.249/30
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
        set ip 1.5.72.1/24
        set allowaccess ping
        set interface "port1"
        set vlanid 99
    next
    edit "VLAN10-MGMT"
        set vdom "root"
        set ip 1.11.14.1/30
        set allowaccess ping
        set interface "port1"
        set vlanid 10
    next
    edit "VLAN11-MGMT"
        set vdom "root"
        set ip 1.11.14.5/30
        set allowaccess ping
        set interface "port1"
        set vlanid 11
    next
    edit "VLAN12-MGMT"
        set vdom "root"
        set ip 1.11.14.9/30
        set allowaccess ping
        set interface "port1"
        set vlanid 12
    next
    edit "VLAN13-MGMT"
        set vdom "root"
        set ip 1.11.14.13/30
        set allowaccess ping
        set interface "port1"
        set vlanid 13
    next
    edit "VLAN14-MGMT"
        set vdom "root"
        set ip 1.11.14.17/30
        set allowaccess ping
        set interface "port1"
        set vlanid 14
    next
    edit "VLAN15-MGMT"
        set vdom "root"
        set ip 1.11.14.21/30
        set allowaccess ping
        set interface "port1"
        set vlanid 15
    next
    edit "VLAN16-MGMT"
        set vdom "root"
        set ip 1.11.14.25/30
        set allowaccess ping
        set interface "port1"
        set vlanid 16
    next
    edit "VLAN17-MGMT"
        set vdom "root"
        set ip 1.11.14.29/30
        set allowaccess ping
        set interface "port1"
        set vlanid 17
    next
    edit "VLAN18-MGMT"
        set vdom "root"
        set ip 1.11.14.33/30
        set allowaccess ping
        set interface "port1"
        set vlanid 18
    next
    edit "VLAN19-MGMT"
        set vdom "root"
        set ip 1.11.14.37/30
        set allowaccess ping
        set interface "port1"
        set vlanid 19
    next
    edit "VLAN20-MGMT"
        set vdom "root"
        set ip 1.11.14.41/30
        set allowaccess ping
        set interface "port1"
        set vlanid 20
    next
    edit "VLAN21-MGMT"
        set vdom "root"
        set ip 1.11.14.45/30
        set allowaccess ping
        set interface "port1"
        set vlanid 21
    next
    edit "VLAN22-MGMT"
        set vdom "root"
        set ip 1.11.14.49/30
        set allowaccess ping
        set interface "port1"
        set vlanid 22
    next
    edit "VLAN23-MGMT"
        set vdom "root"
        set ip 1.11.14.53/30
        set allowaccess ping
        set interface "port1"
        set vlanid 23
    next
    edit "VLAN24-MGMT"
        set vdom "root"
        set ip 1.11.14.57/30
        set allowaccess ping
        set interface "port1"
        set vlanid 24
    next
    edit "VLAN25-MGMT"
        set vdom "root"
        set ip 1.11.14.61/30
        set allowaccess ping
        set interface "port1"
        set vlanid 25
    next
    edit "VLAN26-MGMT"
        set vdom "root"
        set ip 1.11.14.65/30
        set allowaccess ping
        set interface "port1"
        set vlanid 26
    next
    edit "VLAN27-MGMT"
        set vdom "root"
        set ip 1.11.14.69/30
        set allowaccess ping
        set interface "port1"
        set vlanid 27
    next
    edit "VLAN28-MGMT"
        set vdom "root"
        set ip 1.11.14.73/30
        set allowaccess ping
        set interface "port1"
        set vlanid 28
    next
    edit "VLAN29-MGMT"
        set vdom "root"
        set ip 1.11.14.77/30
        set allowaccess ping
        set interface "port1"
        set vlanid 29
    next
    edit "VLAN30-MGMT"
        set vdom "root"
        set ip 1.11.14.81/30
        set allowaccess ping
        set interface "port1"
        set vlanid 30
    next
    edit "VLAN31-MGMT"
        set vdom "root"
        set ip 1.11.14.85/30
        set allowaccess ping
        set interface "port1"
        set vlanid 31
    next
    edit "VLAN32-MGMT"
        set vdom "root"
        set ip 1.11.14.89/30
        set allowaccess ping
        set interface "port1"
        set vlanid 32
    next
    edit "VLAN33-MGMT"
        set vdom "root"
        set ip 1.11.14.93/30
        set allowaccess ping
        set interface "port1"
        set vlanid 33
    next
    edit "VLAN34-MGMT"
        set vdom "root"
        set ip 1.11.14.97/30
        set allowaccess ping
        set interface "port1"
        set vlanid 34
    next
    edit "VLAN35-MGMT"
        set vdom "root"
        set ip 1.11.14.101/30
        set allowaccess ping
        set interface "port1"
        set vlanid 35
    next
    edit "VLAN36-MGMT"
        set vdom "root"
        set ip 1.11.14.105/30
        set allowaccess ping
        set interface "port1"
        set vlanid 36
    next
    edit "VLAN37-MGMT"
        set vdom "root"
        set ip 1.11.14.109/30
        set allowaccess ping
        set interface "port1"
        set vlanid 37
    next
    edit "VLAN38-MGMT"
        set vdom "root"
        set ip 1.11.14.113/30
        set allowaccess ping
        set interface "port1"
        set vlanid 38
    next
    edit "VLAN39-MGMT"
        set vdom "root"
        set ip 1.11.14.117/30
        set allowaccess ping
        set interface "port1"
        set vlanid 39
    next
    edit "VLAN40-MGMT"
        set vdom "root"
        set ip 1.11.14.121/30
        set allowaccess ping
        set interface "port1"
        set vlanid 40
    next
    edit "VLAN41-MGMT"
        set vdom "root"
        set ip 1.11.14.125/30
        set allowaccess ping
        set interface "port1"
        set vlanid 41
    next
    edit "VLAN42-MGMT"
        set vdom "root"
        set ip 1.11.14.129/30
        set allowaccess ping
        set interface "port1"
        set vlanid 42
    next
    edit "VLAN43-MGMT"
        set vdom "root"
        set ip 1.11.14.133/30
        set allowaccess ping
        set interface "port1"
        set vlanid 43
    next
    edit "VLAN44-MGMT"
        set vdom "root"
        set ip 10.203.48.137/30
        set allowaccess ping
        set interface "port1"
        set vlanid 44
    next
    edit "VLAN45-MGMT"
        set vdom "root"
        set ip 1.11.14.141/30
        set allowaccess ping
        set interface "port1"
        set vlanid 45
    next
    edit "VLAN46-MGMT"
        set vdom "root"
        set ip 1.11.14.145/30
        set allowaccess ping
        set interface "port1"
        set vlanid 46
    next
    edit "VLAN47-MGMT"
        set vdom "root"
        set ip 1.11.14.149/30
        set allowaccess ping
        set interface "port1"
        set vlanid 47
    next
    edit "VLAN48-MGMT"
        set vdom "root"
        set ip 1.11.14.153/30
        set allowaccess ping
        set interface "port1"
        set vlanid 48
    next
    edit "VLAN49-MGMT"
        set vdom "root"
        set ip 1.11.14.157/30
        set allowaccess ping
        set interface "port1"
        set vlanid 49
    next
    edit "VLAN50-MGMT"
        set vdom "root"
        set ip 1.11.14.161/30
        set allowaccess ping
        set interface "port1"
        set vlanid 50
    next
    edit "VLAN51-MGMT"
        set vdom "root"
        set ip 1.11.14.165/30
        set allowaccess ping
        set interface "port1"
        set vlanid 51
    next
    edit "VLAN52-MGMT"
        set vdom "root"
        set ip 1.11.14.169/30
        set allowaccess ping
        set interface "port1"
        set vlanid 52
    next
    edit "VLAN53-MGMT"
        set vdom "root"
        set ip 1.11.14.173/30
        set allowaccess ping
        set interface "port1"
        set vlanid 53
    next
    edit "VLAN54-MGMT"
        set vdom "root"
        set ip 1.11.14.178/30
        set allowaccess ping
        set interface "port1"
        set vlanid 54
    next
    edit "VLAN55-MGMT"
        set vdom "root"
        set ip 1.11.14.181/30
        set allowaccess ping
        set interface "port1"
        set vlanid 55
    next
    edit "VLAN56-MGMT"
        set vdom "root"
        set ip 1.11.14.185/30
        set allowaccess ping
        set interface "port1"
        set vlanid 56
    next
    edit "VLAN57-MGMT"
        set vdom "root"
        set ip 1.11.14.189/30
        set allowaccess ping
        set interface "port1"
        set vlanid 57
    next
end

config router static
    edit 1
        set gateway 10.203.4.1
        set distance 1
        set device "wan1"
    next
end

#3-DNS
config system dns
    set primary 10.203.1.201
    set secondary 10.12.3.222
    set domain "PERTAMINA-EP.NET"
end

#4-ROUTING POLICY
config router policy
    edit 1
        set input-device "VLAN10-MGMT" "VLAN11-MGMT" "VLAN12-MGMT" "VLAN13-MGMT" "VLAN14-MGMT" "VLAN15-MGMT" "VLAN16-MGMT" "VLAN17-MGMT" "VLAN18-MGMT" "VLAN19-MGMT" "VLAN20-MGMT" "VLAN21-MGMT" "VLAN22-MGMT" "VLAN23-MGMT" "VLAN24-MGMT" "VLAN25-MGMT" "VLAN26-MGMT" "VLAN27-MGMT" "VLAN28-MGMT" "VLAN29-MGMT" "VLAN30-MGMT" "VLAN31-MGMT" "VLAN32-MGMT" "VLAN33-MGMT" "VLAN34-MGMT" "VLAN35-MGMT" "VLAN36-MGMT" "VLAN37-MGMT" "VLAN38-MGMT" "VLAN39-MGMT" "VLAN40-MGMT" "VLAN41-MGMT" "VLAN42-MGMT" "VLAN43-MGMT" "VLAN44-MGMT" "VLAN45-MGMT" "VLAN46-MGMT" "VLAN47-MGMT" "VLAN48-MGMT" "VLAN49-MGMT" "VLAN50-MGMT" "VLAN51-MGMT" "VLAN52-MGMT" "VLAN53-MGMT" "VLAN54-MGMT" "VLAN55-MGMT" "VLAN56-MGMT" "VLAN57-MGMT"
        set src "10.203.48.0/20"
        set dst "10.0.0.0/8"
        set output-device "wan1"
    next
    edit 2
        set input-device "VLAN10-MGMT" "VLAN11-MGMT" "VLAN12-MGMT" "VLAN13-MGMT" "VLAN14-MGMT" "VLAN15-MGMT" "VLAN16-MGMT" "VLAN17-MGMT" "VLAN18-MGMT" "VLAN19-MGMT" "VLAN20-MGMT" "VLAN21-MGMT" "VLAN22-MGMT" "VLAN23-MGMT" "VLAN24-MGMT" "VLAN25-MGMT" "VLAN26-MGMT" "VLAN27-MGMT" "VLAN28-MGMT" "VLAN29-MGMT" "VLAN30-MGMT" "VLAN31-MGMT" "VLAN32-MGMT" "VLAN33-MGMT" "VLAN34-MGMT" "VLAN35-MGMT" "VLAN36-MGMT" "VLAN37-MGMT" "VLAN38-MGMT" "VLAN39-MGMT" "VLAN40-MGMT" "VLAN41-MGMT" "VLAN42-MGMT" "VLAN43-MGMT" "VLAN44-MGMT" "VLAN45-MGMT" "VLAN46-MGMT" "VLAN47-MGMT" "VLAN48-MGMT" "VLAN49-MGMT" "VLAN50-MGMT" "VLAN51-MGMT" "VLAN52-MGMT" "VLAN53-MGMT" "VLAN54-MGMT" "VLAN55-MGMT" "VLAN56-MGMT" "VLAN57-MGMT"
        set src "10.203.48.0/20"
        set dst "172.16.0.0/12"
        set output-device "wan1"
    next
    edit 3
        set input-device "VLAN10-MGMT" "VLAN11-MGMT" "VLAN12-MGMT" "VLAN13-MGMT" "VLAN14-MGMT" "VLAN15-MGMT" "VLAN16-MGMT" "VLAN17-MGMT" "VLAN18-MGMT" "VLAN19-MGMT" "VLAN20-MGMT" "VLAN21-MGMT" "VLAN22-MGMT" "VLAN23-MGMT" "VLAN24-MGMT" "VLAN25-MGMT" "VLAN26-MGMT" "VLAN27-MGMT" "VLAN28-MGMT" "VLAN29-MGMT" "VLAN30-MGMT" "VLAN31-MGMT" "VLAN32-MGMT" "VLAN33-MGMT" "VLAN34-MGMT" "VLAN35-MGMT" "VLAN36-MGMT" "VLAN37-MGMT" "VLAN38-MGMT" "VLAN39-MGMT" "VLAN40-MGMT" "VLAN41-MGMT" "VLAN42-MGMT" "VLAN43-MGMT" "VLAN44-MGMT" "VLAN45-MGMT" "VLAN46-MGMT" "VLAN47-MGMT" "VLAN48-MGMT" "VLAN49-MGMT" "VLAN50-MGMT" "VLAN51-MGMT" "VLAN52-MGMT" "VLAN53-MGMT" "VLAN54-MGMT" "VLAN55-MGMT" "VLAN56-MGMT" "VLAN57-MGMT"
        set src "10.203.48.0/20"
        set dst "192.168.51.0/24"
        set output-device "wan1"
    next
end

#5-ROUTING BGP
config router bgp
    set as 65000
    set router-id 10.203.4.2
    #set ebgp-multipath enable
    set graceful-restart enable
    config neighbor-group
        edit "sites-field-prabumulih"
            set soft-reconfiguration enable
            set remote-as 65000
        next
    end
    config neighbor-range
        edit 1
            set prefix 1.11.14.0/24
            set neighbor-group "sites-field-prabumulih"
        next
    end
    config network
        edit 1
            set prefix 10.203.4.0/30
        next
        edit 2
            set prefix 1.5.72.0/24
        next
        edit 3
            set prefix 1.5.73.248/30
        next
        edit 4
            set prefix 1.11.14.0/24
        next
        edit 5
            set prefix 10.203.48.1/32
    end
end

#6-ADDRESS LIST
config firewall address
    edit "network-p2p-site"
        set subnet 1.11.14.0/24
    next
    edit "network-lan-field"
        set subnet 10.203.48.0/20
    next
    edit "network-wan-p2p-ict"
        set subnet 10.203.4.0/30
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
