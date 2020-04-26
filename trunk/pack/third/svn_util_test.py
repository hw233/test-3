# -*- coding: utf8 -*-

import svn_util



def test_get_version(generation, svn_dir, is_force_beta):
        ident, version = svn_util.get_version(generation, svn_dir, is_force_beta)
        print ident
        print version



generation = 1
svn_dir = "../.."
is_force_beta = False

test_get_version(generation, svn_dir, is_force_beta)


