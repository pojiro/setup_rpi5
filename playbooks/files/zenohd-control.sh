#!/bin/bash
# zenohd control script
# Usage: zenohd-control.sh {start|stop}

set -e

show_help() {
  echo "Usage: $0 {start|stop}"
  echo "  start : Start zenohd daemon"
  echo "  stop  : Stop zenohd daemon"
}

# 引数がないときヘルプを表示
if [ $# -eq 0 ]; then
  show_help
  exit 1
fi

COMMAND=$1
PIDFILE=~/.zenohd.pid
LOGFILE=~/.zenohd.log

case $COMMAND in
  start)
    echo "Starting zenohd..."
    nohup zenohd > $LOGFILE 2>&1 &
    ZENOHD_PID=$!
    echo "zenohd started with PID: $ZENOHD_PID"
    echo $ZENOHD_PID > $PIDFILE
    echo "Log file: $LOGFILE"
    ;;
  stop)
    if [ -f $PIDFILE ]; then
      ZENOHD_PID=$(cat $PIDFILE)
      echo "Stopping zenohd (PID: $ZENOHD_PID)..."
      kill $ZENOHD_PID || true
      rm $PIDFILE
      echo "zenohd stopped"
    else
      echo "zenohd.pid not found"
      # fallback: kill any zenohd process
      pkill zenohd || true
      echo "Killed all zenohd processes"
    fi
    ;;
  *)
    show_help
    exit 1
    ;;
esac
