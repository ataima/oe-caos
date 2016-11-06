#!/bin/sh -x

#Colors
COLOR_WHITE=" -e \E[1;37m"
COLOR_GRAY_LIGHT=" -e \E[0;37m"
COLOR_GRAY_DARK=" -e \E[1;30m"
COLOR_BLUE=" -e \E[0;34m"
COLOR_BLUE_LIGHT=" -e \E[1;34m"
COLOR_GREEN=" -e \E[0;32m"
COLOR_GREEN_LIGHT=" -e \E[1;32m"
COLOR_CYAN=" -e \E[0;36m"
COLOR_CYAN_LIGHT=" -e \E[1;36m"
COLOR_RED=" -e \E[0;31m"
COLOR_RED_LIGHT=" -e \E[1;31m"
COLOR_PURPLE=" -e \E[0;35m"
COLOR_PURPLE_LIGHT=" -e \E[1;35m"
COLOR_BROWN=" -e \E[0;33m"
COLOR_YELLOW=" -e \E[1;33m"
COLOR_BLACK=" -e \E[0;30m"
REPLACE=" -e \E[0m"

if [ "$1" == "" ]; then
	echo -e $(echo $COLOR_RED_LIGHT)" usage : ./bootstrap.sh <build directory to create> <path of oe-core openembedded>"$(echo $REPLACE) 
	exit 1
fi

if [ "$2" == "" ]; then
	echo -e $(echo $COLOR_RED_LIGHT)" usage : ./bootstrap.sh <build directory to create> <path of oe-core openembedded>"$(echo $REPLACE) 
	exit 1
fi


BUILD=$1
rm -rf $BUILD
cd ../oe-core
./oe-init-build-env $BUILD  > /dev/null
cd ../oe-caos
echo -e $(echo $COLOR_GREEN_LIGHT) "copy default conf" $(echo $REPLACE) 
cat ./default_bblayers.conf  | sed -e  "s#../oe-core/meta#$2/oe-core/meta#g" | sed  -e "s#./meta-caos#$PWD/meta-caos#g"> $BUILD/conf/bblayers.conf
cat ./default_local.conf | sed -e "s#DL_DIR ?=.*#DL_DIR ?= \"$HOME/download\"#g" > $BUILD/conf/local.conf
export PATH="$2/oe-core/bitbake/bin:$PATH"
cd $BUILD 
echo -e $(echo $COLOR_RED_LIGHT)"START BITBAKE caOS"$(echo $REPLACE) 
bitbake caos



