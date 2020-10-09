#!/bin/bash

declare -a tools=(
    "DataGrip"
    "GoLand"
    "PyCharm"
    "Rider"
    "IntelliJIdea"
    )

for tool in "${tools[@]}"
do
    echo "removing evaluation key for $tool"
    rm -rf ~/.$tool*/config/eval
    rm -rf ~/.java/.userPrefs/jetbrains/${tool,,}
done

for tool in "${tools[@]}"
do
    echo "resetting evalsprt in options.xml for $tool"
    sed -i '/evlsprt/d' ~/.$tool*/config/options/other.xml
done

echo "resetting evalsprt in prefs.xml"
sed -i '/evlsprt/d' ~/.java/.userPrefs/prefs.xml

for tool in "${tools[@]}"
do
    echo "change date file for $tool"
    find ~/.$tool* -type d -exec touch -t $(date +"%Y%m%d%H%M") {} +;
    find ~/.$tool* -type f -exec touch -t $(date +"%Y%m%d%H%M") {} +;
done