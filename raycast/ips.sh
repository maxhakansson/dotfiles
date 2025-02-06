#!/bin/bash

# Raycast parameters:
# @raycast.schemaVersion 1
# @raycast.title My Private IPs
# @raycast.mode fullOutput

# Optional parameters
# @raycast.icon 🛜

ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep 'inet '
