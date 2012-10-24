#!/bin/bash

HOST='throughnothing.com'
CONNECTED='yes'
pgrep -lf 23433.localhost.22 > /dev/null || CONNECTED="no"

if [ "$CONNECTED" == "no" ]; then
    echo "Not connected...retrying...."
    ssh -f -N -R 23433:localhost:22 throughnothing@$HOST
else
    echo "Already Connected...exiting...."
fi
