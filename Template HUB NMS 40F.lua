config system interface
    edit "wan"
        set vdom "root"
        set ip 36.89.123.187 255.255.255.248
        set allowaccess ping https ssh
        set type physical
        set alias "MAINLINK"
        set lldp-reception enable
        set role wan
        set snmp-index 1
    next
    edit "lan3"
        set vdom "root"
        set mode dhcp
        set allowaccess ping ssh
        set type physical
        set alias "TO-MGMT-ICT"
        set snmp-index 8
        set defaultgw disable
        set dns-server-override disable
    next
    edit "a"
        set vdom "root"
        set type physical
        set snmp-index 2
    next
    edit "modem"
        set vdom "root"
        set mode pppoe
        set type physical
        set snmp-index 3
    next
    edit "ssl.root"
        set vdom "root"
        set type tunnel
        set alias "SSL VPN interface"
        set snmp-index 4
    next
    edit "lan"
        set vdom "root"
        set ip 1.5.73.1 255.255.255.252
        set allowaccess ping https ssh fgfm
        set type hard-switch
        set alias "PTP-HUB-ICT"
        set stp enable
        set role lan
        set snmp-index 5
    next
    edit "fortilink"
        set vdom "root"
        set fortilink enable
        set ip 169.254.1.1 255.255.255.0
        set allowaccess ping fabric
        set type aggregate
        set member "a"
        set lldp-reception enable
        set lldp-transmission enable
        set snmp-index 6
    next
    edit "TUN-MAIN"
        set vdom "root"
        set ip 169.254.50.254 255.255.255.255
        set allowaccess ping telnet
        set type tunnel
        set remote-ip 169.254.50.253 255.255.255.0
        set snmp-index 7
        set interface "wan"
    next
    edit "Loopback0"
        set vdom "root"
        set ip 10.203.48.50 255.255.255.255
        set allowaccess ping https ssh snmp
        set type loopback
        set snmp-index 9
    next
end

config router static
    edit 1
        set gateway 36.89.123.185
        set device "wan"
    next
    edit 3
        set dst 10.0.0.0 255.0.0.0
        set distance 254
        set comment "CLASS-A-BLACKHOLE"
        set blackhole enable
    next
    edit 4
        set dst 172.16.0.0 255.240.0.0
        set distance 254
        set comment "CLASS-B-BLACKHOLE"
        set blackhole enable
    next
    edit 5
        set dst 192.168.0.0 255.255.0.0
        set distance 254
        set comment "BLACKHOLE-CLASS-C"
        set blackhole enable
    next
end

config vpn ipsec phase1-interface
    edit "TUN-MAIN"
        set type dynamic
        set interface "wan"
        set ike-version 2
        set local-gw 36.89.123.187
        set peertype any
        set net-device disable
        set proposal aes128-sha256
        set add-route disable
        set dpd on-idle
        set dhgrp 5
        set auto-discovery-sender enable
        set tunnel-search nexthop
        set psksecret ENC I91jiQJZIGW2EgPG3LmlRSTpXPSxPkOhFxCw/nxXS25n0t/B1E22WMgRS4ILb1jER23l69/+dvyAK5aQdJoW7QwEesav3uEjH5Fe6hAHOftkfi44Kbpix7ZNOzo35OCAspI249Kj71xGobCWRJ4vi2ZjR41EGDnsOQF5NnKOXEhFNz6MOjX7dLDvuUqBQiP9LZGLYA==
        set dpd-retryinterval 10
    next
end

config vpn ipsec phase2-interface
    edit "TUN-MAIN"
        set phase1name "TUN-MAIN"
        set proposal aes128-sha256
        set pfs disable
    next
end

config router policy
    edit 1
        set input-device "TUN-MAIN"
        set src "10.203.0.0/255.255.0.0"
        set dst "10.203.0.0/255.255.0.0"
        set output-device "lan"
    next
    edit 2
        set input-device "TUN-MAIN"
        set src "10.203.0.0/255.255.0.0"
        set dst "10.0.0.0/255.0.0.0"
        set output-device "lan"
    next
    edit 3
        set input-device "TUN-MAIN"
        set src "10.203.0.0/255.255.0.0"
        set dst "172.16.0.0/255.240.0.0"
        set output-device "lan"
    next
    edit 4
        set input-device "TUN-MAIN"
        set src "10.203.0.0/255.255.0.0"
        set dst "192.168.51.0/255.255.255.0"
        set output-device "lan"
    next
end

config router community-list
    edit "65432:123"
        config rule
            edit 1
                set action permit
                set match "65432:123"
            next
        end
    next
end

config router prefix-list
    edit "PREFIX-TO-SPOKE"
        config rule
            edit 1
                set prefix 10.203.0.0 255.255.0.0
                unset ge
                unset le
            next
            edit 2
                set prefix 10.0.0.0 255.0.0.0
                unset ge
                unset le
            next
            edit 3
                set prefix 192.168.51.0 255.255.255.0
                unset ge
                unset le
            next
        end
    next
    edit "PREFIX-TO-ICT"
        config rule
            edit 1
                set prefix 10.203.0.0 255.255.0.0
                unset ge
                unset le
            next
            edit 2
                set prefix 10.0.0.0 255.0.0.0
                unset ge
                unset le
            next
            edit 3
                set prefix 192.168.51.0 255.255.255.0
                unset ge
                unset le
            next
        end
    next
end

config router route-map
    edit "OUT-TO-ADVPN-SPOKE"
        config rule
            edit 1
                set match-ip-address "PREFIX-TO-SPOKE"
                set set-community "65432:123"
                unset set-ip-nexthop
                unset set-ip6-nexthop
                unset set-ip6-nexthop-local
                unset set-originator-id
            next
            edit 2
                set match-community "65432:123"
                unset set-ip-nexthop
                unset set-ip6-nexthop
                unset set-ip6-nexthop-local
                unset set-originator-id
            next
        end
    next
    edit "OUT-TO-FG-ICT-PRABUMULIH"
        config rule
            edit 1
                set action deny
                set match-ip-address "PREFIX-TO-ICT"
                unset set-ip-nexthop
                unset set-ip6-nexthop
                unset set-ip6-nexthop-local
                unset set-originator-id
            next
            edit 100
                unset set-ip-nexthop
                unset set-ip6-nexthop
                unset set-ip6-nexthop-local
                unset set-originator-id
            next
        end
    next
end

config router bgp
    set as 65432
    set router-id 1.5.73.1
    set ibgp-multipath enable
    config neighbor
        edit "1.5.73.2"
            set remote-as 65000
            set route-map-out "OUT-TO-FG-ICT-PRABUMULIH"
        next
    end
    config neighbor-group
        edit "TUN-MAIN"
            set link-down-failover enable
            set next-hop-self enable
            set remote-as 65432
            set route-map-out "OUT-TO-ADVPN-SPOKE"
            set keep-alive-timer 4
            set holdtime-timer 12
            set route-reflector-client enable
        next
    end
    config neighbor-range
        edit 1
            set prefix 169.254.50.0 255.255.255.0
            set neighbor-group "TUN-MAIN"
        next
    end
    config network
        edit 1
            set prefix 1.5.73.0 255.255.255.252
        next
        edit 2
            set prefix 10.203.0.0 255.255.0.0
        next
        edit 3
            set prefix 10.203.48.50 255.255.255.255
        next
        edit 4
            set prefix 36.89.123.184 255.255.255.248
        next
    end
    config redistribute "connected"
        set status enable
    end
end

config firewall policy
    edit 1
        set name "HUB-TO-SPOKE"
        set uuid a3e8a778-93da-51ed-7e8e-a35942b878e0
        set srcintf "lan"
        set dstintf "TUN-MAIN"
        set srcaddr "all"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
        set logtraffic all
    next
    edit 2
        set name "SPOKE-TO-HUB"
        set uuid f87d4258-93e4-51ed-6d86-a181529d98cd
        set srcintf "TUN-MAIN"
        set dstintf "lan"
        set srcaddr "all"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
        set logtraffic all
    next
    edit 3
        set name "SPOKE-TO_SPOKE"
        set uuid f8854818-93e4-51ed-1703-7af3612296c2
        set srcintf "TUN-MAIN"
        set dstintf "TUN-MAIN"
        set srcaddr "all"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
    next
    edit 5
        set name "test"
        set uuid 2ba74036-99bf-51ed-d714-3506f38192d2
        set srcintf "any"
        set dstintf "any"
        set srcaddr "all"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
    next
    edit 4
        set name "VIP-Forwarding"
        set uuid 8c8491f4-99ad-51ed-04fc-025bbd22e2b5
        set srcintf "wan"
        set dstintf "lan"
        set srcaddr "all"
        set dstaddr "VIP-Forwarding"
        set action accept
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set nat enable
    next
end

config firewall vip
    edit "PRTG-https"
        set uuid ebf6e08e-99ac-51ed-0991-3f6f84b7c88e
        set extip 36.89.123.187
        set mappedip "1.5.73.250"
        set extintf "any"
        set portforward enable
        set color 6
        set extport 9090
        set mappedport 80
    next
    edit "FG-100FICT-ssh"
        set uuid 6fe777cc-99ae-51ed-7b72-41e18a327916
        set extip 36.89.123.187
        set mappedip "1.5.73.249"
        set extintf "any"
        set portforward enable
        set extport 8844
        set mappedport 3355
    next
    edit "FG-100FICT-https"
        set uuid c868cdfa-99b4-51ed-aafe-ddf08b98d2d9
        set extip 36.89.123.187
        set mappedip "1.5.73.249"
        set extintf "any"
        set portforward enable
        set extport 8000
        set mappedport 443
    next
end

config firewall vipgrp
    edit "VIP-Forwarding"
        set uuid 305dea4c-99ad-51ed-e5ad-5825d8e3e066
        set interface "any"
        set color 3
        set member "PRTG-https" "FG-100FICT-ssh" "FG-100FICT-https"
    next
end

config system global
    set admin-ssh-port 3355
    set alias "HUB-PRABUMULIH"
    set cli-audit-log enable
    set hostname "HUB-PRABUMULIH"
    set pre-login-banner enable
    set switch-controller enable
    set timezone 53
end

config system admin
    edit "cpelintasartassa"
        set accprofile "super_admin"
        set vdom "root"
        set password ENC SH2ELpdZKzGbd1fVnhjWmhOC3DrgyvgJg32qNYYGZjewLG9vmb3MWNwddXjtzs=
    next
end

