%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 2002-2009. All Rights Reserved.
%% 
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%% 
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%% 
%% %CopyrightEnd%
%%
-module(etop2_txt).
-author('siri@erix.ericsson.se').

%%-compile(export_all).
-export([init/1,stop/1]).
-export([do_update/3]).

-include("etop2.hrl").
-include("etop2_defs.hrl").

-import(etop2,[loadinfo/1,meminfo/2]).
-import(etop2_gui,[formatmfa/1,to_list/1]).

-define(PROCFORM,"~-15w~-20s~8w~8w~8w~8w ~-20s~n").

stop(Pid) -> Pid ! stop.

init(Config) ->
    loop(Config, 0).

loop(Config, CurrCount) ->
    Info = do_update(Config),
    receive 
	stop -> stopped;
	{dump,File} -> 
        case file:open(File,[write]) of
            {ok, Fd} ->
                do_update(Fd,Info,Config);
            _Other ->
                pass     
        end, 
        loop(Config, CurrCount); 
	{config,_,Config1} -> loop(Config1, CurrCount)
    after 
        Config#opts.intv -> 
            case CurrCount < Config#opts.repc of 
                true ->
                    loop(Config, CurrCount + 1);
                false ->
                    etop2:stop()
            end
    end.

do_update(Config) ->
    Io = 
    case file:open(Config#opts.outfile, [append]) of
        {ok, Fd} ->
            Fd;
        _Other ->
            standard_io
    end,

    Info = etop2:update(Config),
    do_update(Io,Info,Config).

do_update(Fd,Info,Config) ->
    {Cpu,NProcs,RQ,Clock} = loadinfo(Info),
    io:nl(Fd),
    writedoubleline(Fd),
    case Info#etop_info.memi of
	undefined ->
	    io:fwrite(Fd, " ~-72w~10s~n"
		      " Load:  cpu  ~8w~n"
		      "        procs~8w~n"
		      "        runq ~8w~n",
		      [Config#opts.node,Clock,
		       Cpu,NProcs,RQ]);
	Memi ->
	    [Tot,Procs,Atom,Bin,Code,Ets] = 
		meminfo(Memi, [total,processes,atom,binary,code,ets]),
	    io:fwrite(Fd, ?SYSFORM,
		      [Config#opts.node,Clock,
		       Cpu,Tot,Bin,
		       NProcs,Procs,Code,
		       RQ,Atom,Ets])
    end,
    io:nl(Fd),
    writepinfo_header(Fd),
    writesingleline(Fd),
    writepinfo(Fd,Info#etop_info.procinfo),
    writedoubleline(Fd),
    io:nl(Fd),
    Info.

writepinfo_header(Fd) ->
    io:fwrite(Fd,"Pid            Name or Initial Func    Time    Reds  Memory    MsgQ Current Function~n",[]).

writesingleline(Fd) ->
    io:fwrite(Fd,"----------------------------------------------------------------------------------------~n",[]).
writedoubleline(Fd) ->
    io:fwrite(Fd,"========================================================================================~n",[]).
 
writepinfo(Fd,[#etop_proc_info{pid=Pid,
			       mem=Mem,
			       reds=Reds,
			       name=Name,
			       runtime=Time,
			       cf=MFA,
			       mq=MQ}
	       |T]) ->
    io:fwrite(Fd,?PROCFORM,[Pid,to_list(Name),Time,Reds,Mem,MQ,formatmfa(MFA)]), 
    writepinfo(Fd,T);
writepinfo(_Fd,[]) ->
    ok.

