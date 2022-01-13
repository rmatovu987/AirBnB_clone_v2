#!/usr/bin/python3
""" do_pack function """

import os
from datetime import datetime

from fabric.api import env, put, run

env.hosts = ["35.231.223.136", "3.226.72.197"]

def do_deploy(archive_path):
    """ Distributes an archive to your web servers. """

    if not os.path.exists(archive_path):
        return False

    path = "/data/web_static/releases/"
    name = archive_path.split('.')[0].split('/')[1]
    dest = path + name

    try:
        put(archive_path, '/tmp')
        run('mkdir -p {}'.format(dest))

        run('tar -xzf /tmp/{}.tgz -C {}'.format(name, dest))
        run('rm -f /tmp/{}.tgz'.format(name))
        run('mv {}/web_static/* {}/'.format(dest, dest))
        run('rm -rf {}/web_static'.format(dest))
        run('rm -rf /data/web_static/current')
        run('ln -s {} /data/web_static/current'.format(dest))

        return True

    except Exception:
        return False

