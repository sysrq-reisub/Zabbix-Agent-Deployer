
	function init_configure() {
        sed -i "s/Server=127.0.0.1/Server=$ZABBIXSRV_IP/g" /etc/zabbix/zabbix_agent2.conf
        sed -i "s/ServerActive=127.0.0.1/ServerActive=$ZABBIXSRV_IP/g" /etc/zabbix/zabbix_agent2.conf
        sed -i "s/Hostname=Zabbix server/Hostname=$ZABBIX_HOSTNAME/g" /etc/zabbix/zabbix_agent2.conf

}
 
	function inst_centos7() {
        rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
        yum -y check-update
        yum -y install zabbix-agent2
}

        function inst_centos8() {
        rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm
        yum -y check-update
        yum -y install_zabbix-agent2
}

        function inst_debian9() {
        cd /tmp
        wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-1%2Bstretch_all.deb
        dpkg -i /tmp/zabbix-release_5.0-1+stretch_all.deb
        apt update
        apt -y install zabbix-agent2
}

        function inst_debian10() {
        cd /tmp
        wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-1%2Bbuster_all.deb
        dpkg -i /tmp/zabbix-release_5.0-1+buster_all.deb
        apt update
        apt -y install zabbix-agent2
}
        function check_os() {
        if [ ! -z $(grep CentOS-7 /etc/os-release) ]; then inst_centos7; fi
        if [ ! -z $(grep CentOS-8 /etc/os-release) ]; then inst_centos8; fi
        if [ ! -z $(grep stretch /etc/os-release) ]; then inst_debian9; fi
        if [ ! -z $(grep buster /etc/os-release) ]; then inst_debian10; fi
}

	function configure_zabbix() {
	echo "Insert the Proxy or Server IP"
        read  ZABBIXSRV_IP
        echo "Insert the Hostname"
        read  ZABBIX_HOSTNAME
        printf "${RED}$ZABBIXSRV_IP${NC} and ${RED}$ZABBIX_HOSTNAME${NC}, is that correct? yes or no?\n"
	read answer;
	[[ $answer == "yes" ]] && init_configure || unset answer && return 0
}
    function start_and_reload_services() {
        killall zabbix_agent2
        systemctl enable --now zabbix-agent2
        systemctl restart zabbix-agent2
    }
