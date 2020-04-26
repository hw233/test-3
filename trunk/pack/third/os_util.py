# -*- coding: utf8 -*-

import os

def system(command):
        if not os.system(command):       
                return

        raise Exception("SystemError: %s" % (command,))
