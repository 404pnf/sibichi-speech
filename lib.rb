module UpdateAispeech

  # ## 新域名或者ip地址
  # 不要删除双引号
  # 不要写 'http://'
  # 您只需要修改这一行
  new_host =  "192.168.23.105"
  # 只有在你需要修改所有例子html中的域名时
  # 才需要写old_url
  # 因为如果不写我不知道从前的值是什么
  old_url = '10.12.7.41'

  # ## 修改IP
  # 假设需要修改的IP为192.168.0.1
  # vim /etc/sysconfig/network-scripts/ifcfg-eth0
  # 修改其中的IPADDR和GATEWAY为对应的IP和网关即可。
  # ## 需要开放的端口：
  # 80 web端口
  # 81 httpa端口，http接入方式需要
  # # 443、5080 rtmp接入需要

  # ## 此方法用来生成后面的方法
  def gen_update(file, old, new)
    File.write(file, File.read(file).sub(old, new))
  end

  # ## 静态资源裁切
  def update_loadjs
    load_core = "/var/www/vhosts/api.aispeech.com/aispeechapi-js/v2.0/load_core.js"
    loadjs_host = Regexp.compile '^aispeech.host =.+;$'
    loadjs_monitorUrl = Regexp.compile '^aispeech.monitorUrl =.+;$'
    loadjs_new_pattern = "http://#{new_host}"

    gen_update(load_core, loadjs_host, loadjs_new_pattern)
    gen_update(load_core, loadjs_host, loadjs_new_pattern)

    Dir.chdir(File.dirname load_core) { git diff }
  end


  # ## 修改red5的配置文件
  def update_red5
    red5_conf_file_path = "/opt/aispeech/red5-0.8/conf/red5-web.properties"
    red5_old_pattern = Regexp.compile '^audio.region=.+'
    red5_new_pattern = "audio.region=#{new_host}"

    gen_update(red5_conf_file_path, red5_old_pattern, red5_new_pattern )

    Dir.chdir(File.dirname red5_conf_file_path) { git diff }
  end

  # ## 修改httpd的conf
  def update_httpd
    http_conf_file = "/etc/httpd/vhosts/api.aispeech.com"
    http_old_servername = Regexp.compile 'ServerName.+'
    http_old_serveralias = Regexp.compile 'ServerAlias.+'
    http_new_server = "#{new_host}"

    gen_update(http_conf_file, http_old_servername, http_new_server)
    gen_update(http_old_serveralias, http_old_servername, http_new_server)

    Dir.chdir(File.dirname http_conf_file) { git diff }
  end

  # ## 修改html文件例子中的ip地址
  def update_html
     path = "/var/www/vhosts/test.aispeech.com/aispeechapi-js/v2.0/Examples"
     new_url = "#{new_host}"
     shell_cmd = "sed -i -e s/#{old_url}/#{new_url}/ *"

     Dir.chdir(path) { shell_cmd }

     Dir.chdir(path) { git diff }

  end

  # ## 重新启动服务
  def restart_service
    system('/etc/init.d/httpd restart')
    system('/etc/init.d/red5-0.8 restart')
  end

  # ## 暴露出来的额命令
  def update_all
    update_loadjs
    update_red5
    update_httpd
    #update_html
    restart_service
  end

end
