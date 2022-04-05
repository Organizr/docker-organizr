#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [[ -e /config/www/organizr/cron.php ]]; then
  s6-setuidgid abc /usr/bin/php7 /config/www/organizr/cron.php
else
  echo "No cron file to run..."
fi
