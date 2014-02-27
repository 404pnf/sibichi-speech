<VirtualHost *:80>
    ServerName s.2u4u.com.cn
    ServerAlias 129.0.0.54
    DocumentRoot /var/www/vhosts/test.aispeech.com
    RewriteEngine on

    #RewriteRule \.php$ - [F]
    RewriteRule ^/audio/(.*)$ /audio.php?name=$1 [QSA]
    RewriteRule ^/([^/]+/[0-9]+/.+[^/])$ /audio.php?name=$1 [L]

    <Directory /var/www/vhosts/test.aispeech.com/aispeechapi-js>
        Order deny,allow
 	allow from all 
	Options Indexes
        #FollowSymLinks MultiViews
    </Directory>
</VirtualHost>
