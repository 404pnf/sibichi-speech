module UpdateAispeech

  extend UpdateAispeech

  # ## 新域名或者ip地址
  # 不要删除双引号
  # 不要写 'http://'
  # 您只需要修改这一行
  NEW_HOST =  "192.168.23.105"
  # 只有在你需要修改所有例子html中的域名时
  # 才需要写old_url
  # 因为如果不写我不知道从前的值是什么
  OLD_URL = '10.12.7.41'

  # ## 修改IP
  # 假设需要修改的IP为192.168.0.1
  # vim /etc/sysconfig/network-scripts/ifcfg-eth0
  # 修改其中的IPADDR和GATEWAY为对应的IP和网关即可。
  # ## 需要开放的端口：
  # 80 web端口
  # 81 httpa端口，http接入方式需要
  # # 443、5080 rtmp接入需要

  # ## 暴露出来的额命令
  def update_all
    update_loadjs
    update_red5
    update_httpd
    #update_html
    restart_service
  end
  module_function :update_all

  # ## 此方法用来生成后面的方法
  def gen_update(file, old, newstr)
    File.write(file, File.read(file).sub(old, newstr))
  end

  # ## 静态资源裁切
  def update_loadjs
    load_core = "/var/www/vhosts/api.aispeech.com/aispeechapi-js/v2.0/load_core.js"
    loadjs_host = Regexp.compile '^aispeech.host =.+;$'
    loadjs_monitorUrl = Regexp.compile '^aispeech.monitorUrl =.+;$'
    loadjs_new_pattern = "http://#{NEW_HOST}"

    gen_update(load_core, loadjs_host, loadjs_new_pattern)
    gen_update(load_core, loadjs_monitorUrl, loadjs_new_pattern)

    Dir.chdir(File.dirname load_core) { system('git diff') }
  end

  # ## 修改red5的配置文件
  def update_red5
    red5_conf_file_path = "/opt/aispeech/red5-0.8/conf/red5-web.properties"
    red5_old_pattern = Regexp.compile '^audio.region=.+'
    red5_new_pattern = "audio.region=#{NEW_HOST}"

    gen_update(red5_conf_file_path, red5_old_pattern, red5_new_pattern )

    Dir.chdir(File.dirname red5_conf_file_path) {system('git diff') }
  end

  # ## 修改httpd的conf
  def update_httpd
    http_conf_file = "/etc/httpd/vhosts/api.aispeech.com"
    http_old_servername = Regexp.compile 'ServerName.+'
    http_old_serveralias = Regexp.compile 'ServerAlias.+'

    gen_update(http_conf_file, http_old_servername, "ServerName #{NEW_HOST}")
    gen_update(http_conf_file, http_old_serveralias, "ServerAlias #{NEW_HOST}")

    Dir.chdir(File.dirname http_conf_file) { system('git diff') }
  end

  # ## 修改html文件例子中的ip地址
  def update_html
     path = "/var/www/vhosts/api.aispeech.com/aispeechapi-js/v2.0/Examples"
     new_url = "#{NEW_HOST}"

     # 需要修改两个文件
     # aipanel_ensent.html:            apiUrl: "rtmp://10.12.7.41:443/v2.0/aistream",
     # aipanel_enword.html:

     # >> s.sub(/([^\d]+)\d+\.\d+\.\d+\.\d+(.+)/, '\1haha\2')
     # => "rtmp://haha:443/v2.0/a"

     File.write(
      "#{path}aipanel_ensent.html",
      File.read("#{path}aipanel_ensent.html").sub(/([^\d]+)\d+\.\d+\.\d+\.\d+(.+)/, '\1' + "#{NEW_HOST}" + '\2'))
     )

     File.write(
      "#{path}aipanel_enword.html",
      File.read("#{path}aipanel_enword.html").sub(/([^\d]+)\d+\.\d+\.\d+\.\d+(.+)/, '\1' + "#{NEW_HOST}" + '\2'))
     )

     #shell_cmd = "sed -i -e s/#{old_url}/#{new_url}/ *"
     #Dir.chdir(path) { shell_cmd }

     Dir.chdir(path) { system('git diff') }

  end

  # ## 重新启动服务
  def restart_service
    system('/etc/init.d/httpd restart')
    system('/etc/init.d/red5-0.8 restart')
  end

end
