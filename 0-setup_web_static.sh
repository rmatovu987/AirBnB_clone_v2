#!/usr/bin/env bash
#bash script that sets up web servers for deployment of web static
sudo apt-get update
sudo apt-get -y install nginx
ufw allow 'Nginx HTTP'
sudo mkdir -p /data/web_static/releases/test
sudo mkdir -p /data/web_static/shared
body=\
"
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>
"
echo "$body" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data/
server_config=\
"server {
	listen 80 default_server;
	listen [::]:80 default_server;	
	server_name _;
	location / {
		root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
	}
    location /hbnb_static/ {
		alias /data/web_static/current/;
        index index.htm index.html;
        autoindex off;
	}
	error_page 404 /404.html;
	location = /404.html {
        root /var/www/html;
		internal;
	}
}"

echo "$server_config" > /etc/nginx/sites-enabled/default
sudo service nginx restart