#vim /etc/rc.local

# 修改apache配置文件
# 修改 ServerName
vim +2 /etc/httpd/vhosts/api.aispeech.com

# 修改 audio.region 的ip
vim +21 /opt/aispeech/red5-0.8/conf/red5-web.properties

# 修改aispeech.monnitorUrl 和 aispeech.host 的地址
#  46     aispeech.monitorUrl = "http://log.aispeech.com/sdk-monitor/sdklog";
#  47     aispeech.apiVersion = "v2.0";
#  48     aispeech.host = aispeech.host || "http://10.12.7.44/aispeechapi-js/" + ai    speech.apiVersion;
# 将 log.aispeech.com 替换为 机器的ip
# 将 10.12.7.44 替换为 机器的ip

vim +46 /var/www/vhosts/api.aispeech.com/aispeechapi-js/v2.0/load_core.js

# 配置机器网卡
vim /etc/sysconfig/network-scripts/ifcfg-eth0
# 配置机器dns
vim /etc/resolv.conf

# 重启修改后的服务
/etc/init.d/httpd restart
/etc/iptables stop
/etc/init.d/red5-0.8 restart
