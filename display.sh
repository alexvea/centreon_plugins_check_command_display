PLUGIN_PATH_REGEX="\/usr\/.*.pl"
[ -z "$1" ] && echo "No parameter" && exit

function get_plugin_path_from_package_name {
        #DEBIAN dpkg-query -L centreon-plugin-network-cisco-standard-snmp | tail -1
        #RHEL rpm -ql centreon-plugin-network-cisco-standard-snmp
        [[ $(/usr/bin/env grep -q "Debian" /etc/os-release) ]] && bin="dpkg-query -L $1 | tail -1" || bin="rpm -ql $1"
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

[[ $1 =~ $PLUGIN_PATH_REGEX ]] && PLUGIN_PATH=$1 || PLUGIN_PATH=$(get_plugin_path_from_package_name $1)

[[ $($PLUGIN_PATH --list-plugin | grep PLUGIN | wc -l) != 1 ]] && echo "plusieur plugins" || OPT_PLUGIN=$($PLUGIN_PATH --list-plugin | grep PLUGIN | awk ' { print $2 }')

create_menu_mode `$PLUGIN_PATH --plugin=$OPT_PLUGIN --list-mode | grep  'Modes Available' -A100 | tail -n +2`

echo "#### check command ####"
echo $PLUGIN_PATH --plugin=$OPT_PLUGIN --mode=$OPT_MODE

echo "#### help ####"
echo "$PLUGIN_PATH --plugin=$OPT_PLUGIN --mode=$OPT_MODE --help | egrep '(Mode:|Mode :)' -A100 | tail -n +2" | bash
