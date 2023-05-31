#!/bin/bash

OPT_PREFIX="/opt/ol"
ORIGINAL_WLP_OUTPUT_DIR="$OPT_PREFIX/wlp/output"
ORIGINAL_SERVER_NAME="defaultServer"
IS_KERNEL=true

# If the Liberty server name is not defaultServer and defaultServer still exists migrate the contents
if [ "$SERVER_NAME" != "$ORIGINAL_SERVER_NAME" ] && [ -d "$OPT_PREFIX/wlp/usr/servers/$ORIGINAL_SERVER_NAME" ]; then
  # Create new Liberty server
  if $IS_KERNEL; then
    $OPT_PREFIX/wlp/bin/server create >/tmp/serverOutput
  else
    $OPT_PREFIX/wlp/bin/server create --template=javaee8 >/tmp/serverOutput 
  fi
  rc=$?
  if [ $rc -ne 0 ]; then
    cat /tmp/serverOutput
    rm /tmp/serverOutput
    exit $rc
  fi
  rm /tmp/serverOutput

  # Verify server creation
  if [ ! -d "$OPT_PREFIX/wlp/usr/servers/$SERVER_NAME" ]; then
    echo "The server name contains a character that is not valid."
    exit 1
  fi
  chmod -R g+w $OPT_PREFIX/wlp/usr/servers/$SERVER_NAME

  # Delete old symlinks
  rm /opt/ol/links/output
  rm /opt/ol/links/config

  # Add new output folder symlink and resolve group write permissions
  SERVER_OUTPUT_DIR=$WLP_OUTPUT_DIR/$SERVER_NAME
  ORIGINAL_SERVER_OUTPUT_DIR=$ORIGINAL_WLP_OUTPUT_DIR/$ORIGINAL_SERVER_NAME
  mkdir -p $SERVER_OUTPUT_DIR
  ln -s $SERVER_OUTPUT_DIR $OPT_PREFIX/links/output

  # Copy old /output folder contents
  cp -r $ORIGINAL_SERVER_OUTPUT_DIR/. $SERVER_OUTPUT_DIR/ 2>/dev/null
  rm -rf $ORIGINAL_SERVER_OUTPUT_DIR
  chmod -R g+rw $SERVER_OUTPUT_DIR
  setfacl -R -dm g:root:rw $SERVER_OUTPUT_DIR

  # Add new server symlink and copy over old /config folder contents
  cp -r $OPT_PREFIX/wlp/usr/servers/$ORIGINAL_SERVER_NAME/. $OPT_PREFIX/wlp/usr/servers/$SERVER_NAME/ 2>/dev/null
  ln -s $OPT_PREFIX/wlp/usr/servers/$SERVER_NAME $OPT_PREFIX/links/config
  mkdir -p /config/configDropins/defaults
  mkdir -p /config/configDropins/overrides
  if $IS_KERNEL; then
    mkdir -p /config/dropins
    mkdir -p /config/apps
  fi
  chmod -R g+rw /config
  setfacl -R -dm g:root:rw /config
  rm -rf $OPT_PREFIX/wlp/usr/servers/$ORIGINAL_SERVER_NAME
fi

exit 0
