#!/bin/sh

rm -rf /tmp/testscript_repo
rm -rf $3

swtbot_version=
eclipse_version=$1
if [ "$eclipse_version" == "3.5" ]; then
    swtbot_version="galileo"
else
    swtbot_version="helios"
fi

echo "EHOME: $ECLIPSE_HOME"
echo "Eclipse version: $1"
echo "Source: $2"
echo "Destination: $3"
echo "Artifacts: $4"
echo "Profile: $5"

# Make a P2 repo containing just our code
${ECLIPSE_HOME}/eclipse -application org.eclipse.equinox.p2.publisher.FeaturesAndBundlesPublisher -metadataRepository file:///tmp/testscript_repo -artifactRepository file:///tmp/testscript_repo -source ${2} -configs gtk.linux.x86,win32.win32.x86 -publishArtifacts -noSplash

# Create a P2 artifact repository containing our plugins and all their dependencies
${ECLIPSE_HOME}/eclipse -application org.eclipse.equinox.p2.director -repository file:///tmp/testscript_repo/,http://download.eclipse.org/tools/gef/updates/releases,http://download.eclipse.org/technology/swtbot/${swtbot_version}/dev-build/update-site/,http://download.eclipse.org/eclipse/updates/${eclipse_version} -installIU ${4} -consoleLog -destination ${3} -profile $5 -noSplash   

# Mirror the metadata from all the source repositories we used
${ECLIPSE_HOME}/eclipse -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication -source file:///tmp/testscript_repo -destination file://${3} -consoleLog -noSplash

${ECLIPSE_HOME}/eclipse -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication -source http://download.eclipse.org/technology/swtbot/${swtbot_version}/dev-build/update-site/ -destination file://${3} -consoleLog -noSplash

${ECLIPSE_HOME}/eclipse -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication -source http://download.eclipse.org/tools/gef/updates/releases -destination file://${3} -consoleLog -noSplash

${ECLIPSE_HOME}/eclipse -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication -source http://download.eclipse.org/eclipse/updates/${eclipse_version} -destination file://${3} -consoleLog -noSplash

