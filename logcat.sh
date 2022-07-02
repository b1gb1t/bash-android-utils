function logcat() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: logcat <keyword>"
        return
    fi
    local info=$(frida-ps -H 127.0.0.1:1337 | grep -i $1)
    local app=${info##* }
    local pid=${info%% *}
    echo "PID: $pid"
    echo "APP: $app"
	echo "-----------"
    adb logcat --pid=$pid

}
