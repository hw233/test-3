# -*- coding: utf8 -*-

import os_util

def parse_remote(remote):
        tokens = remote.split("/")

        host, port = tokens[0].split(":")

        path = host + ":/" + "/".join(tokens[1:len(tokens)])

        return [port, path]

def download(remote_file, local_dir):
        port, path = parse_remote(remote_file)

        os_util.system("scp -P %s %s %s" % (port, path, local_dir))

def upload(local_file, remote_dir):
        port, path = parse_remote(remote_dir)
        
        os_util.system("scp -P %s %s %s" % (port, local_file, path))