%%%-----------------------------------
%%% @Module  : ply_title
%%% @Author  : liuzhongzheng2012@gmail.com
%%% @Email   :
%%% @Created : 2014.7.25
%%% @Description: 称号(玩家进程)
%%%-----------------------------------

-module(ply_title).

-include("common.hrl").
-include("record.hrl").
-include("pt_13.hrl").
-include("title.hrl").
-include("ets_name.hrl").
-include("obj_info_code.hrl").
-include("diy.hrl").
-include("prompt_msg_code.hrl").

-export([
        get_titles/1,
		set_titles/1,
        get_graph_title/1,
        get_text_title/1,
        get_user_def_title/1,
        find_title/2,
        
        on_login/1,
        on_logout/1,
        add_title/2,
        add_title/3,
        add_user_def_title/3,
        del_title/2,
        del_expire_title/2,
        use_title/2,
        no_use_title/2,
        attr_bonus/1,
        attr_all_titles/1,
        total/1,
        get_diytitles/1,
        send_all_titles/1,
		delete_title_cache/1,
    display_title/2,
    no_display_title/2,
get_show_graph_title/1,
get_show_text_title/1,
    title_reset/2,
    title_start/3,
    test/0
	]).

-define(TITLE_TYPE_GRAPH, 1).
-define(TITLE_TYPE_TEXT, 2).
-define(TITLE_TYPE_USER_DEF, 3).
-define(SEC_PER_MIN, 60).

display_title(UID, TitleID) ->
    Titles = get_titles(UID),
    NewTitles = case data_title:get(TitleID) of
                    #data_title{type=?TITLE_TYPE_GRAPH} ->
                        Titles#titles{display_graph_title=TitleID};
                    #data_title{type=?TITLE_TYPE_TEXT} ->
                        Titles#titles{display_text_title=TitleID};
                    _ ->
                        ?WARNING_MSG("Not have title ~w", [TitleID]),
                        Titles
                end,
    set_titles(NewTitles),
    send_display_title(NewTitles).

no_display_title(UID, Title) ->
    Titles = get_titles(UID),
    NewTitles = do_no_display_title(Title, Titles),
    send_display_title(NewTitles).

do_no_display_title(TitleID, #titles{display_graph_title=TitleID}=Titles) ->
    Titles#titles{display_graph_title=0};
do_no_display_title(TitleID, #titles{display_text_title=TitleID}=Titles) ->
    Titles#titles{display_text_title=0};
do_no_display_title(_TitleID, Titles) ->
    Titles.

send_display_title(#titles{uid=UID,
    display_graph_title = GTitle,
    display_text_title = TTitle}) ->
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_DISPLAY_GRAPE_TITLE, GTitle}]), % AOI
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_DISPLAY_TEXT_TITLE, TTitle}]).

get_titles(UID) ->
    [Titles] = ets:lookup(?ETS_TITLE, UID),
    Titles.

set_titles(Titles) when is_record(Titles, titles) ->
    ets:insert(?ETS_TITLE, Titles).

get_graph_title(UID) ->
    (get_titles(UID))#titles.graph_title.

get_text_title(UID) ->
    (get_titles(UID))#titles.text_title.

get_show_graph_title(UID) ->
    (get_titles(UID))#titles.display_graph_title.

get_show_text_title(UID) ->
    (get_titles(UID))#titles.display_text_title.

get_user_def_title(UID) ->
    (get_titles(UID))#titles.user_def_title.

on_login(UID) ->
    Titles =
        case ets:lookup(?ETS_TITLE, UID) of
            [] ->
                db_load(UID);
            [T] ->
                T
        end,
    Titles1 = filter_expire(Titles),
    schedule_all_timeout(Titles1),
    ets:insert(?ETS_TITLE, Titles1).

filter_expire(#titles{all=All}=Titles) ->
    Now = util:unixtime(),
    F = fun(#title{expire=0}, T) -> T;
            (#title{id=TID, expire=Expire}, T) when Expire =< Now->
                do_del_title(TID, T);
            (_, T) -> T
        end,
    Titles1 = lists:foldl(F, Titles, All),
    Titles1.

schedule_all_timeout(#titles{uid=UID, all=All}) ->
    F = fun(T) -> schedule_one_timeout(UID, T) end,
    lists:foreach(F, All).

schedule_one_timeout(UID, #title{id=TitleID, expire=Expire}) when Expire > 0 ->
    Now = util:unixtime(),
    mod_ply_jobsch:add_mfa_schedule(UID, Expire - Now, {?MODULE, del_expire_title, [UID, TitleID]});
schedule_one_timeout(_, _) ->
    ok.

del_expire_title(UID, TitleID) ->
    Now = util:unixtime(),
    case find_title(UID, TitleID) of
        #title{expire=0} ->
            ok;
        #title{expire=Expire} when Expire =< Now ->
            del_title(UID, TitleID);
        _ ->
            ok
    end.


on_logout(UID) ->
    Titles = get_titles(UID),
    db_save(Titles),
    delete_title_cache(UID).

delete_title_cache(UID) ->
	ets:delete(?ETS_TITLE, UID).

find_title(UID, TitleID) ->
    #titles{all=All} = get_titles(UID),
    lists:keyfind(TitleID, #title.id, All).

%% 添加称号
add_title(UID, TitleID) ->
    add_title(UID, TitleID, util:unixtime()).

add_title(UID, TitleID, AddTime) ->
    Titles = get_titles(UID),
    Titles1 = do_add_title(TitleID, AddTime, Titles),
    set_titles(Titles1),
    use_title(UID, TitleID). % 要求获取后自动使用

%% AddTime是加Title的时间, 因为存在补发的情况
do_add_title(TitleID, AddTime, #titles{uid=UID, all=All}=Titles) ->
    case data_title:get(TitleID) of
        #data_title{valid_minute=VMin, type=Type}
                when Type =:= ?TITLE_TYPE_GRAPH
                orelse Type =:= ?TITLE_TYPE_TEXT ->
            VSec = VMin * ?SEC_PER_MIN,
            Expire = ?IF(VSec > 0, AddTime+VSec, 0),
            NewTitle = #title{id=TitleID, expire=Expire},
            schedule_one_timeout(UID, NewTitle),
            All2 = lists:keystore(TitleID, #title.id, All, NewTitle),
            Titles1 = case length(All) =:= 0 of
                          true ->
                              case Type =:= 1 of
                                  true ->
                                      Titles#titles{all=All2, display_graph_title = TitleID};
                                  false ->
                                      Titles#titles{all=All2, display_text_title = TitleID}
                              end;
                          false ->
                              Titles#titles{all=All2}
                      end,
            Titles1;
        _ ->
            ?WARNING_MSG("Cannot add title ~w", [TitleID]),
            Titles
    end.


%% 添加(或修改)玩家自定义称号
add_user_def_title(UID, TitleID, String) when is_binary(String)->
    Titles = get_titles(UID),
    Titles1 = do_add_user_def_title(TitleID, String, Titles),
    set_titles(Titles1),
    use_title(UID, TitleID).

do_add_user_def_title(TitleID, String, #titles{uid=UID, all=All, all_ud_titles=AllUD}=Titles) ->
    case data_title:get(TitleID) of
        #data_title{valid_minute=VMin, type=?TITLE_TYPE_USER_DEF} ->
            VSec = VMin * ?SEC_PER_MIN,
            Expire = ?IF(VSec > 0, util:unixtime()+VSec, 0),
            NewTitle = #title{id=TitleID, expire=Expire},
            schedule_one_timeout(UID, NewTitle),
            NewUD = {TitleID, String},
            All2 = lists:keystore(TitleID, #title.id, All, NewTitle),
            AllUD2 = lists:keystore(TitleID, 1, AllUD, NewUD),
            Titles1 = Titles#titles{all=All2, all_ud_titles=AllUD2},
            Titles1;
        _ ->
            ?WARNING_MSG("Cannot user define title ~w as ~p", [TitleID, String]),
            Titles
    end.


%% 删除称号
del_title(UID, TitleID) ->
    Titles = get_titles(UID),
    Titles1 = do_del_title(TitleID, Titles),
    set_titles(Titles1),
    no_use_title(UID, TitleID).


do_del_title(TitleID, #titles{all=All, all_ud_titles=AllUD}=Titles) ->
    All2 = lists:keydelete(TitleID, #title.id, All),
    AllUD2 = lists:keydelete(TitleID, 1, AllUD),
    Titles1 = Titles#titles{all=All2, all_ud_titles=AllUD2},
    Titles2 = do_no_use_title(TitleID, Titles1),
    Titles2.

%% 使用称号 ply_title:use_title(1000100000000759, 50000).
use_title(UID, TitleID) ->
    Titles = get_titles(UID),
    Titles1 = do_use_title(TitleID, Titles),
    send_using_title(Titles1),
    PS = player:get_PS(UID),
    mod_achievement:notify_achi(change_title, [{num, 1}], PS),
    ply_attr:recount_all_attrs(PS),
    set_titles(Titles1).

do_use_title(TitleID, #titles{all=All, all_ud_titles=AllUD}=Titles) ->
    Len = length(All),
    IsHave = lists:keyfind(TitleID, #title.id, All) =/= ?false,
    case TitleID < 200 of
        true ->
            Titles#titles{graph_title=TitleID};
        false ->
            case data_title:get(TitleID) of
                #data_title{type=?TITLE_TYPE_GRAPH} when IsHave ->
                    case Len =:= 0 of
                        true ->
                            Titles#titles{graph_title=TitleID, display_graph_title = TitleID};
                        false ->
                            Titles#titles{graph_title=TitleID}
                    end;
                #data_title{type=?TITLE_TYPE_TEXT} when IsHave ->
                    case Len =:= 0 of
                        true ->
                            Titles#titles{text_title=TitleID, display_text_title = TitleID, user_def_title= <<>>};
                        false ->
                            Titles#titles{text_title=TitleID, user_def_title= <<>>}
                    end;
                #data_title{type=?TITLE_TYPE_USER_DEF} when IsHave ->
                    {_, UDTitle} = lists:keyfind(TitleID, 1, AllUD),
                    case Len =:= 0 of
                        true ->
                            Titles#titles{text_title=TitleID, display_text_title = TitleID, user_def_title= UDTitle};
                        false ->
                            Titles#titles{text_title=TitleID, user_def_title= UDTitle}
                    end;
                _ ->
                    ?WARNING_MSG("Not have title ~w", [TitleID]),
                    Titles
            end
    end.

no_use_title(UID, TitleID) ->
    Titles = get_titles(UID),
    Titles1 = do_no_use_title(TitleID, Titles),
    send_using_title(Titles1),
    PS = player:get_PS(UID),
    ply_attr:recount_all_attrs(PS),
    set_titles(Titles1).

do_no_use_title(TitleID, #titles{graph_title=TitleID}=Titles) ->
    Titles#titles{graph_title=0};
do_no_use_title(TitleID, #titles{text_title=TitleID}=Titles) ->
    Titles#titles{text_title=0, user_def_title= <<>>};
do_no_use_title(_TitleID, Titles) ->
    Titles.

%% 需要增加的属性列表
attr_bonus(UID) ->
    #titles{text_title=TTitle, graph_title=GTitle} = get_titles(UID),
    F = fun(0) -> [];
            (T) -> (data_title:get(T))#data_title.add_attr
        end,
    F(TTitle) ++ F(GTitle).

%% 所有称谓增加的总属性   ply_title:get_titles(1010900000000363).
attr_all_titles(UID) ->
    #titles{all=All, graph_title = Gid, special_title = S} = get_titles(UID),
    A = case lists:keyfind(Gid, 1, S) of
            {_, At} ->
              Data = data_special_title:get(1),
              AttrList = Data#special_title.optional_attr_add,
              F = fun(X, Acc) ->
                    [lists:nth(X, AttrList)] ++  Acc
                  end,
              NewAttrList = lists:foldr(F, [], At),
              NewAttrList;
            false ->
                []
        end,
    AttrAllTitles = total(All) ++ attr_bonus(UID) ++ A,
    AttrAllTitles.

%% title id  expire ext   
total([{_,Graph,_,_}|T]) ->
    F = fun(0) -> [];
        (X) -> (data_title:get(X))#data_title.ava_attr
        end,
    F(Graph) ++ total(T);
total([]) -> [].

db_save(#titles{uid=UID}=Titles) ->
    db:kv_insert(title, UID, Titles).

db_load(UID) ->
    case db:kv_lookup(title, UID) of
        [] ->
            new_titles(UID);
        [Titles] ->
            Titles
    end.

new_titles(UID) ->
    #titles{
            uid=UID,
            all=[],
            graph_title=0,
            text_title=0,
            extend=[]
        }.

%% 获取定制称号
get_diytitles(UID) ->
    case ets:lookup(?ETS_DIY_TITLE, UID) of
        [] ->
            Sql = db:select_row(title, "diy_title", [{id, UID}]),
            DiyTile= case Sql of
                         [] -> [];
                         [R] ->
                             case util:bitstring_to_term(R) of
                                 undefined -> [];
                                 L -> L
                             end
                     end,
            ets:insert(?ETS_DIY_TITLE, #diy_title{uid = UID, titles = DiyTile}),
            DiyTile;
        [Ets] ->
            Ets#diy_title.titles
    end.

send_all_titles(UID) when is_integer(UID)->
    #titles{all=All, all_ud_titles=AllUD, special_title = St} = get_titles(UID),
    IDs = [{ID, Expire} || #title{id=ID, expire = Expire} <- All],
    F = fun({Tid, E}, Tcc) ->
            case lists:keyfind(Tid, 1, St) of
                {_, Al} ->
                    Tcc ++ [{Tid, E, Al}];
                false ->
                    Tcc ++ [{Tid, E, []}]
            end
        end,
    IDss = lists:foldr(F, [], IDs),
    DiyTitles = get_diytitles(UID),

    {ok, Bin} = pt_13:write(?PT_PLYR_ALL_TITLE, [IDss, AllUD, DiyTitles]),
    lib_send:send_to_uid(UID, Bin).

send_using_title(#titles{uid=UID,
                         graph_title=GTitle,
                         text_title=TTitle,
                         user_def_title=UDTitle,
                        display_graph_title = DGTitle,
                        display_text_title = DTTitle}) ->
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_CODE_TEXT_TITLE, GTitle}]), % AOI
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_CODE_GRAPH_TITLE, TTitle}]), % AOI
    lib_scene:notify_string_info_change_to_aoi(UID, [{?OI_CODE_UEER_DEF_TITLE, UDTitle}]),
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_DISPLAY_GRAPE_TITLE, DGTitle}]), % AOI
    lib_scene:notify_int_info_change_to_aoi(player, UID, [{?OI_DISPLAY_TEXT_TITLE, DTTitle}]).

title_reset(PS, No) ->
    UID = player:get_id(PS),
    case get_titles(UID) of
        #titles{uid = UID, special_title = St} = Titles ->
            case lists:keyfind(No, 1, St) of
                {No, NoList} ->
                    {GetGoods, GetNum} = (data_special_title:get(1))#special_title.cost1,
                    NeedCost = (data_special_title:get(1))#special_title.cost2,
                    case mod_inv:check_batch_destroy_goods(UID, [NeedCost])  of
                        ok ->
                            mod_inv:destroy_goods_WNC(UID, [NeedCost], ["1", "2"]),
                            mod_inv:batch_smart_add_new_goods(UID, [{GetGoods, GetNum*length(NoList)}], [{bind_state, 1}], ["1", "2"]),
                            NewSt = lists:keydelete(No, 1, St),
                            NewTitles = Titles#titles{special_title = NewSt},
                            set_titles(NewTitles),
                            ply_attr:recount_all_attrs(PS),
%%                            send_all_titles(UID),
                            ok;
                        {fail, Reason} ->
                            {fail, Reason}
                    end;
                false ->
                    {fail, ?PM_BEAUTY_CONTEST_RESET_ERROR_UNKNOWN}
            end;
        _ ->
            {fail, ?PM_UNKNOWN_ERR}
    end.

title_start(PS, Tid, Nolist) ->
    UID = player:get_id(PS),
    case get_titles(UID) of
        #titles{uid = UID, special_title = St, all = All} = Titles ->
            IDs = [ID || #title{id=ID} <- All],
            case lists:member(Tid, IDs) of
                true ->
                    Type = (data_title:get(Tid))#data_title.type,
                    case Type =:= 1 of
                        true ->
                            Len = length(Nolist),
                            Data = data_special_title:get(1),
                            Num = Data#special_title.custom_select,
                            {NeedCost, NeedNum} = Data#special_title.cost1,
                            case lists:keyfind(Tid, 1, St) of
                                {_, OldAttrList} ->
                                    case mod_inv:check_batch_destroy_goods(UID, [{NeedCost, NeedNum*Len}])  of
                                        ok ->
                                            mod_inv:destroy_goods_WNC(UID, [{NeedCost, NeedNum*Len}], ["1", "2"]),
                                            case (length(Nolist) + length(OldAttrList)) =< Num of
                                                true ->
                                                    NewAttrList = OldAttrList ++ Nolist,
                                                    NewSt = lists:keyreplace(Tid, 1, St, {Tid, NewAttrList}),
                                                    NewTitles = Titles#titles{special_title = NewSt},
                                                    set_titles(NewTitles),
                                                    ply_attr:recount_all_attrs(PS),
                                                    ok;
                                                false ->
                                                    {fail, ?PM_SWORN_NAME_LEN_ERROR}
                                            end;
                                        {fail, Reason} ->
                                            {fail, Reason}
                                    end;
                                false ->
                                    case mod_inv:check_batch_destroy_goods(UID, [{NeedCost, NeedNum*Len}])  of
                                        ok ->
                                            mod_inv:destroy_goods_WNC(UID, [{NeedCost, NeedNum*Len}], ["1", "2"]),
                                            case length(Nolist) =< Num of
                                                true ->
                                                    NewAttrList = Nolist,
                                                    NewSt = [{Tid, NewAttrList}|St],
                                                    NewTitles = Titles#titles{special_title = NewSt},
                                                    set_titles(NewTitles),
                                                    ply_attr:recount_all_attrs(PS),
                                                    ok;
                                                false ->
                                                    {fail, ?PM_SWORN_NAME_LEN_ERROR}
                                            end;
                                        {fail, Reason} ->
                                            {fail, Reason}
                                    end
                            end;
                        false ->
                            {fail, ?PM_CLI_MSG_ILLEGAL}
                    end;
                false ->
                    {fail, ?PM_CLI_MSG_ILLEGAL}
            end;
        _ ->
            {fail, ?PM_UNKNOWN_ERR}
    end.

test() ->
    Id = 1000100000000008,
    PS = player:get_PS(Id),
    Tid = 1001,
    Nolist = [1,2,3],
%%    T = get_titles(Id),
    title_reset(PS, 1001),
%%    io:format("sdasdad====~p~n",[T#titles.special_title]),
%%    title_start(PS, Tid, Nolist),
    skip.