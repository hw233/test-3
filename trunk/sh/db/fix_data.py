# -*- coding: utf8 -*-

import os

import datetime
import time

import gtools.sql.compare as sql_cmp

import stat_data

#SERVER_IDS = (1, 2, 3, 4, 5, 6, 7, 8)

SERVER_IDS = (10004,10005,10006,10007,10008)

STAT_DAYS = ((2014,9,24), (2014,9,25))

if __name__ == "__main__":
        os.system("mkdir log")

        for server_id in SERVER_IDS:
                os.system("mkdir log/%d" % (server_id,))

                import pdb
                #pdb.set_trace()

                for day in STAT_DAYS:
                        year, month, day = day

                        next_day = time.localtime(time.mktime(datetime.datetime(year, month, day, 0, 0, 0).timetuple()) + 3600 * 24)
                        year2  = next_day[0]
                        month2 = next_day[1]
                        day2   = next_day[2]

                        data_file  = "data/data-%d-%d-%d_%d.sql" % (year,  month,  day,  server_id)
                        data_file2 = "data/data-%d-%d-%d_%d.sql" % (year2, month2, day2, server_id)

                        if not os.path.exists(data_file2):
                                continue

                        if not os.path.exists(data_file):
                                data_file = "../../sql/db.sql"

                        def data_updated(table, order_fields, kv_pairs):
                                if stat_data.USEFULL_FIELDS.has_key(table):
                                        if not os.path.exists("log/%d" % (server_id,)):
                                                os.system("mkdir log/%d" % (server_id,))

                                        fp = open("log/%d/db_ny_%s_%s_%04d%02d%02d.log" % (server_id, table, server_id, year, month, day), "a")

                                        line = ""

                                        for field in order_fields:
                                                line += "%s=" % (field,)

                                                value = kv_pairs[field]

                                                if type(value) == str:
                                                        line += "%s" % (value.replace('\n', ''),)
                                                else:
                                                        line += str(value)

                                                line += "`"

                                        line = line[0:-1] + "\n"

                                        fp.write(line)

                                        fp.close()

                        sql_cmp.mk_diff(data_file, data_file2, data_updated, tuple(stat_data.USEFULL_FIELDS.keys()))