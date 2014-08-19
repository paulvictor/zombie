#!/bin/zsh -i
cd /home/viktor/stuff/zombie
mkdir -pv log
mkdir -pv tmp/pids
PIDFILE=`pwd`/tmp/pids/production.pid
PID=`cat $PIDFILE`
if [ -f $PIDFILE ]
then
  if ps -p $PID | grep -q ruby
  then
    kill $PID
  fi
fi
