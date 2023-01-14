#NOTE
# ALIAS DAN HOSTNAME PADA CONFIG SYSTEM GLOBAL DI GANTI DGN FORMAT NOJAR_NAMA LOKASI

#1-GLOBAL SETTING
config system global
    set admin-ssh-port 3355
    #Format panamaan lokasi Nojaringan-Nama-Lokasi "huruf kapital"
    set alias "2022329711-SKG-BENUANG-PERCEPATAN"
    set cli-audit-log enable
    set hostname "2022329711-SKG-BENUANG-PERCEPATAN"
    set pre-login-banner enable
    set timezone 53
    set virtual-switch-vlan enable
end

#2-Tacacs+
config log tacacs+accounting setting
        set status enable
        set server 10.203.1.154
        set server-key PHR@Secr3TkEY
end

config log tacacs+accounting filter
          set login-audit enable
          set config-change-audit enable
          set cli-cmd-audit enable
end

config system accprofile
    edit prof_tacacs+
    next
    edit admin_eos
        set secfabgrp read
        set ftviewgrp read-write
        set authgrp read
        set sysgrp custom
        set netgrp read-write
        set loggrp read-write
        set fwgrp read-write
        set vpngrp read-write
        set utmgrp read-write
        set wifi read-write
        config sysgrp-permission
            set admin read
            set upd read
            set cfg read
            set mnt read
        end
    next
    edit readonly
        set secfabgrp read
        set ftviewgrp read
        set authgrp read
        set sysgrp read
        set netgrp read
        set loggrp read
        set fwgrp read
        set vpngrp read
        set utmgrp read
        set wifi read
    next
end

config user tacacs+
   edit phrtacacs+
       set authorization enable
       set server 10.203.1.154
       set key PHR@Secr3TkEY
       set authen-type auto
       #SOURCE IP SESUAIKAN DGN IP Loopback0
       set source-ip 10.203.88.21
    next
end

config user group
    edit tacacs+_group
       set member phrtacacs+
    next
end

#3-USER ACCOUNT
config system admin
    edit "cpelintasartassa"
        set accprofile "super_admin"
        set vdom "root"
        set password L1nt4s4rt@_SSA!
    next
    edit "remote-login"
        set remote-auth enable
        set accprofile prof_tacacs+
        set comments auth-tacacs+
        set vdom root
        set wildcard enable
        set remote-group tacacs+_group
        set accprofile-override enable
    next
end

#4-SNMP
config system snmp sysinfo
    set status enable
    set description "SNMP"
    set contact-info "Lintasarta"
    set location "2022329711-SKG-BENUANG-PERCEPATAN"
end
config system snmp community
    edit 1
        set name "public"
        config hosts
            edit 1
            next
        end
    next
end

#5-NTP SERVER 
config system ntp
    set ntpsync enable
    set type custom
    config ntpserver
        edit 1
            set server "10.203.1.154"
        next
    end
    set server-mode enable
    set interface "fortilink"
end

#6-PRE LOGIN BANNER
config system replacemsg admin pre_admin-disclaimer-text
    set buffer "Lintasarta-SSA Operation !
    MENGAKSES PERANGKAT INI TANPA APPROVAL TIDAK DIPERBOLEHKAN.
    Anda harus memiliki approval secara eksplisit untuk mengakses atau mengatur perangkat ini.
    Setiap aktivitas yang dilakukan pada perangkat ini akan tercatat, 
    dan pelanggaran atas hal ini dapat berakibat pada tindakan disipliner dan dilaporkan ke pihak berwajib.
    Tidak ada hak atas kerahasiaan pada perangkat ini, atau pada data dan dikirimkan menggunakan, atau melalui perangkat ini.
    "
end

#7-DISABLE PORT YANG TIDAK DIGUNAKAN
config system interface
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
    edit "fortilink"
        set status down
    next
end

#8-DELETE USER ADMIN -> Login ulang ke Fortigate dengan User cpelintasartassa Password L1nt4s4rt@_SSA!
config system admin
    delete admin
end

#9-DISABLE DHCP SERVER LAN OTHER
