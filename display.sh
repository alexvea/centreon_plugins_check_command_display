#!/usr/bin/env bash
PLUGIN_PATH_REGEX="\/usr\/.*.pl"
YUM_VERSION_REGEX="-[0-9]\{8\}-[0-9]*.*"
APT_VERSION_REGEX=":$"

help()
{
   # Display Help
   echo
   echo "The script allows you to get the help of centreon plugin and its mode, from the check command or the plugin package name."
   echo "Example: ./display.sh /usr/lib/centreon/plugins/centreon_linux_snmp.pl"
   echo "Example: ./display.sh centreon-plugin-Operatingsystems-Linux-Snmp"
   echo
}

[ -z "$1" ] && help && exit

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
        #DEBIAN  dpkg -l | grep `dpkg -S /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl  | awk -F: '{ print $1 }'` | awk ' { print $2"-"$3} '
        #RHEL rpm -qf /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl
        $(/usr/bin/env grep -q "Debian" /etc/os-release) && bin="dpkg -l | grep `dpkg -S $1  | awk -F: '{ print $1 }'` | awk ' { print \$2\" \"\$3} '" || bin="rpm -qf $1"
        echo "$bin" | bash
}
function get_latest_plugin_version {
        #DEBIAN apt-cache policy centreon-plugin-operatingsystems-as400-connector | grep Candidate
        #RHEL yum --showduplicates list /usr/lib/centreon/plugins/centreon_netapp_ontap_snmp.pl
        PLUGIN_WITHOUT_VERSION=$(echo $1 | sed -e "s/${YUM_VERSION_REGEX}//g" | sed -e "s/${APT_VERSION_REGEX}//g")
        $(/usr/bin/env grep -q "Debian" /etc/os-release) && bin="apt-cache policy ${PLUGIN_WITHOUT_VERSION} | grep Candidate" || bin="yum --showduplicates list ${PLUGIN_WITHOUT_VERSION} | tail -1"
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
