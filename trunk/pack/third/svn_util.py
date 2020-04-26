# -*- coding: utf8 -*-
import os
import re

def get_version(generation, svn_dir, is_force_beta):
        cwd = os.getcwd()
        os.chdir(svn_dir)

        pipe = os.popen("svn info")
        content = pipe.read()
        pipe.close()

        url = re.findall("URL: .{1,200}", content)[0]
        url = url[5:len(url)]

        revision = re.findall("Last Changed Rev: \d{1,10}", content)[0]
        revision = revision[18:len(revision)]

        ident = ""

        if is_force_beta:
                print "ident is force change to beta!"
                ident = "beta"  # 强行矫正为beta
        else:
                if url.find("tags") == -1:  # 非tag
                        ident = "alpha"
                else:
                        ident = "beta"

        version = ident + "-%d.0.%s" % (generation, revision)

        os.chdir(cwd)

        return ident, version






# 一个旧的运行例子：

# content:
# Path: .
# URL: https://freeala.com/svn/__ZXYServer_/branches/android/trunk_b1.6
# Repository Root: https://freeala.com/svn/__ZXYServer_
# Repository UUID: 8f967edc-6a3e-2541-bda6-9794ac5227a4
# Revision: 7026
# Node Kind: directory
# Schedule: normal
# Last Changed Author: zhangweiqiang
# Last Changed Rev: 7011
# Last Changed Date: 2014-11-27 22:11:40 -0500 (Thu, 27 Nov 2014)


# url:
# https://freeala.com/svn/__ZXYServer_/branches/android/trunk_b1.6


# revision:
# 7011


# 返回的ident & version:
# alpha
# alpha-1.0.7011
