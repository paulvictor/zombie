#!/bin/zsh
cd stuff/zombie
mkdir -pv log
mkdir -pv tmp/pids
PIDFILE=`pwd`/tmp/pids/production.pid
RUNCMD="bootup_rackup -E production -D -P $PIDFILE -p 8000 config.ru"
if [ -f $PIDFILE ]
then
  if [ `ps -p $(cat $PIDFILE)  | grep -q rackup` ]
  then
    echo "Rack already running"
  else
    $RUNCMD
  fi
else
  $RUNCMD
fi
