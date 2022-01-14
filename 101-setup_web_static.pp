# update packages
exec { 'apt-get-update':
  command  => 'sudo apt-get -y update',
  provider => shell,
}

# install nginx
exec {'install nginx':
  command  => 'sudo apt-get -y install nginx',
  provider => shell,
}

# allow HTTP in Nginx
# exec {'allow HTTP':
#  command  => "sudo ufw allow 'Nginx HTTP'",
#  provider => shell,
# }

# create the path /data/web_static/releases/test/
exec {'mkdir /test':
  command  => 'sudo mkdir -p /data/web_static/releases/test/',
  provider => shell,
}

# create the path /data/web_static/shared/
exec {'mkdir /shared':
  command  => 'sudo mkdir -p /data/web_static/shared/',
  provider => shell,
}

# create test inex file with temporary content
exec {'create index.html':
  command  => 'echo "Set by puppet manifest of task 5 from project 0X03 AirBnB" > /data/web_static/releases/test/index.html',
  provider => shell,
}

# change owner of folder /date recursively
exec {'chown-data':
  command  => 'sudo chown -R ubuntu:ubuntu /data/',
  provider => shell,
}

# link /current to /test
exec {'link /current ot /test':
  command  => 'sudo ln -sf /data/web_static/releases/test/ /data/web_static/current',
  provider => shell,
}

# add /hbnb_static location to nginx config
exec {'add new location /hbnb_static':
  command  => 'echo "'server {
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
}'" > /etc/nginx/sites-enabled/default',
  provider => shell,
}

# restart Nginx service
exec {'restart nginx':
  command  => 'sudo service nginx restart',
  provider => shell,
}