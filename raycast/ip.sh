#!/bin/bash

# Raycast parameters:
# @raycast.schemaVersion 1
# @raycast.title My Public IP
# @raycast.mode compact

# Optional parameters
# @raycast.icon 🛜

dig +short myip.opendns.com @resolver1.opendns.com
