#vim /etc/rc.local

clear
echo '即将修改apache配置文件'
echo '请修改 ServerName 到机器的ip地址'
sleep 5
clear
vim +2 /etc/httpd/vhosts/api.aispeech.com

echo '即将修改 red5 的配置文件'
echo '请修改 audio.region 的 ip 地址'
sleep 5
clear
vim +21 /opt/aispeech/red5-0.8/conf/red5-web.properties

echo '即将修改load_core.js文件'
echo ''
echo '将 aispeech.monitorUrl = "http://log.aispeech.com/sdk-monitor/sdklog";'
echo '中的log.aispeech.com 替换为 机器的ip'
echo ''
echo '将 aispeech.host = aispeech.host || "http://10.12.7.44/aispeechapi-js/" + aispeech.apiVersion;'
echo '中的 10.12.7.44 替换为 机器的ip'
sleep 10
clear
vim +46 /var/www/vhosts/api.aispeech.com/aispeechapi-js/v2.0/load_core.js

echo  '配置机器网卡'
sleep 3
vim /etc/sysconfig/network-scripts/ifcfg-eth0

echo  '配置机器dns'
vim /etc/resolv.conf

echo '重启修改后的服务啦'
echo '你的工作完成了 ：） '
sleep 3
/etc/init.d/httpd restart
/etc/iptables stop
/etc/init.d/red5-0.8 restart
echo 'bye'
sleep 2
clear
