# -*- coding: utf8 -*-

import os
import sys

import third.file_util as file_util
import third.str_util  as str_util



def do_publish_ci():
        print "do_publish_ci() ..."
        if len(sys.argv) != 12:
                print "arguments error."
                return False
        try:
                ident = sys.argv[1]
                svn_revision_info = sys.argv[2]
                cfg_data_version = sys.argv[3]

                smserver_dir = sys.argv[4]

                game_alias = sys.argv[5]
                game_generation = int(sys.argv[6])

                ftp_host = sys.argv[7]
                ftp_port = int(sys.argv[8])
                ftp_user = sys.argv[9]
                ftp_password = sys.argv[10]
                ftp_path = sys.argv[11]
        except:
                traceback.print_exc()

                return False

        # 调试信息
        print "ident: %s" % (ident)
        print "svn_revision_info: %s" % (svn_revision_info)
        print "cfg_data_version: %s" % (cfg_data_version)
        print "smserver_dir: %s" % (smserver_dir)
        print "game_alias: %s" % (game_alias)
        print "game_generation: %d" % (game_generation)
        # print "ftp_host: %s" % (ftp_host)
        # print "ftp_port: %d" % (ftp_port)
        # print "ftp_user: %s" % (ftp_user)
        # print "ftp_password: %s" % (ftp_password)
        # print "ftp_path: %s" % (ftp_path)
        
        print "__file__: %s" % (__file__)

        cwd = os.getcwd()
        print "cwd: %s" % (cwd)
        

        pkg_name = build_pkg_name(game_alias, ident, game_generation, svn_revision_info)  # 形如：sm_game-alpha-1.0.7011-7220
        print "pkg_name: %s" % (pkg_name)

        tmp_pkg_dir = "%s/tmp/%s" % (cwd, pkg_name)

        #建立目录
        os.system("mkdir %s" % (tmp_pkg_dir,))
        
        if not do_work(smserver_dir, tmp_pkg_dir, ident):
                print "[publish_ci.py] do_work failed!"
                return False

        full_pkg_name = "%s.tar.gz" % (pkg_name)
        print "full_pkg_name: %s" % (full_pkg_name)

        #tar打包
        print "tar..."
        os.chdir("%s/tmp/" % (cwd))
        # os.system("tar -zcvf %s %s" % (full_pkg_name, pkg_name))
        os.system("tar -zcf %s %s" % (full_pkg_name, pkg_name))
        print "tar done"

        os.system("rm -rf %s" % (tmp_pkg_dir,))

        os.chdir(cwd)
        # ftp_upload(full_pkg_name, ftp_host, ftp_port, ftp_user, ftp_password, "./tmp/", ftp_path)

        # print "do_publish_ci() done! pkg name: %s" % (full_pkg_name)
        
        return True



def build_pkg_name(game_alias, ident, game_generation, svn_revision_info):
        return game_alias + "-" + ident + "-" + str(game_generation) + ".0." + svn_revision_info




def do_work(smserver_dir, tmp_pkg_dir, ident):
        saved_cwd =  os.getcwd()
        
        os.chdir(smserver_dir)

        print "do_work(), cwd after change: %s" % (os.getcwd())

        #清理beam文件
        os.system("rm -rf ./ebin/*")
        

        #编译
        os.chdir("./pack")
        if ident == "alpha":
                ret = os.system("sh make_ci.sh") >> 8
        else:
                ret = os.system("sh make_ci.sh -r") >> 8
        os.chdir("..")


        if ret == 1:
                print "make failed."
                os.system("rm -rf %s" % (tmp_pkg_dir))
                os.chdir(saved_cwd)  # 还原工作目录
                return False


        # os.system("mkdir %s/ebin" % (tmp_pkg_dir,))

        # 为了兼容在mac系统下打包，故手动创建对应的目录
        os.chdir(tmp_pkg_dir)
        os.system("mkdir ebin")
        os.system("mkdir app_cfg")
        os.system("mkdir sh")
        os.system("mkdir sql")

        os.chdir(smserver_dir)


        #导出到tmp目录
        print "copy ebin, app_cfg, sh, sql..."
        os.system("cp -R ./ebin/* %s/ebin/" % (tmp_pkg_dir,))
        os.system("cp -R ./app_cfg/* %s/app_cfg/" % (tmp_pkg_dir,))
        os.system("cp -R ./sh/* %s/sh/" % (tmp_pkg_dir,))
        ##os.system("cp -R ./sh/db/gtools/ %s/sh/db/" % (tmp_pkg_dir,))
        os.system("cp -R ./sql/* %s/sql/" % (tmp_pkg_dir,))
        print "copy ebin, app_cfg, sh, sql done"

        if ident != "alpha":
                server_config = "%s/app_cfg/server.config" % (tmp_pkg_dir,)

                content = file_util.read_file(server_config)

                content = str_util.str_repl("\{\s*can_use_gm_cmd,\s*\d+\s*\}", content, "{can_use_gm_cmd, 0}")
                content = str_util.str_repl("\{\s*sys_log_level,\s*\d+\s*\}", content, "{sys_log_level, 3}")
                #content = str_util.str_repl("\{\s*min_play_ol_num,\s*\d+\s*\}", content, "{min_play_ol_num, 500}")
                #content = str_util.str_repl("\{\s*nor_play_ol_num,\s*\d+\s*\}", content, "{nor_play_ol_num, 1200}")
                #content = str_util.str_repl("\{\s*max_play_ol_num,\s*\d+\s*\}", content, "{max_play_ol_num, 2000}")
                #content = str_util.str_repl("\{\s*max_wait_ol_num,\s*\d+\s*\}", content, "{max_wait_ol_num, 1000}")
                content = str_util.str_repl("\{\s*check_heartbeat_timeout,\s*\d+\s*\}", content, "{check_heartbeat_timeout, 1}")
                #content = str_util.str_repl("\{\s*sasl_error_logger,\s*\w+\s*\}", content, "{sasl_error_logger, false}")
                content = str_util.str_repl("\{\s*check_admin_security,\s*\d+\s*\}", content, "{check_admin_security, 0}")

                file_util.write_file(server_config, content)

        #增加可执行权限
        os.system('echo "before chmod..."')
        os.system('echo "tmp_pkg_dir: %s"' % (tmp_pkg_dir))
        if os.path.exists("%s/sh/" % (tmp_pkg_dir)):
                os.system('echo "xxxx path exists"')
        else:
                os.system('echo "xxxx path NOT exists"')

        os.system("chmod a+x -R %s/sh/" % (tmp_pkg_dir,))


        # 还原工作目录
        os.chdir(saved_cwd)

        return True




def ftp_upload(file_name, ftp_host, ftp_port, ftp_user, ftp_password, local_path, ftp_path):
        Args = "%s %d %s %s %s %s %s" % (ftp_host, ftp_port, ftp_user, ftp_password, local_path, ftp_path, file_name)
        print "ftp upload args: %s" % (Args)
        os.system("sh ./do_ftp_upload.sh %s" % (Args))



        




if __name__ == "__main__":
        do_publish_ci()


