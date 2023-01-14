#1-PHYSICAL INTERFACE
config system virtual-switch
    edit "lan"
        set physical-switch "sw0"
        config port
            delete "port2"
            delete "port4"
            delete "port6"
            delete "port8"
            delete "port10"
            delete "port12"
            delete "port14"
            delete "port16"
            delete "port18"
            delete "port20"
        end
    next
end

config system virtual-switch
    edit "lan"
        set physical-switch "sw0"
        config port
            edit "port1"
            next
            edit "port3"
            next
            edit "port5"
            next
            edit "port7"
            next
            edit "port9"
            next
            edit "port11"
            next
            edit "port13"
            next
            edit "port15"
            next
            edit "port17"
            next
            edit "port19"
            next
        end
    next
    edit "LAN-OTHER"
        set physical-switch "sw0"
        config port
            edit "port2"
            next
            edit "port4"
            next
            edit "port6"
            next
            edit "port8"
            next
            edit "port10"
            next
            edit "port12"
            next
            edit "port14"
            next
            edit "port16"
            next
            edit "port18"
            next
            edit "port20"
            next
        end
    next
end

config system interface
    edit "wan1"
        set vdom "root"
        set mode static
        set ip 1.11.14.38/30
        set allowaccess ping https ssh snmp
        set type physical
        set role wan
        #set snmp-index 3
    next
    edit "lan"
        set vdom "root"
        set ip 10.203.62.1/27
        set allowaccess ping https
        set type hard-switch
        set alias "LAN-DATA"
        set role lan
        #set snmp-index 11
    next
    edit "LAN-OTHER"
        set vdom "root"
        set ip 10.203.62.33/27
        set allowaccess ping https
        set type hard-switch
        set role lan
        #set snmp-index 35
    next
    edit "Loopback0"
        set vdom "root"
        set ip 10.203.48.9/32
        set allowaccess ping https ssh snmp
        set type loopback
    next
end

#2-DHCP LAN DATA
config system dhcp server
    edit 4
        set dns-service default
        set default-gateway 10.203.62.1
        set netmask 255.255.255.224
        set interface "lan"
        config ip-range
            edit 1
                set start-ip 10.203.62.2
                set end-ip 10.203.62.30
            next
        end
    next
end

config router static
    edit 1
        set gateway 1.11.14.37
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

#4-ROUTING BGP
config router bgp
    set as 65000
    set router-id 1.11.14.38
    config neighbor
        edit "1.11.14.37"
            set capability-graceful-restart enable
            set remote-as 65000
            set connect-timer 1
        next
    end
    config network
        edit 1
            set prefix 10.203.62.0/27	
        next
        edit 2
            set prefix 10.203.62.32/27
        next
        edit 2
            set prefix 10.203.48.9/32
        next
    end
end

#5-FIREWALL POLICY
config firewall policy
    edit 1
        set name "TRAFFIC-OUT"
        set srcintf "lan" "LAN-OTHER" "Loopback0"
        set dstintf "wan1"
        set action accept
        set srcaddr "all"
        set dstaddr "all"
        set schedule "always"
        set service "ALL"
        set nat disable
        set logtraffic all
        set nat disable
    next
    edit 2
        set name "TRAFFIC-IN"
        set srcintf "wan1"
        set dstintf "lan" "LAN-OTHER" "Loopback0"
        set action accept
        set srcaddr "all"
        set dstaddr "all"
        set schedule "always"
        set service "ALL"
        set nat disable
        set logtraffic all
        set nat disable
    next
end
