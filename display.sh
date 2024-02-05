#!/usr/bin/env bash
PLUGIN_PATH_REGEX="\/usr\/.*.pl"
YUM_VERSION_REGEX="-[0-9]\{8\}-[0-9]*.*"
APT_VERSION_REGEX=":$"
[ -z "$1" ] && echo "No parameter" && exit

function get_plugin_path_from_package_name {
        #DEBIAN dpkg-query -L centreon-plugin-network-cisco-standard-snmp | tail -1
        #RHEL rpm -ql centreon-plugin-network-cisco-standard-snmp
        $(/usr/bin/env grep -q "Debian" /etc/os-release) && bin="dpkg-query -L $1 | tail -1" || bin="rpm -ql $1"
        echo "$bin" | bash
}
function create_menu_mode {
        select mode in $@;do
                  if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $# ];
                  then
                            OPT_MODE=$mode
                            break;
                  else
                            echo "Wrong selection: Select any number from 1-$#"
                  fi
        done
}
function get_current_plugin_version {
        #DEBIAN dpkg-query -S /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl
        #RHEL rpm -qf /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl
        $(/usr/bin/env grep -q "Debian" /etc/os-release) && bin="dpkg-query -S $1 | tail -1" || bin="rpm -qf $1"
        echo "$bin" | bash
}
function get_latest_plugin_version {
        #DEBIAN dpkg-query -S /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl
        #RHEL yum --showduplicates list /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl
        PLUGIN_WITHOUT_VERSION=$(echo $1 | sed -e "s/${YUM_VERSION_REGEX}//g" | sed -e "s/${APT_VERSION_REGEX}//g")
        $(/usr/bin/env grep -q "Debian" /etc/os-release) && bin="dpkg -s ${PLUGIN_WITHOUT_VERSION} | grep -i version" || bin="yum --showduplicates list ${PLUGIN_WITHOUT_VERSION} | tail -1"
        echo "$bin" | bash
}

[[ $1 =~ $PLUGIN_PATH_REGEX ]] && PLUGIN_PATH=$1 || PLUGIN_PATH=$(get_plugin_path_from_package_name $1)

[[ $($PLUGIN_PATH --list-plugin | grep PLUGIN | wc -l) != 1 ]] && echo "plusieur plugins" || OPT_PLUGIN=$($PLUGIN_PATH --list-plugin | grep PLUGIN | awk ' { print $2 }')

create_menu_mode `$PLUGIN_PATH --plugin=$OPT_PLUGIN --list-mode | grep  'Modes Available' -A100 | tail -n +2`
echo "#### current version ####"
get_current_plugin_version $PLUGIN_PATH
echo "#### latest version ####"
get_latest_plugin_version $(get_current_plugin_version $PLUGIN_PATH)
echo "#### check command ####"
echo $PLUGIN_PATH --plugin=$OPT_PLUGIN --mode=$OPT_MODE

echo "#### help ####"
echo "$PLUGIN_PATH --plugin=$OPT_PLUGIN --mode=$OPT_MODE --help | egrep '(Mode:|Mode :)' -A100 | tail -n +2" | bash
