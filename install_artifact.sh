#!/bin/sh

${ECLIPSE_HOME}/eclipse \
-application org.eclipse.equinox.p2.director \
-uninstallIU $3 \
-consoleLog \
-destination $2 \
-profile $4 \
-noSplash


${ECLIPSE_HOME}/eclipse \
-application org.eclipse.equinox.p2.director \
-repository $1 \
-installIU $3 \
-consoleLog \
-destination $2 \
-profile $4 \
-noSplash
