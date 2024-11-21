# FOR TESTS ONLY

## Description :

This script will allows you to get informations (mode helps, current and latest version) of a Centreon plugin.

## Prerequisites :

* Only work with Centreon plugin installed by packages.

## How to use : 

## Help :
```
# ./display.sh

The script allows you to get the help of centreon plugin and its mode, from the check command or the plugin package name.
Example: ./display.sh /usr/lib/centreon/plugins/centreon_linux_snmp.pl
Example: ./display.sh centreon-plugin-Operatingsystems-Linux-Snmp

```

## Functionnalities :


* Work with Debian and RHEL systems.
* Will detect all the plugin modes for you to select.
* Will retrieve the current and latest plugin versions for you to compare.

## Example :
Retrieving information about centreon-plugin-Operatingsystems-Linux-Snmp (via package), select 7)
```
# ./display.sh centreon-plugin-Operatingsystems-Linux-Snmp
1) arp                4) disk-usage        7) interfaces       10) list-interfaces  13) load             16) storage          19) time
2) cpu                5) diskio            8) list-diskio      11) list-processes   14) memory           17) swap             20) udpcon
3) cpu-detailed       6) inodes            9) list-diskspath   12) list-storages    15) processcount     18) tcpcon           21) uptime
#? 7
#### current version ####
centreon-plugin-Operatingsystems-Linux-Snmp-20241107-152627.el9.noarch
#### latest version ####
centreon-plugin-Operatingsystems-Linux-Snmp.noarch 20241107-152627.el9 centreon-plugins-23.10-stable-noarch 
#### check command ####
/usr/lib/centreon/plugins/centreon_linux_snmp.pl --plugin=os::linux::snmp::plugin --mode=interfaces
#### help ####
    Check interfaces.

    --add-global
            Check global port statistics (by default if no --add-* option is
            set).

    --add-status
            Check interface status.

    --add-duplex-status
            Check duplex status (with --warning-status and
            --critical-status).

    --add-traffic
            Check interface traffic.

    --add-errors
            Check interface errors.

    --add-cast
            Check interface cast.

    --add-speed
            Check interface speed.

    --add-volume
            Check interface data volume between two checks (not supposed to
            be graphed, useful for BI reporting).

    --check-metrics
            If the expression is true, metrics are checked (default:
            '%{opstatus} eq "up"').

    --warning-status
            Define the conditions to match for the status to be WARNING. You
            can use the following variables: %{admstatus}, %{opstatus},
            %{duplexstatus}, %{display}

    --critical-status
            Define the conditions to match for the status to be CRITICAL
            (default: '%{admstatus} eq "up" and %{opstatus} ne "up"'). You
            can use the following variables: %{admstatus}, %{opstatus},
            %{duplexstatus}, %{display}

    --warning-* --critical-*
            Thresholds. Can be: 'total-port', 'total-admin-up',
            'total-admin-down', 'total-oper-up', 'total-oper-down',
            'in-traffic', 'out-traffic', 'in-error', 'in-discard',
            'out-error', 'out-discard', 'in-ucast', 'in-bcast', 'in-mcast',
            'out-ucast', 'out-bcast', 'out-mcast', 'speed' (b/s).

    --units-traffic
            Units of thresholds for the traffic (default: 'percent_delta')
            ('percent_delta', 'bps', 'counter').

    --units-errors
            Units of thresholds for errors/discards (default:
            'percent_delta') ('percent_delta', 'percent', 'delta',
            'deltaps', 'counter').

    --units-cast
            Units of thresholds for communication types (default:
            'percent_delta') ('percent_delta', 'percent', 'delta',
            'deltaps', 'counter').

    --nagvis-perfdata
            Display traffic perfdata to be compatible with NagVis widget.

    --interface
            Define the interface filter on IDs (OID indexes, e.g.: 1,2,...).
            If empty, all interfaces will be monitored. To filter on
            interface names, see --name.

    --name  With this option, the interfaces will be filtered by name (given
            in option --interface) instead of OID index. The name matching
            mode supports regular expressions.

    --regex-id
            With this option, interface IDs will be filtered using the
            --interface parameter as a regular expression instead of a list
            of IDs.

    --speed Set interface speed for incoming/outgoing traffic (in Mb).

    --speed-in
            Set interface speed for incoming traffic (in Mb).

    --speed-out
            Set interface speed for outgoing traffic (in Mb).

    --map-speed-dsl
            Get interface speed configuration for interfaces of type 'ADSL'
            and 'VDSL2'.

            Syntax: --map-speed-dsl=interface-src-name,interface-dsl-name

            E.g: --map-speed-dsl=Et0.835,Et0-vdsl2

    --force-counters64
            Force to use 64 bits counters only. Can be used to improve
```
Retrieving information about /usr/lib/centreon/plugins/centreon_linux_snmp.pl (via check command path), select 1)
```
# ./display.sh /usr/lib/centreon/plugins/centreon_linux_snmp.pl
1) arp                4) disk-usage        7) interfaces       10) list-interfaces  13) load             16) storage          19) time
2) cpu                5) diskio            8) list-diskio      11) list-processes   14) memory           17) swap             20) udpcon
3) cpu-detailed       6) inodes            9) list-diskspath   12) list-storages    15) processcount     18) tcpcon           21) uptime
#? 1
#### current version ####
centreon-plugin-Operatingsystems-Linux-Snmp-20241107-152627.el9.noarch
#### latest version ####
centreon-plugin-Operatingsystems-Linux-Snmp.noarch 20241107-152627.el9 centreon-plugins-23.10-stable-noarch 
#### check command ####
/usr/lib/centreon/plugins/centreon_linux_snmp.pl --plugin=os::linux::snmp::plugin --mode=arp
#### help ####
    Check arp table.

    --filter-macaddr
            Filter mac addresses (can be a regexp).

    --filter-ipaddr
            Filter ip addresses (can be a regexp).

    --warning-* --critical-*
            Thresholds. Can be: 'total-entries', 'duplicate-macaddr',
            'duplicate-ipaddr'.

```
