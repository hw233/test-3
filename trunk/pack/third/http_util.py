# -*- coding: utf8 -*-

import traceback
import time
import socket
import urllib

ERR_OK          = 0
ERR_WARNING     = 1
ERR_CRITICAL    = 2
ERR_UNKNOWN     = 3

def check(check_url, warning_time, critical_time):
        global ERR_OK, ERR_WARNING, ERR_CRITICAL

        socket.setdefaulttimeout(critical_time)

        try:
                start_timestamp = int(time.time() * 1000)

                err_code = int(urllib.urlopen(check_url).read())

                use_time = (int(time.time() * 1000) - start_timestamp) / 1000.0

                if err_code == ERR_OK and \
                   use_time >= warning_time:
                        err_code = ERR_WARNING

                print "OK: to open '" + check_url + "' used " + str(use_time) + " seconds."
        except:
                err_code = ERR_CRITICAL

                print traceback.format_exc()

        return err_code