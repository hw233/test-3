# -*- coding: utf8 -*-

import os
import traceback

import py_compile

import file_util

def compile_all(dir):
        success = True

        pys  = []

        for root, dirs, files in os.walk(dir):
                for filename in files:
                        full_path = root + "/" + filename

                        if os.path.isfile(full_path):
                                filename_lst = filename.split(".")

                                if len(filename_lst) != 2 or \
                                   filename_lst[-1] != "py":
                                        continue

                                file_lines = file_util.read_file_lines(full_path)

                                if len(file_lines) > 0 and file_lines[0].find("#!/usr/bin/python") != -1:
                                        continue

                                try:
                                        py_compile.compile(full_path)
                                except:
                                        success = False

                                        traceback.print_exc()

                                        break
                                        
                                pys.append(full_path)

        if success:
                for py in pys:
                        os.system("rm %s" % (py,))

        return success