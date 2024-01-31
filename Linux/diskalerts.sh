#!/bin/sh
dusage=$(df -Ph | grep 'dev/root/' | sed s/%//g | awk '{ if($5 > 60) print $0;}')
fscount=$(echo "$dusage" | wc -l)
    if [ "${fscount}" -ge 2 ];
        then
        echo "$dusage" | mail -s "Disk Space Alert On $(hostname) at $(date)" saivamsimohankrishna.bodavula@thomsonreuters.com
     else
        echo "Disk usage is in under threshold"
fi

