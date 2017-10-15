while :
do	
CPU_USAGE=` cat <(grep 'cpu ' /proc/stat) <(sleep 4 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf "%.0f\n", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}'`
MEM_TOT=`cat /proc/meminfo | grep MemTotal: | awk '{print $2}'`
MEM_USED=`cat /proc/meminfo | grep Active: | awk '{print $2}'`
MEM_USAGE=$[$MEM_USED * 100 / $MEM_TOT]
UPTIME=`uptime`
SISTEM=`uname -a`
echo "~-~-~"
echo "{\"CPU\":$CPU_USAGE,\"MEM\":$MEM_USAGE,\"UPTIME\":\"$UPTIME\",\"SISTEM\":\"$SISTEM\"}"
sleep 1
done
