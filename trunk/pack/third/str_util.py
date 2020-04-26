# -*- coding: utf8 -*-

import re
import platform

def line_break_char():
        if platform.system() == "Windows":
                return "\r\n"
        else:
                return "\n"

def dir_split_char():
        if platform.system() == "Windows":
                return "\\"
        else:
                return "/"

#排除字符，字母或数字，或冒号
def is_exc_char(char):
        asiic = ord(char)

        return (asiic >= ord('0') and asiic <= ord('9')) or \
               (asiic >= ord('a') and asiic <= ord('z')) or \
               (asiic >= ord('A') and asiic <= ord('Z')) or \
               asiic == ord(':')

#正则表达式替换字符串
def str_repl(regex, string, des_str, bcount = 0):
        ou_string = string

        re_strings = re.findall(regex, ou_string)
        
        src_strs = []

        for re_string in re_strings:
                end_idx = -bcount

                if not end_idx:
                        end_idx = len(re_string)

                src_str = re_string[bcount:end_idx]

                if src_str in src_strs:
                        continue

                ou_string = ou_string.replace(src_str, des_str)

                src_strs.append(src_str)

        return ou_string

def str_wipe_break(string):
        string1 = string.replace("\r\n", "")
        return string1.replace("\n", "")

def str_wipe_space(string):
        string1 = string.replace(" ", "")
        return string1.replace("\t", "")

def str_wipe_border_space(string):
        length = len(string)

        first_idx = 0
        end_idx   = length

        for i in xrange(length):
                if string[i] != " " and string[i] != "\t":
                        first_idx = i

                        break

        for i in xrange(length):
                index = length - i - 1

                if string[index] != " " and string[index] != "\t":
                        end_idx = index + 1

                        break
                        
        return string[first_idx:end_idx]

def str_wipe_comments(string, flag="%"):
        start = string.find("%")

        if start == -1:
                return string

        return string[0:start]

def str_count_space(string):
        for i in xrange(len(string)):
                if string[i] != " ":
                        break

        return i

def str_combin_spaces(count):
        return "".join([" " for i in xrange(count)])