# -*- coding: utf8 -*-

import os
import sys

import file_util
import svn_util
import scp_util

class CPackFlow:
        def __init__(self, file):
                self._str_work_dir = file_util.file_dir(file)

        def work(self, tmp_dir, ident):
                pass

        def pack(self):
                if len(sys.argv) != 5:
                        print "arguments error."

                        return False
                try:
                        alias = sys.argv[1]
                        generation = int(sys.argv[2])
                        upload_dir = sys.argv[3]
                        if sys.argv[4] == "force_beta":
                                is_force_beta = True   # 强行打beta包
                        else:
                                is_force_beta = False
                except:
                        traceback.print_exc()

                        return False
                        
                os.chdir(self._str_work_dir)
                os.chdir("..")

                #更新svn
                print "svn update."
                os.system("svn update")

                #获取版本号
                ident, version = svn_util.get_version(generation, ".", is_force_beta)

                if version is None:
                        print "get version fail."

                        return False

                tmp_dir = "%s/tmp/%s-%s" % (self._str_work_dir, alias, version)

                #建立目录
                os.system("mkdir %s" % (tmp_dir,))
                
                if not self.work(tmp_dir, ident):
                        return False

                tar_gz = "%s-%s.tar.gz" % (alias, version)

                #tar打包
                os.chdir("pack/tmp")
                os.system("tar -zcvf %s %s-%s" % (tar_gz, alias, version))
                os.system("rm -rf %s" % (tmp_dir,))

                #scp上传
                scp_util.upload(tar_gz, upload_dir)

                return True