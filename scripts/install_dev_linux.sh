#!/bin/bash

########################################################################################################################
# Create a symbolic link to the sources in ~/.local/share/QGIS/QGIS3/profiles/default/python/plugins
########################################################################################################################

set -u # Exit if we try to use an uninitialised variable
set -e # Return early if any command returns a non-0 exit status

echo "ADD PLUGIN TO QGIS (dev version -- link)"

PWD=`pwd`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PLUGIN=Mergin
SRC=$DIR/../$PLUGIN

DEST=~/.local/share/QGIS/QGIS3/profiles/default/python/plugins
DEST_PLUGIN=$DEST/$PLUGIN

if [ ! -d "$SRC" ]; then
  echo "Missing directory $SRC"
  exit 1
fi

DEPS_SRC=$DIR/../../mergin-py-client

if [ ! -d "$DEPS_SRC" ]; then
  echo "Missing dependency $DEPS_SRC. Did clone git repository?"
  exit 1
fi

rm -f $SRC/mergin
ln -s $DEPS_SRC/mergin/ $SRC/mergin

rm -rf $DEST_PLUGIN
ln -s $SRC $DEST_PLUGIN

echo "$DEST_PLUGIN created"

cd $PWD
