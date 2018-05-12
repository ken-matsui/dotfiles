#!/bin/bash

#url='https://eu1.qnap.com/Storage/Utility/QNAPQfinderProMac-2.6.0.0214.dmg'
#filename=${url##*/}

#curl -fsLO $url
#mount_dir=`hdiutil attach $filename | awk -F '\t' 'END{print $NF}'`
#yes | sudo installer -pkg "${mount_dir}/Qfinder Pro.pkg" -target / >/dev/null
#hdiutil detach "$mount_dir" >/dev/null
#rm -rf $filename
