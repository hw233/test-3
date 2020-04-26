%% Author: Administrator
%% Created: 2011-11-28
%% Description: TODO: Add description to name
-module(tst_name).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([
		 random_name/0,
		 rand/2,
		 test/1
		 ]).

%%
%% API Functions
%%

test(1)->
	Leng = [length(get_familyname(D)) || D<-lists:seq(1,6)],
	io:format("Leng:~p~n",[Leng]);
test(2)->
	io:format("test:~p~n",[?LINE]);
test(3)->
	L = "神马",
	{lists:nthtail(2, L) == "马",
	 lists:nthtail(3, L) == "马",
	 L -- lists:nthtail(3, L) == "神"
	 };
test(4)->
	L = "abc",
	A = lists:nth(1, L),
%% 	{[  B||B<- lists:seq(1, 10000),A == B], A},
	{A == 97,A =:= 97};
test(5)->
	io:format("test5~n"),
	L = [ {rand(1,5),B} || B<-lists:seq(1,30000) ],
	{length([ 1|| {A1,_}<-L,A1==1]),
	 length([ 1|| {A1,_}<-L,A1==2]),
	 length([ 1|| {A1,_}<-L,A1==3]),
	 length([ 1|| {A1,_}<-L,A1==4]),
	 length([ 1|| {A1,_}<-L,A1==5])};
test(6)->
	{length("慕容坐坐目"),length("慕容坐坐目里"),length("慕容坐坐目123"),length("慕容坐坐12")}.
	

random_name() ->
	random_familyname() ++ random_firstname().

random_familyname()->
    R = rand(1,1056),
	io:format("R:++++++++++~p~n",[R]),
	[Group] = [ G || G<-lists:seq(1,6),R/180 =< G, R/180 > G - 1 ],
	get_fn(Group, R - (Group-1)*180).

random_firstname()->
	FirstL = get_firstname(first),
	LastL = get_firstname(last),
	Line = rand(1,LastL - FirstL + 1),
	NameList =  get_firstname(FirstL + Line - 1),
	case rand(1,4) of
		1 ->
			NameList;
		2 ->
			lists:reverse(NameList);
		3 ->
			NameList -- lists:nthtail(3, NameList);
		4 ->
			lists:nthtail(3, NameList)
	end.

get_fn(G, N)->
	lists:nth(N, get_familyname(G)).

get_familyname(1) ->
	%1, 180
	["赵","钱","孙","李","周","吴","郑","王","冯","陈","褚","卫","
蒋","沈","韩","杨","朱","秦","尤","许","何","吕","施","张","
孔","曹","严","华","金","魏","陶","姜","戚","谢","邹","喻","
柏","水","窦","章","云","苏","潘","葛","奚","范","彭","郎","
鲁","韦","昌","马","苗","凤","花","方","俞","任","袁","柳","
酆","鲍","史","唐","费","廉","岑","薛","雷","贺","倪","汤","
滕","殷","罗","毕","郝","邬","安","常","乐","于","时","傅","
皮","卞","齐","康","伍","余","元","卜","顾","孟","平","黄","
和","穆","萧","尹","姚","邵","湛","汪","祁","毛","禹","狄","
米","贝","明","臧","计","伏","成","戴","谈","宋","茅","庞","
熊","纪","舒","屈","项","祝","董","梁","杜","阮","蓝","闵","
席","季","麻","强","贾","路","娄","危","江","童","颜","郭","
梅","盛","林","刁","锺","徐","邱","骆","高","夏","蔡","田","
樊","胡","凌","霍","虞","万","支","柯","昝","管","卢","莫","
经","房","裘","缪","干","解","应","宗","丁","宣","贲","邓"];

get_familyname(2)->
	%181, 360
["郁","单","杭","洪","包","诸","左","石","崔","吉","钮","龚","
程","嵇","邢","滑","裴","陆","荣","翁","荀","羊","於","惠","
甄","麴","家","封","芮","羿","储","靳","汲","邴","糜","松","
井","段","富","巫","乌","焦","巴","弓","牧","隗","山","谷","
车","侯","宓","蓬","全","郗","班","仰","秋","仲","伊","宫","
宁","仇","栾","暴","甘","钭","历","戎","祖","武","符","刘","
景","詹","束","龙","叶","幸","司","韶","郜","黎","蓟","溥","
印","宿","白","怀","蒲","邰","从","鄂","索","咸","籍","赖","
卓","蔺","屠","蒙","池","乔","阳","郁","胥","能","苍","双","
闻","莘","党","翟","谭","贡","劳","逄","姬","申","扶","堵","
冉","宰","郦","雍","却","璩","桑","桂","濮","牛","寿","通","
边","扈","燕","冀","僪","浦","尚","农","温","别","庄","晏","
柴","瞿","阎","充","慕","连","茹","习","宦","艾","鱼","容","
向","古","易","慎","戈","廖","庾","终","暨","居","衡","步","
都","耿","满","弘","匡","国","文","寇","广","禄","阙","东"];

%361, 540
get_familyname(3)->
	["欧","殳","沃","利","蔚","越","夔","隆","师","巩","厍","聂","
晁","勾","敖","融","冷","訾","辛","阚","那","简","饶","空","
曾","毋","沙","乜","养","鞠","须","丰","巢","关","蒯","相","
查","后","荆","红","游","竺","权","逮","盍","益","桓","公","
万俟","司马","上官","欧阳","夏侯","诸葛","闻人","东方","赫连","皇甫","尉迟","公羊","
澹台","公冶","宗政","濮阳","淳于","单于","太叔","申屠","公孙","仲孙","轩辕","令狐","
钟离","宇文","长孙","慕容","司徒","司空","召","有","舜","叶赫那拉","丛","岳","
寸","贰","皇","侨","彤","竭","端","赫","实","甫","集","象","
翠","狂","辟","典","良","函","芒","苦","其","京","中","夕","
之","章佳","那拉","冠","宾","香","果","依尔根觉罗","依尔觉罗","萨嘛喇","赫舍里","额尔德特","
萨克达","钮祜禄","他塔喇","喜塔腊","讷殷富察","叶赫那兰","库雅喇","瓜尔佳","舒穆禄","爱新觉罗","索绰络","纳喇","
乌雅","范姜","碧鲁","张廖","张简","图门","太史","公叔","乌孙","完颜","马佳","佟佳","
富察","费莫","蹇","称","诺","来","多","繁","戊","朴","回","毓","
税","荤","靖","绪","愈","硕","牢","买","但","巧","枚","撒","
泰","秘","亥","绍","以","壬","森","斋","释","奕","姒","朋"];

%541, 720
get_familyname(4)->
	["求","羽","用","占","真","穰","翦","闾","漆","贵","代","贯","
旁","崇","栋","告","休","褒","谏","锐","皋","闳","在","歧","
禾","示","是","委","钊","频","嬴","呼","大","威","昂","律","
冒","保","系","抄","定","化","莱","校","么","抗","祢","綦","
悟","宏","功","庚","务","敏","捷","拱","兆","丑","丙","畅","
苟","随","类","卯","俟","友","答","乙","允","甲","留","尾","
佼","玄","乘","裔","延","植","环","矫","赛","昔","侍","度","
旷","遇","偶","前","由","咎","塞","敛","受","泷","袭","衅","
叔","圣","御","夫","仆","镇","藩","邸","府","掌","首","员","
焉","戏","可","智","尔","凭","悉","进","笃","厚","仁","业","
肇","资","合","仍","九","衷","哀","刑","俎","仵","圭","夷","
徭","蛮","汗","孛","乾","帖","罕","洛","淦","洋","邶","郸","
郯","邗","邛","剑","虢","隋","蒿","茆","菅","苌","树","桐","
锁","钟","机","盘","铎","斛","玉","线","针","箕","庹","绳","
磨","蒉","瓮","弭","刀","疏","牵","浑","恽","势","世","仝"];

%721, 900
get_familyname(5) ->
	["同","蚁","止","戢","睢","冼","种","涂","肖","己","泣","潜","
卷","脱","谬","蹉","赧","浮","顿","说","次","错","念","夙","
斯","完","丹","表","聊","源","姓","吾","寻","展","出","不","
户","闭","才","无","书","学","愚","本","性","雪","霜","烟","
寒","少","字","桥","板","斐","独","千","诗","嘉","扬","善","
揭","祈","析","赤","紫","青","柔","刚","奇","拜","佛","陀","
弥","阿","素","长","僧","隐","仙","隽","宇","祭","酒","淡","
塔","琦","闪","始","星","南","天","接","波","碧","速","禚","
腾","潮","镜","似","澄","潭","謇","纵","渠","奈","风","春","
濯","沐","茂","英","兰","檀","藤","枝","检","生","折","登","
驹","骑","貊","虎","肥","鹿","雀","野","禽","飞","节","宜","
鲜","粟","栗","豆","帛","官","布","衣","藏","宝","钞","银","
门","盈","庆","喜","及","普","建","营","巨","望","希","道","
载","声","漫","犁","力","贸","勤","革","改","兴","亓","睦","
修","信","闽","北","守","坚","勇","汉","练","尉","士","旅"];

%901, 1056
get_familyname(6) ->
	["五","令","将","旗","军","行","奉","敬","恭","仪","母","堂","
丘","义","礼","慈","孝","理","伦","卿","问","永","辉","位","
让","尧","依","犹","介","承","市","所","苑","杞","剧","第","
零","谌","招","续","达","忻","六","鄞","战","迟","候","宛","
励","粘","萨","邝","覃","辜","初","楼","城","区","局","台","
原","考","妫","纳","泉","老","清","德","卑","过","麦","曲","
竹","百","福","言","第五","佟","爱","年","笪","谯","哈","墨","
南宫","赏","伯","佴","佘","牟","商","西门","东门","左丘","梁丘","琴","
后","况","亢","缑","帅","微生","羊舌","海","归","呼延","南门","东郭","
百里","钦","鄢","汝","法","闫","楚","晋","谷梁","宰父","夹谷","拓跋","
壤驷","乐正","漆雕","公西","巫马","端木","颛孙","子车","督","仉","司寇","亓官","
鲜于","锺离","盖","逯","库","郏","逢","阴","薄","厉","稽","闾丘","
公良","段干","开","光","瑞","眭","泥","运","摩","伟","铁","
迮"].

get_firstname(first)->
	?LINE + 1;
get_firstname(?LINE)->"原敏";
get_firstname(?LINE)->"怡琳";
get_firstname(?LINE)->"启杰";
get_firstname(?LINE)->"文妮";
get_firstname(?LINE)->"长璇";
get_firstname(?LINE)->"炳平";
get_firstname(?LINE)->"彦邺";
get_firstname(?LINE)->"默珂";
get_firstname(?LINE)->"丽莲";
get_firstname(?LINE)->"馨媚";
get_firstname(?LINE)->"验盈";
get_firstname(?LINE)->"琬鑫";
get_firstname(?LINE)->"雪琼";
get_firstname(?LINE)->"颖燕";
get_firstname(?LINE)->"思雯";
get_firstname(?LINE)->"琳桐";
get_firstname(?LINE)->"思莉";
get_firstname(?LINE)->"敬鑫";
get_firstname(?LINE)->"艺宜";
get_firstname(?LINE)->"晓葳";
get_firstname(?LINE)->"施玲";
get_firstname(?LINE)->"正华";
get_firstname(?LINE)->"兰贝";
get_firstname(?LINE)->"健倍";
get_firstname(?LINE)->"伊越";
get_firstname(?LINE)->"白菲";
get_firstname(?LINE)->"木敖";
get_firstname(?LINE)->"涵倪";
get_firstname(?LINE)->"笑筠";
get_firstname(?LINE)->"翠凤";
get_firstname(?LINE)->"琉晴";
get_firstname(?LINE)->"双瑛";
get_firstname(?LINE)->"玉冰";
get_firstname(?LINE)->"圣平";
get_firstname(?LINE)->"厶文";
get_firstname(?LINE)->"若平";
get_firstname(?LINE)->"天娟";
get_firstname(?LINE)->"薪涵";
get_firstname(?LINE)->"李萱";
get_firstname(?LINE)->"昱菲";
get_firstname(?LINE)->"姝媛";
get_firstname(?LINE)->"爱颖";
get_firstname(?LINE)->"荣蕊";
get_firstname(?LINE)->"廷欣";
get_firstname(?LINE)->"丽欣";
get_firstname(?LINE)->"意媛";
get_firstname(?LINE)->"彦涵";
get_firstname(?LINE)->"靖宇";
get_firstname(?LINE)->"瑞然";
get_firstname(?LINE)->"艺杰";
get_firstname(?LINE)->"进丹";
get_firstname(?LINE)->"灏琳";
get_firstname(?LINE)->"亚蕊";
get_firstname(?LINE)->"梓郗";
get_firstname(?LINE)->"琪阳";
get_firstname(?LINE)->"琳晶";
get_firstname(?LINE)->"文华";
get_firstname(?LINE)->"姣杰";
get_firstname(?LINE)->"小莹";
get_firstname(?LINE)->"飞婷";
get_firstname(?LINE)->"竹慈";
get_firstname(?LINE)->"冰旭";
get_firstname(?LINE)->"嘉艺";
get_firstname(?LINE)->"红莉";
get_firstname(?LINE)->"钰颖";
get_firstname(?LINE)->"朱晴";
get_firstname(?LINE)->"琦旬";
get_firstname(?LINE)->"维圆";
get_firstname(?LINE)->"金伶";
get_firstname(?LINE)->"吉瑶";
get_firstname(?LINE)->"馨珊";
get_firstname(?LINE)->"睿娟";
get_firstname(?LINE)->"梦羽";
get_firstname(?LINE)->"温焓";
get_firstname(?LINE)->"丽兵";
get_firstname(?LINE)->"正如";
get_firstname(?LINE)->"泓彤";
get_firstname(?LINE)->"汇新";
get_firstname(?LINE)->"岩玥";
get_firstname(?LINE)->"雨衡";
get_firstname(?LINE)->"颖明";
get_firstname(?LINE)->"泓红";
get_firstname(?LINE)->"静一";
get_firstname(?LINE)->"贝璇";
get_firstname(?LINE)->"若珍";
get_firstname(?LINE)->"桂研";
get_firstname(?LINE)->"淑娟";
get_firstname(?LINE)->"一玲";
get_firstname(?LINE)->"文蓉";
get_firstname(?LINE)->"海颖";
get_firstname(?LINE)->"珂辰";
get_firstname(?LINE)->"传一";
get_firstname(?LINE)->"莹明";
get_firstname(?LINE)->"德娴";
get_firstname(?LINE)->"婉平";
get_firstname(?LINE)->"佳捷";
get_firstname(?LINE)->"永楠";
get_firstname(?LINE)->"雅瑞";
get_firstname(?LINE)->"华艾";
get_firstname(?LINE)->"佩誉";
get_firstname(?LINE)->"语英";
get_firstname(?LINE)->"容谕";
get_firstname(?LINE)->"紫全";
get_firstname(?LINE)->"淇珍";
get_firstname(?LINE)->"春筠";
get_firstname(?LINE)->"淋秋";
get_firstname(?LINE)->"淑涵";
get_firstname(?LINE)->"子绮";
get_firstname(?LINE)->"馨华";
get_firstname(?LINE)->"梦纯";
get_firstname(?LINE)->"琪然";
get_firstname(?LINE)->"玎梅";
get_firstname(?LINE)->"微璇";
get_firstname(?LINE)->"莲欣";
get_firstname(?LINE)->"佳莉";
get_firstname(?LINE)->"梦宏";
get_firstname(?LINE)->"傲森";
get_firstname(?LINE)->"洁珊";
get_firstname(?LINE)->"媛婷";
get_firstname(?LINE)->"漫香";
get_firstname(?LINE)->"方锦";
get_firstname(?LINE)->"显霓";
get_firstname(?LINE)->"瑜晴";
get_firstname(?LINE)->"泽天";
get_firstname(?LINE)->"一悦";
get_firstname(?LINE)->"娅原";
get_firstname(?LINE)->"莞言";
get_firstname(?LINE)->"雪营";
get_firstname(?LINE)->"屹梅";
get_firstname(?LINE)->"又丽";
get_firstname(?LINE)->"枝婷";
get_firstname(?LINE)->"佳棠";
get_firstname(?LINE)->"宣玲";
get_firstname(?LINE)->"怡焱";
get_firstname(?LINE)->"娇明";
get_firstname(?LINE)->"安灵";
get_firstname(?LINE)->"兰平";
get_firstname(?LINE)->"小言";
get_firstname(?LINE)->"几云";
get_firstname(?LINE)->"欣路";
get_firstname(?LINE)->"古梅";
get_firstname(?LINE)->"艳妹";
get_firstname(?LINE)->"沧晶";
get_firstname(?LINE)->"懿忆";
get_firstname(?LINE)->"涣花";
get_firstname(?LINE)->"文樱";
get_firstname(?LINE)->"卓睿";
get_firstname(?LINE)->"娅杏";
get_firstname(?LINE)->"宇瑶";
get_firstname(?LINE)->"媛逸";
get_firstname(?LINE)->"苑东";
get_firstname(?LINE)->"思倩";
get_firstname(?LINE)->"婷娜";
get_firstname(?LINE)->"若瑛";
get_firstname(?LINE)->"家媛";
get_firstname(?LINE)->"泽芳";
get_firstname(?LINE)->"盈丽";
get_firstname(?LINE)->"雪鑫";
get_firstname(?LINE)->"艳榆";
get_firstname(?LINE)->"雅镐";
get_firstname(?LINE)->"文明";
get_firstname(?LINE)->"俊帆";
get_firstname(?LINE)->"韩砾";
get_firstname(?LINE)->"佳萍";
get_firstname(?LINE)->"子杰";
get_firstname(?LINE)->"文羲";
get_firstname(?LINE)->"美霖";
get_firstname(?LINE)->"秀鑫";
get_firstname(?LINE)->"昀涵";
get_firstname(?LINE)->"鲁镁";
get_firstname(?LINE)->"智霞";
get_firstname(?LINE)->"敏雯";
get_firstname(?LINE)->"佳瑜";
get_firstname(?LINE)->"若丽";
get_firstname(?LINE)->"晓烨";
get_firstname(?LINE)->"赫珍";
get_firstname(?LINE)->"中芙";
get_firstname(?LINE)->"佳涵";
get_firstname(?LINE)->"慕翔";
get_firstname(?LINE)->"子平";
get_firstname(?LINE)->"衡婕";
get_firstname(?LINE)->"英雨";
get_firstname(?LINE)->"天元";
get_firstname(?LINE)->"羽冥";
get_firstname(?LINE)->"梦芸";
get_firstname(?LINE)->"伊凝";
get_firstname(?LINE)->"丽芳";
get_firstname(?LINE)->"子雨";
get_firstname(?LINE)->"雨雅";
get_firstname(?LINE)->"诗齐";
get_firstname(?LINE)->"翠涵";
get_firstname(?LINE)->"美蕴";
get_firstname(?LINE)->"会涵";
get_firstname(?LINE)->"诏钟";
get_firstname(?LINE)->"立玲";
get_firstname(?LINE)->"涧东";
get_firstname(?LINE)->"倩阳";
get_firstname(?LINE)->"敏菲";
get_firstname(?LINE)->"易骏";
get_firstname(?LINE)->"雯睿";
get_firstname(last)->  ?LINE - 1.

get_seed()->
    random:seed(erlang:now()),
	{random:uniform(99999), random:uniform(999999), random:uniform(999999)}.

%% 产生一个介于Min到Max之间的随机整数
rand(Same, Same) -> Same;
rand(Min, Max) ->
    %% 如果没有种子，将获取一个种子，以保证不同进程都可取得不同的种子
    case get("rand_seed") of
        undefined ->
            RandSeed = get_seed(),
            random:seed(RandSeed),
            put("rand_seed", RandSeed);
        _ -> skip
    end,
    %% random:seed(erlang:now()),
    M = Min - 1,
    random:uniform(Max - M) + M.