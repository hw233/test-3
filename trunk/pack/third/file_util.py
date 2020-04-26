# -*- coding: utf8 -*-
import os

import str_util

def read_file(filename):
        try:
                fp = open(filename, "r")
        except:
                return ""

        content = "".join(fp.readlines()) 
        fp.close()

        return content

def read_file_lines(filename):
        try:
                fp = open(filename, "r")
        except:
                return []

        lines = fp.readlines() 
        fp.close()
        
        lines2 = []

        for line in lines:
                lines2.append(str_util.str_wipe_break(line))
                
        return lines2

def write_file(filename, content):
        fp = open(filename, "w")
        fp.write(content)
        fp.close()

def file_dir(filename):
        return "/".join(os.path.abspath(filename).split("/")[0:-1])
