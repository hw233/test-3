-module(pt_31).
-compile(export_all).
-include("common.hrl").
-include("activity.hrl").

read(31001, _) ->
    {ok, []};

read(31002, _) ->
    {ok, []};

read(31003, <<No:32, Index:8>>) ->
    {ok, [No, Index]};

read(31004, <<Index:8, Qu:32>>) ->
    {ok, [Index, Qu]};

read(31007, <<No:16, Type:8>>) ->
    {ok, [No, Type]};

read(31050, _) ->
    {ok, []};

read(31051, <<Id:32>>) -> 
    {ok, [Id]};

read(31060, _) ->
    {ok, []};

read(31061, <<Id:32>>) -> 
    {ok, [Id]};

read(31063, <<Id:32, Value:32>>) ->
    {ok, [Id, Value]};

read(31070, _) ->
    {ok, []};

read(31071, Bin) -> 
    {Data, _} = pt:read_array(Bin, [u32, u32]),
    {ok, [Data]};

% 获取抽奖面板信息
read(31100, <<>>) ->
    {ok, []};

% 抽奖
read(31101, <<CostType:8>>) ->
    {ok, [CostType]};

% 重置抽奖面板
read(31102, <<>>) ->
    {ok, []};


% 竞猜题目数据
read(31201, <<>>) ->
    {ok, []};

% 竞猜题目
read(31202, <<Id:32, Option:8, Rmb:32, Cup:32>>) ->
    {ok, [Id, Option, Rmb, Cup]};


read(_CMD, _) ->
    ?ASSERT(false, [_CMD]),
    no_match.


write(31001, [State]) ->
    {ok, pt:pack(31001, <<State:8>>)};

write(31002, [State, CurIndex, MaxIndex, Correct, EndTime, HisCorrect, Literary, Exp, CurQu, RewList, AcepackList, TotalLiterary]) ->
    RewLength = erlang:length(RewList),
    AcePackLength = erlang:length(AcepackList),
    RewBin = tool:to_binary([<<No:16, Type:8, RwState:8>> || {No, Type, RwState} <- RewList]),
    AceBin = tool:to_binary([<<AceIndex:8, Left:8, UseQu:32>> || {AceIndex, Left, UseQu} <- AcepackList]),
    {ok, pt:pack(31002, <<State:8, CurIndex:16, MaxIndex:16, Correct:16, 
        EndTime:32, HisCorrect:32, Literary:32, Exp:32, CurQu:32, RewLength:16, RewBin/binary, AcePackLength:16, AceBin/binary, TotalLiterary:32>>)};

write(31003, [CurIndex, Literary, Exp, Qu, IsGet]) ->
    {ok, pt:pack(31003, <<CurIndex:16, Literary:32, Exp:32, Qu:32, IsGet:8>>)};

write(31004, [Index, Qu, State]) ->
    {ok, pt:pack(31004, <<Index:8, Qu:32, State:8>>)};

write(31005, [IsGet,List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<No:16, Type:8>> || {No, Type} <- List]),
    {ok, pt:pack(31005, <<IsGet:8, Len:16, Bin/binary>>)};

write(31006, [Qu, List]) ->
    Len = erlang:length(List),
    Bin = tool:to_binary([<<Index:8>> || Index <- List]),
    {ok, pt:pack(31006, <<Qu:32, Len:16, Bin/binary>>)};

write(31007, [Index, State, Type]) ->
    {ok, pt:pack(31007, <<Index:16, State:8, Type:8>>)};


write(31050, [List]) -> 
    Len = erlang:length(List),
    Bin = << <<Id:32>> || Id <- List >>,
    {ok, pt:pack(31050, <<Len:16, Bin/binary>>)};

write(31051, [Id, StartTime, EndTime, Content]) -> 
    Len = byte_size(Content),
    {ok, pt:pack(31051, <<Id:32, StartTime:32, EndTime:32, Len:16, Content/binary>>)};

write(31060, [List]) -> 
    Len = erlang:length(List),
    Bin = << <<Id:32>> || Id <- List >>,
    {ok, pt:pack(31060, <<Len:16, Bin/binary>>)};

write(31061, [Id, Content]) ->
    Len = byte_size(Content),
    {ok, pt:pack(31061, <<Id:32, Len:16, Content/binary>>)};


write(31061, [Id, Content, RewardDatas]) ->% RewardDatas --> [{Args1,Args2,State,[{GoodsNo,Num}]}]
  Len = erlang:byte_size(Content),
  Len2 = erlang:length(RewardDatas),
  BinTail =
    lists:foldl(fun({Args1, Args2, GoodsList}, BinAcc) ->
      BinAcc2 = <<Args1:32, Args2:32>>,
      Len3 = erlang:length(GoodsList),
      BinAcc3 = lists:foldl(fun({GoodsNo, Num, Minimum }, BinInsideAcc) ->
        <<BinInsideAcc/binary, GoodsNo:32, Num:32, Minimum:32>>;
        ({GoodsNo, _IsBind, Num, Minimum}, BinInsideAcc) ->
          <<BinInsideAcc/binary, GoodsNo:32, Num:32,Minimum:32>>
                            end, <<Len3:16>>, GoodsList),
      <<BinAcc/binary,BinAcc2/binary,BinAcc3/binary>>
                end, <<Len2:16>>, RewardDatas),
  {ok, pt:pack(31061, <<Id:32, Len:16, Content/binary, BinTail/binary>>)};

write(31062, [Id, Type]) ->
    {ok, pt:pack(31062, <<Id:32, Type:8>>)};

write(31063, [Id, Value]) ->
    {ok, pt:pack(31063, <<Id:32, Value:32>>)};

write(31064, [IdValues]) ->
    Len = erlang:length(IdValues),
    BinData =
        lists:foldl(fun({Id, Value, RewardYet}, Acc) ->
            LenYet = erlang:length(RewardYet),
            Acc2 = <<Id:32, Value:32>>,
%% 							Acc3 = <<LenYet:16, (<< <<Arg:32>> || Arg <- RewardYet>>)/binary>>,
            Acc3 = lists:foldl(fun({Arg, _}, AccTemp) ->
                <<AccTemp/binary, Arg:32>>;
                (Arg, AccTemp) ->
                    <<AccTemp/binary, Arg:32>>
                               end, <<LenYet:16>>, RewardYet),
            <<Acc/binary, Acc2/binary, Acc3/binary>>
                    end, <<Len:16>>, IdValues),
    {ok, pt:pack(31064, BinData)};

write(31070, [DataList]) ->
    Len = erlang:length(DataList),
    {ok, pt:pack(31070, <<Len:16, (<< <<OrderId:32, No:32>> || {OrderId, No} <- DataList>>)/binary>>)};

write(31071, [DataList]) ->
    Len = erlang:length(DataList),
    {ok, pt:pack(31071, <<Len:16, (<< <<OrderId:32, No:32, (byte_size(Content)):16, Content/binary >> || {OrderId, No, Content} <- DataList>>)/binary>>)};

write(31072, [OrderId, No, State]) ->
    {ok, pt:pack(31072, <<OrderId:32, No:32, State:8>>)};

% 获取抽奖面板信息
write(31100, [Time1, Time2, Array1, Array2]) ->
    Len1 = length(Array1),
    Len2 = length(Array2),
    {ok, pt:pack(31100, <<Time1:32
                         ,Time2:32
                         ,Len1:16, (<< <<No:8,Gid:32,Num:32,Quality:8,Bind:8,GetFlag:8>> || {No,Gid,Num,Quality,Bind,GetFlag} <- Array1>>)/binary
                         ,Len2:16, (<< <<(byte_size(Name)):16, Name/binary, GoodsNo:32, Quality:8, Num:32>> || {Name, GoodsNo, Quality, Num} <- Array2>>)/binary
                         >>
                     )};

% 抽奖
write(31101, [Code, No]) ->
    {ok, pt:pack(31101, <<Code:8, No:8>>)};

% 重置抽奖面板
write(31102, [Code]) ->
    {ok, pt:pack(31102, <<Code:8>>)};

%	array(
%    		id    			u32  		题目ID
%    		title  			string  	标题
%			content			string		内容
%			time_bet_begin	u32			投注开始时间
%			time_end_begin	u32			投注结束时间
%			time_show_begin	u32			展示开始时间
%			time_end_begin	u32			展示结束时间
%		 array(
%				option		u8			选项
%				data		string		选项内容
%			   )
%		)
write(31201, [List]) ->
	Len = length(List),
	Acc0 = <<Len:16>>,
	Bin = 
		lists:foldl(fun(Gq, Acc) ->
							Id = Gq#guess_question.id,
							Title = Gq#guess_question.title,
							Content = Gq#guess_question.content,
							TimeBetBegin = Gq#guess_question.time_bet_begin,
							TimeBetEnd = Gq#guess_question.time_bet_end,
							TimeShowBegin = Gq#guess_question.time_show_begin,
							TimeShowEnd = Gq#guess_question.time_show_end,
							Options = Gq#guess_question.options,
							Acc2 = <<Id:32,(byte_size(Title)):16,Title/binary,(byte_size(Content)):16,Content/binary,TimeBetBegin:32,TimeBetEnd:32,TimeShowBegin:32,TimeShowEnd:32,(length(Options)):16>>,
							lists:foldl(fun({Option, Value}, AccIn) ->
												AccIn2 = <<Option:8, (byte_size(Value)):16, Value/binary>>,
												<<AccIn/binary, AccIn2/binary>>
										end, <<Acc/binary, Acc2/binary>>, Options)
					end, Acc0, List),
	{ok, pt:pack(31201, Bin)};


% 请求竞猜题目动态数据
% 协议号：31202
% C >> S:
%			id				u32			题目ID	
%			option			u8			选项(为0的时候只是请求动态数据，非0就是确认竞猜选项)		
%			rmb				u32			投入水玉数量
%			cup				u32			投入奖杯数量

% S >> C:
%    		id    			u32  		题目ID
%    		option 			u8			我的猜选 0为未猜选
%			rmb				u32			投入水玉数量
%			cup				u32			投入奖杯数量
%			sum_rmb			u32			水玉奖池数量
%			sum_cup			u32			奖杯奖池数量
write(31202, [Id, Option, Rmb, Cup, TotalRmb, TotalCup]) ->
    {ok, pt:pack(31202, <<Id:32, Option:8, Rmb:32, Cup:32, TotalRmb:32, TotalCup:32>>)};

write(31203, [Gq]) ->
	Id = Gq#guess_question.id,
	Title = Gq#guess_question.title,
	Content = Gq#guess_question.content,
	TimeBetBegin = Gq#guess_question.time_bet_begin,
	TimeBetEnd = Gq#guess_question.time_bet_end,
	TimeShowBegin = Gq#guess_question.time_show_begin,
	TimeShowEnd = Gq#guess_question.time_show_end,
	Options = Gq#guess_question.options,
	Bin = <<Id:32,(byte_size(Title)):16,Title/binary,(byte_size(Content)):16,Content/binary,TimeBetBegin:32,TimeBetEnd:32,TimeShowBegin:32,TimeShowEnd:32,(length(Options)):16>>,
	BinData = 
		lists:foldl(fun({Option, Value}, AccIn) ->
							AccIn2 = <<Option:8, (byte_size(Value)):16, Value/binary>>,
							<<AccIn/binary, AccIn2/binary>>
					end, Bin, Options),
	{ok, pt:pack(31203, BinData)};

write(31204, [Id]) ->
	{ok, pt:pack(31204, <<Id:32>>)};


write(_CMD, _) ->
    ?ASSERT(false, _CMD),
    no_match.
