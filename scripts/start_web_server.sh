#!/bin/zsh -i
cd /home/viktor/stuff/zombie
mkdir -pv log
mkdir -pv tmp/pids
PIDFILE=`pwd`/tmp/pids/production.pid
RUNCMD="bootup_rackup"
if [ -f $PIDFILE ]
then
  if [ `ps -p $(cat $PIDFILE)  | grep -q rackup` ]
  then
    echo "Rack already running"
  else
    $RUNCMD -E production -D -P $PIDFILE -p 8000 config.ru
  fi
else
  $RUNCMD -E production -D -P $PIDFILE -p 8000 config.ru
fi
