#!/bin/sh

INTERFACE="wlp3s0"   # 根据你的接口修改
SCAN_CMD="iw dev $INTERFACE scan"
CONNECT_CMD="iw dev $INTERFACE connect"

# 检查是否 root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Use sudo execute this script" >&2
    exit 1
fi

# 检查接口是否存在
if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
    echo "Error: Interface $INTERFACE does not exist" >&2
    exit 1
fi

# 启用接口
ip link set "$INTERFACE" up

echo "正在扫描 WiFi 网络..."


# 扫描并提取 SSID（去重、排序、支持中文/Emoji）
SSIDS=$($SCAN_CMD | rg SSID:)

# 检查是否扫描到 SSID
if [ -z "$SSIDS" ]; then
    echo "错误：未扫描到任何 WiFi 网络，请检查天线或驱动"
    exit 1
fi

# 转为数组（dash 兼容）
set -- $SSIDS
SSIDS_ARRAY="$*"
COUNT=0
for ssid in $SSIDS_ARRAY; do
    COUNT=$((COUNT + 1))
    printf "%3d) %s\n" "$COUNT" "$ssid"
done

echo
printf "请输入要连接的 WiFi 编号 (1-%d): " "$COUNT"
read -r choice

# 验证输入
if ! [ "$choice" -ge 1 ] 2>/dev/null || [ "$choice" -gt "$COUNT" ]; then
    echo "错误：无效的选择" >&2
    exit 1
fi

# 提取选中的 SSID
SELECTED_SSID=""
i=1
for ssid in $SSIDS_ARRAY; do
    if [ "$i" -eq "$choice" ]; then
        SELECTED_SSID="$ssid"
        break
    fi
    i=$((i + 1))
done

echo "正在连接到 SSID: $SELECTED_SSID ..."

# 断开旧连接
$CONNECT_CMD "$SELECTED_SSID" > /dev/null 2>&1 || true

# 等待关联（最多 10 秒）
timeout=10
while [ $timeout -gt 0 ]; do
    if iw dev "$INTERFACE" link | grep -q "Connected to"; then
        echo "连接成功！"
        # 获取 IP
        echo "正在获取 IP 地址..."
        dhclient "$INTERFACE" > /dev/null 2>&1 &
        exit 0
    fi
    sleep 1
    timeout=$((timeout - 1))
done

echo "连接超时，尝试手动重连："
echo "   sudo iw dev $INTERFACE connect '$SELECTED_SSID'"
echo "   sudo dhclient $INTERFACE"
exit 1
