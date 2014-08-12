#!/bin/zsh
#!/bin/zsh
cd stuff/zombie
mkdir -pv log
mkdir -pv tmp/pids
PIDFILE=`pwd`/tmp/pids/production.pid
[ -f $PIDFILE ] && [ `ps -p $(cat $PIDFILE)  | grep -q rackup` ] && kill `cat $PIDFILE`
