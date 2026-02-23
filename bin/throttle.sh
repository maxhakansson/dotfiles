#! /bin/bash

# Copyright (c) 2020 Conviva Inc. All rights reserved.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# This software relies on the PFCTL and DNCTL tools built in in MAC OS X
# starting from the OS X version 10.7 (Lion). Respective copyrights
# can be found by the following links:

# PFCTL:
# Copyright (c) 2007-2011 Apple Inc.
# Copyright (c) 2001 Daniel Hartmeier
# Copyright (c) 2002,2003 Henning Brauer
# All rights reserved.
# https://opensource.apple.com/source/xnu/xnu-1699.22.73/bsd/net/pf.c

# DNCTL:
# Copyright (c) 2002-2012 Apple Inc.
# Copyright (c) 2002-2003 Luigi Rizzo
# Copyright (c) 1996 Alex Nash, Paul Traina, Poul-Henning Kamp
# Copyright (c) 1994 Ugen J.S.Antsilevich
# Copyright (c) 1993 Daniel Boulet
# All rights reserved.
# https://opensource.apple.com/source/network_cmds/network_cmds-433/dnctl/dnctl.c.auto.html


echo ''
echo 'README'
echo 'pfctl + dnctl wrapper with a purpose of simple incoming traffic shaping.'
echo 'Designed to work with OS X default internet-share'
echo 'Internet-share supposedly already started when the script is executed'
echo 'Refer to examples for the list of commands'
echo ''
echo "EXAMPLES:"
echo ''
echo "'q' - will clear the rules and exit the script"
echo "'flush' - will clear the rules set at any time during script usage"
echo "'show' - will display all active rules"
echo "'<target> <command>' - target is an IP address and available commands are described below"
echo "  block - will drop all packets for the specified target"
echo "  blockd or bd - will delete the target from the blocked addresses"
echo "  0 - set a 0Kbit/s bandwidth for the target"
echo "  0d - delete the target from the 0kbit/s throttled addresses"
echo "  50 - bandwidth to 50Kbit/s"
echo "  50d - delete the target from the 50kbit/s throttled addresses"
echo "  100 - bandwidth to 100Kbit/s"
echo "  100d - delete the target from the 100kbit/s throttled addresses"
echo "  250 - bandwidth to 250Kbit/s"
echo "  250d - delete the target from the 250kbit/s throttled addresses"
echo "  500 - bandwidth to 500Kbit/s"
echo "  500d - delete the target from the 500kbit/s throttled addresses"
echo "  1000 - bandwidth to 1000Kbit/s"
echo "  1000d - delete the target from the 1000kbit/s throttled addresses"
echo ""
echo "  Additional commands added to block all incoming traffic for the specific device."
echo "  Syntax: <targetIP> device or <targetIP> device300"
echo "  targetIP - it is a local device IP"
echo "  device - will throttle the network for the traget device to 3000Kbit/s which is somewhat around 3G capability"
echo "  device300 - will throttle to 300Kbit/s"
echo ""
echo "  Additionally 'commandflush' or 'commandf' will flush a particular ruleset"
echo "  These flush commands can be called without a target"
echo "  Example: 100flush or 100f - will flush addresses throttled to 100Kbit/s"
echo ''
echo "  Added a new functionality to block Google DNS server IPs"
echo "  Use command the following command to enable it:"
echo "  google"
echo "  To disable this rule use outf or of or outcomingf command"
echo ''
echo '-----------------IMPORTANT: RESTART THE SHARING AFTER THE SCRIPT IS CLOSED-----------------'
echo '-------------------------PLEASE USE q COMMAND TO EXIT THE SCRIPT---------------------------'
echo ''

# Enable pf in case it was disabled
sudo pfctl -e 2>/dev/null

# Function declaration
function flushRules () {
  echo 'Block ruleset'
  sudo pfctl -t drp -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '0Kbit/s ruleset'
  sudo pfctl -t bw0 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '50Kbit/s ruleset'
  sudo pfctl -t bw50 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '100Kbit/s ruleset'
  sudo pfctl -t bw100 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '250Kbit/s ruleset'
  sudo pfctl -t bw250 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '500Kbit/s ruleset'
  sudo pfctl -t bw500 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '1000Kbit/s ruleset'
  sudo pfctl -t bw1000 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo 'Device 3G ruleset'
  sudo pfctl -t device -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo 'Device 300 ruleset'
  sudo pfctl -t device300 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo "------------------------------"
  echo "    All rules are cleared...  "
  echo "------------------------------"
}

function showRules () {
  echo 'Block ruleset'
  echo '------------------'
  sudo pfctl -t drp -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo '0Kbit/s ruleset'
  echo '------------------'
  sudo pfctl -t bw0 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo '50Kbit/s ruleset'
  echo '------------------'
  sudo pfctl -t bw50 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo '100Kbit/s ruleset'
  echo '------------------'
  sudo pfctl -t bw100 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo '250Kbit/s ruleset'
  echo '------------------'
  sudo pfctl -t bw250 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo '500Kbit/s ruleset'
  echo '------------------'
  sudo pfctl -t bw500 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo '1000Kbit/s ruleset'
  echo '------------------'
  sudo pfctl -t bw1000 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo 'Device 3G rulset'
  echo '------------------'
  sudo pfctl -t device -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo 'Device 300 rulset'
  echo '------------------'
  sudo pfctl -t device300 -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
  echo 'Outcoming traffic rulset'
  echo '------------------'
  sudo pfctl -t outcoming -T show 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo '------------------'
}

function blockGoogle () {
  sudo pfctl -t outcoming -T add 8.8.8.8 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  sudo pfctl -t outcoming -T add 8.8.4.4 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
  echo ""
  echo "Google DNS servers has been blocked."
  echo "Please make sure that your connection is using other DNS server"
  echo "e.g. Cloudfare (1.1.1.1 and 1.0.0.1)."
  echo ""
}

# Get the internet-sharing configuration to assign to pfctl config
temp=$(sudo pfctl -a "com.apple.internet-sharing/base_v4" -s nat 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$'))
IFS='
'
set -- $temp
array=( $@ )
for item in ${array[@]}; do
  echo $item;
done > ruleset.conf
cat <<EOT >> ruleset.conf
table <drp> persist
table <bw0> persist
table <bw50> persist
table <bw100> persist
table <bw250> persist
table <bw500> persist
table <bw1000> persist
table <device> persist
table <device300> persist
table <outcoming> persist
dummynet in from <drp> to any pipe 1
dummynet in from <bw0> to any pipe 2
dummynet in from <bw50> to any pipe 3
dummynet in from <bw100> to any pipe 4
dummynet in from <bw250> to any pipe 5
dummynet in from <bw500> to any pipe 6
dummynet in from <bw1000> to any pipe 7
dummynet out from any to <device> pipe 8
dummynet out from any to <device300> pipe 9
dummynet out from any to <outcoming> pipe 1
EOT

# Load new rules and
# supress ALTQ nonsense but keep stderr messages from bad filter syntax
sudo pfctl -f ruleset.conf 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')

# Delete previosly created temporary config file
unlink ruleset.conf

# Create a DNCTL pipe configs
sudo dnctl pipe 1 config plr 0.99
sudo dnctl pipe 2 config bw 1Kbit/s
sudo dnctl pipe 3 config bw 50Kbit/s
sudo dnctl pipe 4 config bw 100Kbit/s
sudo dnctl pipe 5 config bw 250Kbit/s
sudo dnctl pipe 6 config bw 500Kbit/s
sudo dnctl pipe 7 config bw 1000Kbit/s
sudo dnctl pipe 8 config bw 3000Kbit/s
sudo dnctl pipe 9 config bw 300Kbit/s
IFS=$' \t\n'

# Loop through the user input
while true; do
  echo "'Enter <target> <command> (enter q to exit)'"
    read target command
    echo ''

    # flushAll and/or Exit conditions
    if [[ $target = "flush" ]]; then
      flushRules
      continue
    fi

    if [[ $target = "show" ]]; then
      showRules
      continue
    fi

    if [[ $target = "google" ]]; then
      blockGoogle
      continue
    fi

    if [[ $target = "q" ]]; then
      flushRules
      # Delete DNCTL rules
      sudo dnctl -q flush
      # Reset default pf config
      sudo pfctl -f /etc/pf.conf 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
      echo "------------------------------"
      echo "          Exiting...          "
      echo "------------------------------"
      exit 0
    fi

    # Handle commands to clear the tables
    case $target in
      blockflush|blockf|bf)
        sudo pfctl -t drp -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "all targets unblocked"
        echo ""
        continue
        ;;

      0flush|0f)
        sudo pfctl -t bw0 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "0Kbit/s Pipe is cleared"
        echo ""
        continue
        ;;

      50flush|50f)
        sudo pfctl -t bw50 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "50Kbit/s Pipe is cleared"
        echo ""
        continue
        ;;

      100flush|100f)
        sudo pfctl -t bw100 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "100Kbit/s Pipe is cleared"
        echo ""
        continue
        ;;

      250flush|250f)
        sudo pfctl -t bw250 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "250Kbit/s Pipe is cleared"
        echo ""
        continue
        ;;

      500flush|500f)
        sudo pfctl -t bw500 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "500Kbit/s Pipe is cleared"
        echo ""
        continue
        ;;

      1000flush|1000f)
        sudo pfctl -t bw1000 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "1000Kbit/s Pipe is cleared"
        echo ""
        continue
        ;;

      deviceflush|devicef|df)
        sudo pfctl -t device -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "Device 3G throttling is cleared"
        echo ""
        continue
        ;;

      device300flush|device300f|d300f)
        sudo pfctl -t device300 -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "Device 300Kbit/s throttling is cleared"
        echo ""
        continue
        ;;

      outf|outcomingf|of)
        sudo pfctl -t outcoming -T flush 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "Outcoming traffic block is cleared"
        echo ""
        continue
        ;;
    esac

    # Sort targets to the respective pipes
    case $command in
      block)
        sudo pfctl -t drp -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target blocked"
        echo ""
        continue
        ;;

      blockd|bd)
        sudo pfctl -t drp -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unblocked"
        echo ""
        continue
        ;;

      0)
        sudo pfctl -t bw0 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target throttled to 0Kbit/s"
        echo ""
        continue
        ;;

      0d)
        sudo pfctl -t bw0 -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unthrottled"
        echo ""
        continue
        ;;

      50)
        sudo pfctl -t bw50 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target throttled to 50Kbit/s"
        echo ""
        continue
        ;;

      50d)
        sudo pfctl -t bw50 -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unthrottled"
        echo ""
        continue
        ;;

      100)
        sudo pfctl -t bw100 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target throttled to 100Kbit/s"
        echo ""
        continue
        ;;

      100d)
        sudo pfctl -t bw100 -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unthrottled"
        echo ""
        continue
        ;;

      250)
        sudo pfctl -t bw250 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target throttled to 250Kbit/s"
        echo ""
        continue
        ;;

      250d)
        sudo pfctl -t bw250 -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unthrottled"
        echo ""
        continue
        ;;

      500)
        sudo pfctl -t bw500 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target throttled to 500Kbit/s"
        echo ""
        continue
        ;;

      500d)
        sudo pfctl -t bw500 -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unthrottled"
        echo ""
        continue
        ;;

      1000)
        sudo pfctl -t bw1000 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target throttled to 1000Kbit/s"
        echo ""
        continue
        ;;

      1000d)
        sudo pfctl -t bw1000 -T delete $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "$target unthrottled"
        echo ""
        continue
        ;;

      device)
        sudo pfctl -t device -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "Device with IP $target throttled to 3000Kbit/s (3G)"
        echo ""
        continue
        ;;

      device300)
        sudo pfctl -t device300 -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "Device with IP $target throttled to 300Kbit/s"
        echo ""
        continue
        ;;

      out|outcoming|o)
        sudo pfctl -t outcoming -T add $target 2> >(grep -v 'ALTQ\|pf.conf\|flushing of rules\|present in the main ruleset\|^$')
        echo "Outcoming traffic to IP $target is blocked"
        echo ""
        continue
        ;;

      *)
        echo "------------------------------------------"
        echo "Incorrect command, please check the syntax"
        echo "------------------------------------------"
        echo ''
        continue
        ;;
    esac
done
