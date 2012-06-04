#!/bin/sh

testscript="org.eclipse.swtbot.testscript"
testscript_gef="org.eclipse.swtbot.gef.testscript"
rcp_apps="org.storytext.rcp.maildemo,org.storytext.rcp.jobs,org.storytext.rcp.tabselection,org.storytext.rcp.uiforms"
gef_apps="org.storytext.rcp.gef.basic"

eclipse_home=
eclipse_version=$1
install_root=$2
artifact_root=$3
p2Repo="$install_root/p2repo-$eclipse_version"
rcp_installation="$install_root/eclipse_test/eclipse"
gef_installation="$install_root/eclipse_test/eclipse_gef"

if [ "$eclipse_version" == "3.5" ]; then
    eclipse_home="/usr/local/eclipse-targetSDK-3.5.2/eclipse"
elif [ "$eclipse_version" == "3.6" ]; then
    eclipse_home="/usr/local/eclipse-targetSDK-3.6.2/eclipse"
elif [ "$eclipse_version" == "3.7" ]; then
    eclipse_home="/usr/local/eclipse-targetSDK-3.7.1/eclipse"
fi

export ECLIPSE_HOME=$eclipse_home

# Make p2 repository containing all artifacts
./makerepository.sh $eclipse_version $artifact_root $p2Repo "$testscript,$testscript_gef,$rcp_apps,$gef_apps" profile

# Install testscript rcp
./install_artifact.sh "file://$p2Repo" $rcp_installation $testscript profile

# Install testscript gef
./install_artifact.sh "file://$p2Repo" $gef_installation $testscript_gef profile

# Install all rcp applications
./install_artifact.sh "file://$p2Repo" $rcp_installation $rcp_apps profile

# Install all gef applications
./install_artifact.sh "file://$p2Repo" $gef_installation $gef_apps profile
