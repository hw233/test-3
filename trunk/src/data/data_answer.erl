%%%---------------------------------------
%%% @Module  : data_answer
%%% @Author  : lds
%%% @Email   : 
%%% @Description:  答题
%%%---------------------------------------


-module(data_answer).
-include("common.hrl").
-include("activity.hrl").
-compile(export_all).

 
get_question_info(all) -> 20
;
 
get_question_info(types) -> [1,2,3,4]
;
 
get_question_info(1) -> {3, [1001,1146]}
;
 
get_question_info(2) -> {3, [2001,2125]}
;
 
get_question_info(3) -> {13,[3001,3541]}
;
 
get_question_info(4) -> {1, [4001,4125]}
;

get_question_info(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.



 
get_reward(1) -> 
    #answer_reward{
        r_exp = 60000,
        r_b_silver = 0,
        r_literary = 200,
        w_exp = 30000,
        w_b_silver = 0,
        w_literary = 100,
        streak_reward_1 = {60182, 3},
        streak_reward_2 = {60183, 3}
    }
;

get_reward(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.

get_lv_gap()->
	[1].



 
get_correct_answer(1001) -> 1
;
 
get_correct_answer(1002) -> 3
;
 
get_correct_answer(1003) -> 3
;
 
get_correct_answer(1004) -> 3
;
 
get_correct_answer(1005) -> 2
;
 
get_correct_answer(1006) -> 2
;
 
get_correct_answer(1007) -> 1
;
 
get_correct_answer(1008) -> 3
;
 
get_correct_answer(1009) -> 3
;
 
get_correct_answer(1010) -> 4
;
 
get_correct_answer(1011) -> 3
;
 
get_correct_answer(1012) -> 4
;
 
get_correct_answer(1013) -> 2
;
 
get_correct_answer(1014) -> 2
;
 
get_correct_answer(1015) -> 3
;
 
get_correct_answer(1016) -> 3
;
 
get_correct_answer(1017) -> 4
;
 
get_correct_answer(1018) -> 1
;
 
get_correct_answer(1019) -> 3
;
 
get_correct_answer(1020) -> 3
;
 
get_correct_answer(1021) -> 3
;
 
get_correct_answer(1022) -> 2
;
 
get_correct_answer(1023) -> 3
;
 
get_correct_answer(1024) -> 1
;
 
get_correct_answer(1025) -> 3
;
 
get_correct_answer(1026) -> 2
;
 
get_correct_answer(1027) -> 1
;
 
get_correct_answer(1028) -> 1
;
 
get_correct_answer(1029) -> 1
;
 
get_correct_answer(1030) -> 3
;
 
get_correct_answer(1031) -> 1
;
 
get_correct_answer(1032) -> 2
;
 
get_correct_answer(1033) -> 3
;
 
get_correct_answer(1034) -> 1
;
 
get_correct_answer(1035) -> 4
;
 
get_correct_answer(1036) -> 1
;
 
get_correct_answer(1037) -> 2
;
 
get_correct_answer(1038) -> 3
;
 
get_correct_answer(1039) -> 1
;
 
get_correct_answer(1040) -> 2
;
 
get_correct_answer(1041) -> 1
;
 
get_correct_answer(1042) -> 2
;
 
get_correct_answer(1043) -> 2
;
 
get_correct_answer(1044) -> 3
;
 
get_correct_answer(1045) -> 1
;
 
get_correct_answer(1046) -> 2
;
 
get_correct_answer(1047) -> 3
;
 
get_correct_answer(1048) -> 1
;
 
get_correct_answer(1049) -> 2
;
 
get_correct_answer(1050) -> 4
;
 
get_correct_answer(1051) -> 4
;
 
get_correct_answer(1052) -> 1
;
 
get_correct_answer(1053) -> 2
;
 
get_correct_answer(1054) -> 3
;
 
get_correct_answer(1055) -> 1
;
 
get_correct_answer(1056) -> 2
;
 
get_correct_answer(1057) -> 3
;
 
get_correct_answer(1058) -> 1
;
 
get_correct_answer(1059) -> 2
;
 
get_correct_answer(1060) -> 3
;
 
get_correct_answer(1061) -> 1
;
 
get_correct_answer(1062) -> 1
;
 
get_correct_answer(1063) -> 2
;
 
get_correct_answer(1064) -> 3
;
 
get_correct_answer(1065) -> 2
;
 
get_correct_answer(1066) -> 4
;
 
get_correct_answer(1067) -> 1
;
 
get_correct_answer(1068) -> 3
;
 
get_correct_answer(1069) -> 1
;
 
get_correct_answer(1070) -> 4
;
 
get_correct_answer(1071) -> 2
;
 
get_correct_answer(1072) -> 2
;
 
get_correct_answer(1073) -> 3
;
 
get_correct_answer(1074) -> 1
;
 
get_correct_answer(1075) -> 2
;
 
get_correct_answer(1076) -> 3
;
 
get_correct_answer(1077) -> 3
;
 
get_correct_answer(1078) -> 2
;
 
get_correct_answer(1079) -> 1
;
 
get_correct_answer(1080) -> 1
;
 
get_correct_answer(1081) -> 2
;
 
get_correct_answer(1082) -> 4
;
 
get_correct_answer(1083) -> 3
;
 
get_correct_answer(1084) -> 3
;
 
get_correct_answer(1085) -> 4
;
 
get_correct_answer(1086) -> 3
;
 
get_correct_answer(1087) -> 2
;
 
get_correct_answer(1088) -> 1
;
 
get_correct_answer(1089) -> 2
;
 
get_correct_answer(1090) -> 2
;
 
get_correct_answer(1091) -> 2
;
 
get_correct_answer(1092) -> 2
;
 
get_correct_answer(1093) -> 2
;
 
get_correct_answer(1094) -> 3
;
 
get_correct_answer(1095) -> 1
;
 
get_correct_answer(1096) -> 2
;
 
get_correct_answer(1097) -> 3
;
 
get_correct_answer(1098) -> 2
;
 
get_correct_answer(1099) -> 3
;
 
get_correct_answer(1100) -> 1
;
 
get_correct_answer(1101) -> 2
;
 
get_correct_answer(1102) -> 3
;
 
get_correct_answer(1103) -> 4
;
 
get_correct_answer(1104) -> 2
;
 
get_correct_answer(1105) -> 3
;
 
get_correct_answer(1106) -> 3
;
 
get_correct_answer(1107) -> 1
;
 
get_correct_answer(1108) -> 2
;
 
get_correct_answer(1109) -> 3
;
 
get_correct_answer(1110) -> 4
;
 
get_correct_answer(1111) -> 2
;
 
get_correct_answer(1112) -> 3
;
 
get_correct_answer(1113) -> 4
;
 
get_correct_answer(1114) -> 1
;
 
get_correct_answer(1115) -> 2
;
 
get_correct_answer(1116) -> 3
;
 
get_correct_answer(1117) -> 4
;
 
get_correct_answer(1118) -> 2
;
 
get_correct_answer(1119) -> 1
;
 
get_correct_answer(1120) -> 2
;
 
get_correct_answer(1121) -> 3
;
 
get_correct_answer(1122) -> 1
;
 
get_correct_answer(1123) -> 2
;
 
get_correct_answer(1124) -> 1
;
 
get_correct_answer(1125) -> 2
;
 
get_correct_answer(1126) -> 3
;
 
get_correct_answer(1127) -> 3
;
 
get_correct_answer(1128) -> 4
;
 
get_correct_answer(1129) -> 2
;
 
get_correct_answer(1130) -> 4
;
 
get_correct_answer(1131) -> 3
;
 
get_correct_answer(1132) -> 3
;
 
get_correct_answer(1133) -> 2
;
 
get_correct_answer(1134) -> 3
;
 
get_correct_answer(1135) -> 2
;
 
get_correct_answer(1136) -> 1
;
 
get_correct_answer(1137) -> 1
;
 
get_correct_answer(1138) -> 3
;
 
get_correct_answer(1139) -> 4
;
 
get_correct_answer(1140) -> 2
;
 
get_correct_answer(1141) -> 3
;
 
get_correct_answer(1142) -> 1
;
 
get_correct_answer(1143) -> 2
;
 
get_correct_answer(1144) -> 3
;
 
get_correct_answer(1145) -> 4
;
 
get_correct_answer(1146) -> 1
;
 
get_correct_answer(2001) -> 1
;
 
get_correct_answer(2002) -> 1
;
 
get_correct_answer(2003) -> 1
;
 
get_correct_answer(2004) -> 1
;
 
get_correct_answer(2005) -> 1
;
 
get_correct_answer(2006) -> 2
;
 
get_correct_answer(2007) -> 4
;
 
get_correct_answer(2008) -> 2
;
 
get_correct_answer(2009) -> 2
;
 
get_correct_answer(2010) -> 2
;
 
get_correct_answer(2011) -> 3
;
 
get_correct_answer(2012) -> 3
;
 
get_correct_answer(2013) -> 3
;
 
get_correct_answer(2014) -> 3
;
 
get_correct_answer(2015) -> 3
;
 
get_correct_answer(2016) -> 3
;
 
get_correct_answer(2017) -> 3
;
 
get_correct_answer(2018) -> 1
;
 
get_correct_answer(2019) -> 1
;
 
get_correct_answer(2020) -> 1
;
 
get_correct_answer(2021) -> 1
;
 
get_correct_answer(2022) -> 1
;
 
get_correct_answer(2023) -> 4
;
 
get_correct_answer(2024) -> 4
;
 
get_correct_answer(2025) -> 4
;
 
get_correct_answer(2026) -> 4
;
 
get_correct_answer(2027) -> 4
;
 
get_correct_answer(2028) -> 4
;
 
get_correct_answer(2029) -> 4
;
 
get_correct_answer(2030) -> 1
;
 
get_correct_answer(2031) -> 1
;
 
get_correct_answer(2032) -> 1
;
 
get_correct_answer(2033) -> 1
;
 
get_correct_answer(2034) -> 2
;
 
get_correct_answer(2035) -> 3
;
 
get_correct_answer(2036) -> 3
;
 
get_correct_answer(2037) -> 3
;
 
get_correct_answer(2038) -> 3
;
 
get_correct_answer(2039) -> 2
;
 
get_correct_answer(2040) -> 1
;
 
get_correct_answer(2041) -> 1
;
 
get_correct_answer(2042) -> 1
;
 
get_correct_answer(2043) -> 1
;
 
get_correct_answer(2044) -> 3
;
 
get_correct_answer(2045) -> 3
;
 
get_correct_answer(2046) -> 3
;
 
get_correct_answer(2047) -> 3
;
 
get_correct_answer(2048) -> 3
;
 
get_correct_answer(2049) -> 2
;
 
get_correct_answer(2050) -> 2
;
 
get_correct_answer(2051) -> 2
;
 
get_correct_answer(2052) -> 2
;
 
get_correct_answer(2053) -> 1
;
 
get_correct_answer(2054) -> 1
;
 
get_correct_answer(2055) -> 1
;
 
get_correct_answer(2056) -> 1
;
 
get_correct_answer(2057) -> 4
;
 
get_correct_answer(2058) -> 4
;
 
get_correct_answer(2059) -> 4
;
 
get_correct_answer(2060) -> 3
;
 
get_correct_answer(2061) -> 3
;
 
get_correct_answer(2062) -> 1
;
 
get_correct_answer(2063) -> 4
;
 
get_correct_answer(2064) -> 1
;
 
get_correct_answer(2065) -> 2
;
 
get_correct_answer(2066) -> 4
;
 
get_correct_answer(2067) -> 4
;
 
get_correct_answer(2068) -> 1
;
 
get_correct_answer(2069) -> 1
;
 
get_correct_answer(2070) -> 1
;
 
get_correct_answer(2071) -> 1
;
 
get_correct_answer(2072) -> 3
;
 
get_correct_answer(2073) -> 2
;
 
get_correct_answer(2074) -> 1
;
 
get_correct_answer(2075) -> 1
;
 
get_correct_answer(2076) -> 1
;
 
get_correct_answer(2077) -> 3
;
 
get_correct_answer(2078) -> 3
;
 
get_correct_answer(2079) -> 4
;
 
get_correct_answer(2080) -> 4
;
 
get_correct_answer(2081) -> 1
;
 
get_correct_answer(2082) -> 1
;
 
get_correct_answer(2083) -> 1
;
 
get_correct_answer(2084) -> 1
;
 
get_correct_answer(2085) -> 1
;
 
get_correct_answer(2086) -> 1
;
 
get_correct_answer(2087) -> 2
;
 
get_correct_answer(2088) -> 3
;
 
get_correct_answer(2089) -> 2
;
 
get_correct_answer(2090) -> 4
;
 
get_correct_answer(2091) -> 1
;
 
get_correct_answer(2092) -> 1
;
 
get_correct_answer(2093) -> 1
;
 
get_correct_answer(2094) -> 1
;
 
get_correct_answer(2095) -> 1
;
 
get_correct_answer(2096) -> 3
;
 
get_correct_answer(2097) -> 3
;
 
get_correct_answer(2098) -> 4
;
 
get_correct_answer(2099) -> 4
;
 
get_correct_answer(2100) -> 4
;
 
get_correct_answer(2101) -> 3
;
 
get_correct_answer(2102) -> 2
;
 
get_correct_answer(2103) -> 1
;
 
get_correct_answer(2104) -> 1
;
 
get_correct_answer(2105) -> 2
;
 
get_correct_answer(2106) -> 4
;
 
get_correct_answer(2107) -> 4
;
 
get_correct_answer(2108) -> 4
;
 
get_correct_answer(2109) -> 3
;
 
get_correct_answer(2110) -> 3
;
 
get_correct_answer(2111) -> 3
;
 
get_correct_answer(2112) -> 2
;
 
get_correct_answer(2113) -> 2
;
 
get_correct_answer(2114) -> 2
;
 
get_correct_answer(2115) -> 1
;
 
get_correct_answer(2116) -> 1
;
 
get_correct_answer(2117) -> 3
;
 
get_correct_answer(2118) -> 1
;
 
get_correct_answer(2119) -> 1
;
 
get_correct_answer(2120) -> 1
;
 
get_correct_answer(2121) -> 1
;
 
get_correct_answer(2122) -> 1
;
 
get_correct_answer(2123) -> 1
;
 
get_correct_answer(2124) -> 1
;
 
get_correct_answer(2125) -> 1
;
 
get_correct_answer(3001) -> 3
;
 
get_correct_answer(3002) -> 3
;
 
get_correct_answer(3003) -> 1
;
 
get_correct_answer(3004) -> 2
;
 
get_correct_answer(3005) -> 1
;
 
get_correct_answer(3006) -> 4
;
 
get_correct_answer(3007) -> 2
;
 
get_correct_answer(3008) -> 3
;
 
get_correct_answer(3009) -> 3
;
 
get_correct_answer(3010) -> 3
;
 
get_correct_answer(3011) -> 2
;
 
get_correct_answer(3012) -> 1
;
 
get_correct_answer(3013) -> 3
;
 
get_correct_answer(3014) -> 2
;
 
get_correct_answer(3015) -> 1
;
 
get_correct_answer(3016) -> 2
;
 
get_correct_answer(3017) -> 3
;
 
get_correct_answer(3018) -> 2
;
 
get_correct_answer(3019) -> 1
;
 
get_correct_answer(3020) -> 4
;
 
get_correct_answer(3021) -> 3
;
 
get_correct_answer(3022) -> 2
;
 
get_correct_answer(3023) -> 1
;
 
get_correct_answer(3024) -> 2
;
 
get_correct_answer(3025) -> 3
;
 
get_correct_answer(3026) -> 4
;
 
get_correct_answer(3027) -> 1
;
 
get_correct_answer(3028) -> 3
;
 
get_correct_answer(3029) -> 1
;
 
get_correct_answer(3030) -> 3
;
 
get_correct_answer(3031) -> 2
;
 
get_correct_answer(3032) -> 3
;
 
get_correct_answer(3033) -> 2
;
 
get_correct_answer(3034) -> 3
;
 
get_correct_answer(3035) -> 2
;
 
get_correct_answer(3036) -> 1
;
 
get_correct_answer(3037) -> 3
;
 
get_correct_answer(3038) -> 2
;
 
get_correct_answer(3039) -> 4
;
 
get_correct_answer(3040) -> 3
;
 
get_correct_answer(3041) -> 2
;
 
get_correct_answer(3042) -> 4
;
 
get_correct_answer(3043) -> 2
;
 
get_correct_answer(3044) -> 1
;
 
get_correct_answer(3045) -> 3
;
 
get_correct_answer(3046) -> 1
;
 
get_correct_answer(3047) -> 3
;
 
get_correct_answer(3048) -> 3
;
 
get_correct_answer(3049) -> 2
;
 
get_correct_answer(3050) -> 4
;
 
get_correct_answer(3051) -> 1
;
 
get_correct_answer(3052) -> 1
;
 
get_correct_answer(3053) -> 1
;
 
get_correct_answer(3054) -> 1
;
 
get_correct_answer(3055) -> 2
;
 
get_correct_answer(3056) -> 1
;
 
get_correct_answer(3057) -> 2
;
 
get_correct_answer(3058) -> 3
;
 
get_correct_answer(3059) -> 3
;
 
get_correct_answer(3060) -> 2
;
 
get_correct_answer(3061) -> 4
;
 
get_correct_answer(3062) -> 1
;
 
get_correct_answer(3063) -> 4
;
 
get_correct_answer(3064) -> 2
;
 
get_correct_answer(3065) -> 4
;
 
get_correct_answer(3066) -> 3
;
 
get_correct_answer(3067) -> 3
;
 
get_correct_answer(3068) -> 2
;
 
get_correct_answer(3069) -> 2
;
 
get_correct_answer(3070) -> 2
;
 
get_correct_answer(3071) -> 2
;
 
get_correct_answer(3072) -> 4
;
 
get_correct_answer(3073) -> 4
;
 
get_correct_answer(3074) -> 1
;
 
get_correct_answer(3075) -> 4
;
 
get_correct_answer(3076) -> 4
;
 
get_correct_answer(3077) -> 4
;
 
get_correct_answer(3078) -> 2
;
 
get_correct_answer(3079) -> 3
;
 
get_correct_answer(3080) -> 1
;
 
get_correct_answer(3081) -> 1
;
 
get_correct_answer(3082) -> 4
;
 
get_correct_answer(3083) -> 4
;
 
get_correct_answer(3084) -> 3
;
 
get_correct_answer(3085) -> 1
;
 
get_correct_answer(3086) -> 4
;
 
get_correct_answer(3087) -> 2
;
 
get_correct_answer(3088) -> 1
;
 
get_correct_answer(3089) -> 2
;
 
get_correct_answer(3090) -> 1
;
 
get_correct_answer(3091) -> 1
;
 
get_correct_answer(3092) -> 3
;
 
get_correct_answer(3093) -> 2
;
 
get_correct_answer(3094) -> 2
;
 
get_correct_answer(3095) -> 2
;
 
get_correct_answer(3096) -> 4
;
 
get_correct_answer(3097) -> 4
;
 
get_correct_answer(3098) -> 1
;
 
get_correct_answer(3099) -> 1
;
 
get_correct_answer(3100) -> 3
;
 
get_correct_answer(3101) -> 3
;
 
get_correct_answer(3102) -> 4
;
 
get_correct_answer(3103) -> 3
;
 
get_correct_answer(3104) -> 1
;
 
get_correct_answer(3105) -> 4
;
 
get_correct_answer(3106) -> 2
;
 
get_correct_answer(3107) -> 3
;
 
get_correct_answer(3108) -> 1
;
 
get_correct_answer(3109) -> 1
;
 
get_correct_answer(3110) -> 2
;
 
get_correct_answer(3111) -> 3
;
 
get_correct_answer(3112) -> 3
;
 
get_correct_answer(3113) -> 3
;
 
get_correct_answer(3114) -> 2
;
 
get_correct_answer(3115) -> 4
;
 
get_correct_answer(3116) -> 2
;
 
get_correct_answer(3117) -> 3
;
 
get_correct_answer(3118) -> 4
;
 
get_correct_answer(3119) -> 3
;
 
get_correct_answer(3120) -> 2
;
 
get_correct_answer(3121) -> 3
;
 
get_correct_answer(3122) -> 3
;
 
get_correct_answer(3123) -> 4
;
 
get_correct_answer(3124) -> 4
;
 
get_correct_answer(3125) -> 4
;
 
get_correct_answer(3126) -> 3
;
 
get_correct_answer(3127) -> 3
;
 
get_correct_answer(3128) -> 4
;
 
get_correct_answer(3129) -> 3
;
 
get_correct_answer(3130) -> 2
;
 
get_correct_answer(3131) -> 3
;
 
get_correct_answer(3132) -> 3
;
 
get_correct_answer(3133) -> 3
;
 
get_correct_answer(3134) -> 3
;
 
get_correct_answer(3135) -> 2
;
 
get_correct_answer(3136) -> 1
;
 
get_correct_answer(3137) -> 3
;
 
get_correct_answer(3138) -> 4
;
 
get_correct_answer(3139) -> 3
;
 
get_correct_answer(3140) -> 4
;
 
get_correct_answer(3141) -> 3
;
 
get_correct_answer(3142) -> 4
;
 
get_correct_answer(3143) -> 2
;
 
get_correct_answer(3144) -> 2
;
 
get_correct_answer(3145) -> 2
;
 
get_correct_answer(3146) -> 4
;
 
get_correct_answer(3147) -> 1
;
 
get_correct_answer(3148) -> 3
;
 
get_correct_answer(3149) -> 3
;
 
get_correct_answer(3150) -> 1
;
 
get_correct_answer(3151) -> 4
;
 
get_correct_answer(3152) -> 1
;
 
get_correct_answer(3153) -> 3
;
 
get_correct_answer(3154) -> 3
;
 
get_correct_answer(3155) -> 1
;
 
get_correct_answer(3156) -> 3
;
 
get_correct_answer(3157) -> 2
;
 
get_correct_answer(3158) -> 3
;
 
get_correct_answer(3159) -> 2
;
 
get_correct_answer(3160) -> 2
;
 
get_correct_answer(3161) -> 2
;
 
get_correct_answer(3162) -> 3
;
 
get_correct_answer(3163) -> 1
;
 
get_correct_answer(3164) -> 2
;
 
get_correct_answer(3165) -> 4
;
 
get_correct_answer(3166) -> 2
;
 
get_correct_answer(3167) -> 2
;
 
get_correct_answer(3168) -> 1
;
 
get_correct_answer(3169) -> 2
;
 
get_correct_answer(3170) -> 1
;
 
get_correct_answer(3171) -> 2
;
 
get_correct_answer(3172) -> 2
;
 
get_correct_answer(3173) -> 1
;
 
get_correct_answer(3174) -> 3
;
 
get_correct_answer(3175) -> 4
;
 
get_correct_answer(3176) -> 1
;
 
get_correct_answer(3177) -> 1
;
 
get_correct_answer(3178) -> 2
;
 
get_correct_answer(3179) -> 4
;
 
get_correct_answer(3180) -> 1
;
 
get_correct_answer(3181) -> 1
;
 
get_correct_answer(3182) -> 1
;
 
get_correct_answer(3183) -> 2
;
 
get_correct_answer(3184) -> 4
;
 
get_correct_answer(3185) -> 4
;
 
get_correct_answer(3186) -> 3
;
 
get_correct_answer(3187) -> 4
;
 
get_correct_answer(3188) -> 3
;
 
get_correct_answer(3189) -> 4
;
 
get_correct_answer(3190) -> 2
;
 
get_correct_answer(3191) -> 3
;
 
get_correct_answer(3192) -> 1
;
 
get_correct_answer(3193) -> 3
;
 
get_correct_answer(3194) -> 4
;
 
get_correct_answer(3195) -> 1
;
 
get_correct_answer(3196) -> 1
;
 
get_correct_answer(3197) -> 1
;
 
get_correct_answer(3198) -> 4
;
 
get_correct_answer(3199) -> 2
;
 
get_correct_answer(3200) -> 4
;
 
get_correct_answer(3201) -> 1
;
 
get_correct_answer(3202) -> 3
;
 
get_correct_answer(3203) -> 1
;
 
get_correct_answer(3204) -> 4
;
 
get_correct_answer(3205) -> 2
;
 
get_correct_answer(3206) -> 4
;
 
get_correct_answer(3207) -> 3
;
 
get_correct_answer(3208) -> 3
;
 
get_correct_answer(3209) -> 2
;
 
get_correct_answer(3210) -> 3
;
 
get_correct_answer(3211) -> 3
;
 
get_correct_answer(3212) -> 1
;
 
get_correct_answer(3213) -> 2
;
 
get_correct_answer(3214) -> 1
;
 
get_correct_answer(3215) -> 4
;
 
get_correct_answer(3216) -> 2
;
 
get_correct_answer(3217) -> 3
;
 
get_correct_answer(3218) -> 3
;
 
get_correct_answer(3219) -> 3
;
 
get_correct_answer(3220) -> 2
;
 
get_correct_answer(3221) -> 1
;
 
get_correct_answer(3222) -> 3
;
 
get_correct_answer(3223) -> 2
;
 
get_correct_answer(3224) -> 1
;
 
get_correct_answer(3225) -> 2
;
 
get_correct_answer(3226) -> 3
;
 
get_correct_answer(3227) -> 2
;
 
get_correct_answer(3228) -> 1
;
 
get_correct_answer(3229) -> 4
;
 
get_correct_answer(3230) -> 3
;
 
get_correct_answer(3231) -> 2
;
 
get_correct_answer(3232) -> 1
;
 
get_correct_answer(3233) -> 2
;
 
get_correct_answer(3234) -> 3
;
 
get_correct_answer(3235) -> 4
;
 
get_correct_answer(3236) -> 1
;
 
get_correct_answer(3237) -> 3
;
 
get_correct_answer(3238) -> 1
;
 
get_correct_answer(3239) -> 3
;
 
get_correct_answer(3240) -> 2
;
 
get_correct_answer(3241) -> 3
;
 
get_correct_answer(3242) -> 2
;
 
get_correct_answer(3243) -> 3
;
 
get_correct_answer(3244) -> 2
;
 
get_correct_answer(3245) -> 1
;
 
get_correct_answer(3246) -> 3
;
 
get_correct_answer(3247) -> 2
;
 
get_correct_answer(3248) -> 4
;
 
get_correct_answer(3249) -> 3
;
 
get_correct_answer(3250) -> 2
;
 
get_correct_answer(3251) -> 4
;
 
get_correct_answer(3252) -> 2
;
 
get_correct_answer(3253) -> 1
;
 
get_correct_answer(3254) -> 3
;
 
get_correct_answer(3255) -> 1
;
 
get_correct_answer(3256) -> 3
;
 
get_correct_answer(3257) -> 3
;
 
get_correct_answer(3258) -> 2
;
 
get_correct_answer(3259) -> 4
;
 
get_correct_answer(3260) -> 1
;
 
get_correct_answer(3261) -> 1
;
 
get_correct_answer(3262) -> 1
;
 
get_correct_answer(3263) -> 1
;
 
get_correct_answer(3264) -> 2
;
 
get_correct_answer(3265) -> 1
;
 
get_correct_answer(3266) -> 2
;
 
get_correct_answer(3267) -> 3
;
 
get_correct_answer(3268) -> 3
;
 
get_correct_answer(3269) -> 2
;
 
get_correct_answer(3270) -> 4
;
 
get_correct_answer(3271) -> 1
;
 
get_correct_answer(3272) -> 4
;
 
get_correct_answer(3273) -> 2
;
 
get_correct_answer(3274) -> 4
;
 
get_correct_answer(3275) -> 3
;
 
get_correct_answer(3276) -> 3
;
 
get_correct_answer(3277) -> 2
;
 
get_correct_answer(3278) -> 2
;
 
get_correct_answer(3279) -> 2
;
 
get_correct_answer(3280) -> 2
;
 
get_correct_answer(3281) -> 4
;
 
get_correct_answer(3282) -> 4
;
 
get_correct_answer(3283) -> 1
;
 
get_correct_answer(3284) -> 4
;
 
get_correct_answer(3285) -> 4
;
 
get_correct_answer(3286) -> 4
;
 
get_correct_answer(3287) -> 2
;
 
get_correct_answer(3288) -> 3
;
 
get_correct_answer(3289) -> 1
;
 
get_correct_answer(3290) -> 1
;
 
get_correct_answer(3291) -> 4
;
 
get_correct_answer(3292) -> 4
;
 
get_correct_answer(3293) -> 3
;
 
get_correct_answer(3294) -> 1
;
 
get_correct_answer(3295) -> 4
;
 
get_correct_answer(3296) -> 2
;
 
get_correct_answer(3297) -> 1
;
 
get_correct_answer(3298) -> 2
;
 
get_correct_answer(3299) -> 1
;
 
get_correct_answer(3300) -> 1
;
 
get_correct_answer(3301) -> 3
;
 
get_correct_answer(3302) -> 2
;
 
get_correct_answer(3303) -> 2
;
 
get_correct_answer(3304) -> 2
;
 
get_correct_answer(3305) -> 4
;
 
get_correct_answer(3306) -> 4
;
 
get_correct_answer(3307) -> 1
;
 
get_correct_answer(3308) -> 1
;
 
get_correct_answer(3309) -> 3
;
 
get_correct_answer(3310) -> 3
;
 
get_correct_answer(3311) -> 4
;
 
get_correct_answer(3312) -> 3
;
 
get_correct_answer(3313) -> 1
;
 
get_correct_answer(3314) -> 4
;
 
get_correct_answer(3315) -> 2
;
 
get_correct_answer(3316) -> 3
;
 
get_correct_answer(3317) -> 1
;
 
get_correct_answer(3318) -> 1
;
 
get_correct_answer(3319) -> 2
;
 
get_correct_answer(3320) -> 3
;
 
get_correct_answer(3321) -> 3
;
 
get_correct_answer(3322) -> 3
;
 
get_correct_answer(3323) -> 2
;
 
get_correct_answer(3324) -> 4
;
 
get_correct_answer(3325) -> 2
;
 
get_correct_answer(3326) -> 3
;
 
get_correct_answer(3327) -> 4
;
 
get_correct_answer(3328) -> 3
;
 
get_correct_answer(3329) -> 2
;
 
get_correct_answer(3330) -> 3
;
 
get_correct_answer(3331) -> 3
;
 
get_correct_answer(3332) -> 4
;
 
get_correct_answer(3333) -> 4
;
 
get_correct_answer(3334) -> 4
;
 
get_correct_answer(3335) -> 3
;
 
get_correct_answer(3336) -> 3
;
 
get_correct_answer(3337) -> 4
;
 
get_correct_answer(3338) -> 3
;
 
get_correct_answer(3339) -> 2
;
 
get_correct_answer(3340) -> 3
;
 
get_correct_answer(3341) -> 3
;
 
get_correct_answer(3342) -> 3
;
 
get_correct_answer(3343) -> 3
;
 
get_correct_answer(3344) -> 2
;
 
get_correct_answer(3345) -> 1
;
 
get_correct_answer(3346) -> 3
;
 
get_correct_answer(3347) -> 4
;
 
get_correct_answer(3348) -> 3
;
 
get_correct_answer(3349) -> 4
;
 
get_correct_answer(3350) -> 3
;
 
get_correct_answer(3351) -> 4
;
 
get_correct_answer(3352) -> 2
;
 
get_correct_answer(3353) -> 2
;
 
get_correct_answer(3354) -> 2
;
 
get_correct_answer(3355) -> 4
;
 
get_correct_answer(3356) -> 1
;
 
get_correct_answer(3357) -> 3
;
 
get_correct_answer(3358) -> 3
;
 
get_correct_answer(3359) -> 1
;
 
get_correct_answer(3360) -> 4
;
 
get_correct_answer(3361) -> 1
;
 
get_correct_answer(3362) -> 3
;
 
get_correct_answer(3363) -> 3
;
 
get_correct_answer(3364) -> 1
;
 
get_correct_answer(3365) -> 3
;
 
get_correct_answer(3366) -> 2
;
 
get_correct_answer(3367) -> 3
;
 
get_correct_answer(3368) -> 2
;
 
get_correct_answer(3369) -> 2
;
 
get_correct_answer(3370) -> 2
;
 
get_correct_answer(3371) -> 3
;
 
get_correct_answer(3372) -> 1
;
 
get_correct_answer(3373) -> 2
;
 
get_correct_answer(3374) -> 4
;
 
get_correct_answer(3375) -> 2
;
 
get_correct_answer(3376) -> 2
;
 
get_correct_answer(3377) -> 1
;
 
get_correct_answer(3378) -> 2
;
 
get_correct_answer(3379) -> 1
;
 
get_correct_answer(3380) -> 2
;
 
get_correct_answer(3381) -> 2
;
 
get_correct_answer(3382) -> 1
;
 
get_correct_answer(3383) -> 3
;
 
get_correct_answer(3384) -> 4
;
 
get_correct_answer(3385) -> 1
;
 
get_correct_answer(3386) -> 1
;
 
get_correct_answer(3387) -> 2
;
 
get_correct_answer(3388) -> 4
;
 
get_correct_answer(3389) -> 1
;
 
get_correct_answer(3390) -> 1
;
 
get_correct_answer(3391) -> 1
;
 
get_correct_answer(3392) -> 2
;
 
get_correct_answer(3393) -> 4
;
 
get_correct_answer(3394) -> 4
;
 
get_correct_answer(3395) -> 3
;
 
get_correct_answer(3396) -> 4
;
 
get_correct_answer(3397) -> 3
;
 
get_correct_answer(3398) -> 4
;
 
get_correct_answer(3399) -> 2
;
 
get_correct_answer(3400) -> 3
;
 
get_correct_answer(3401) -> 1
;
 
get_correct_answer(3402) -> 3
;
 
get_correct_answer(3403) -> 4
;
 
get_correct_answer(3404) -> 1
;
 
get_correct_answer(3405) -> 1
;
 
get_correct_answer(3406) -> 1
;
 
get_correct_answer(3407) -> 4
;
 
get_correct_answer(3408) -> 2
;
 
get_correct_answer(3409) -> 4
;
 
get_correct_answer(3410) -> 1
;
 
get_correct_answer(3411) -> 3
;
 
get_correct_answer(3412) -> 1
;
 
get_correct_answer(3413) -> 4
;
 
get_correct_answer(3414) -> 2
;
 
get_correct_answer(3415) -> 4
;
 
get_correct_answer(3416) -> 3
;
 
get_correct_answer(3417) -> 3
;
 
get_correct_answer(3418) -> 2
;
 
get_correct_answer(3419) -> 3
;
 
get_correct_answer(3420) -> 3
;
 
get_correct_answer(3421) -> 1
;
 
get_correct_answer(3422) -> 2
;
 
get_correct_answer(3423) -> 1
;
 
get_correct_answer(3424) -> 4
;
 
get_correct_answer(3425) -> 2
;
 
get_correct_answer(3426) -> 3
;
 
get_correct_answer(3427) -> 3
;
 
get_correct_answer(3428) -> 3
;
 
get_correct_answer(3429) -> 2
;
 
get_correct_answer(3430) -> 1
;
 
get_correct_answer(3431) -> 3
;
 
get_correct_answer(3432) -> 2
;
 
get_correct_answer(3433) -> 1
;
 
get_correct_answer(3434) -> 2
;
 
get_correct_answer(3435) -> 3
;
 
get_correct_answer(3436) -> 2
;
 
get_correct_answer(3437) -> 1
;
 
get_correct_answer(3438) -> 4
;
 
get_correct_answer(3439) -> 3
;
 
get_correct_answer(3440) -> 2
;
 
get_correct_answer(3441) -> 1
;
 
get_correct_answer(3442) -> 2
;
 
get_correct_answer(3443) -> 3
;
 
get_correct_answer(3444) -> 4
;
 
get_correct_answer(3445) -> 1
;
 
get_correct_answer(3446) -> 3
;
 
get_correct_answer(3447) -> 1
;
 
get_correct_answer(3448) -> 3
;
 
get_correct_answer(3449) -> 2
;
 
get_correct_answer(3450) -> 3
;
 
get_correct_answer(3451) -> 2
;
 
get_correct_answer(3452) -> 3
;
 
get_correct_answer(3453) -> 2
;
 
get_correct_answer(3454) -> 1
;
 
get_correct_answer(3455) -> 3
;
 
get_correct_answer(3456) -> 2
;
 
get_correct_answer(3457) -> 4
;
 
get_correct_answer(3458) -> 3
;
 
get_correct_answer(3459) -> 2
;
 
get_correct_answer(3460) -> 4
;
 
get_correct_answer(3461) -> 2
;
 
get_correct_answer(3462) -> 1
;
 
get_correct_answer(3463) -> 3
;
 
get_correct_answer(3464) -> 1
;
 
get_correct_answer(3465) -> 3
;
 
get_correct_answer(3466) -> 3
;
 
get_correct_answer(3467) -> 2
;
 
get_correct_answer(3468) -> 4
;
 
get_correct_answer(3469) -> 1
;
 
get_correct_answer(3470) -> 1
;
 
get_correct_answer(3471) -> 1
;
 
get_correct_answer(3472) -> 1
;
 
get_correct_answer(3473) -> 2
;
 
get_correct_answer(3474) -> 1
;
 
get_correct_answer(3475) -> 2
;
 
get_correct_answer(3476) -> 3
;
 
get_correct_answer(3477) -> 3
;
 
get_correct_answer(3478) -> 3
;
 
get_correct_answer(3479) -> 1
;
 
get_correct_answer(3480) -> 4
;
 
get_correct_answer(3481) -> 3
;
 
get_correct_answer(3482) -> 2
;
 
get_correct_answer(3483) -> 1
;
 
get_correct_answer(3484) -> 3
;
 
get_correct_answer(3485) -> 4
;
 
get_correct_answer(3486) -> 2
;
 
get_correct_answer(3487) -> 2
;
 
get_correct_answer(3488) -> 2
;
 
get_correct_answer(3489) -> 4
;
 
get_correct_answer(3490) -> 3
;
 
get_correct_answer(3491) -> 4
;
 
get_correct_answer(3492) -> 3
;
 
get_correct_answer(3493) -> 1
;
 
get_correct_answer(3494) -> 4
;
 
get_correct_answer(3495) -> 3
;
 
get_correct_answer(3496) -> 2
;
 
get_correct_answer(3497) -> 1
;
 
get_correct_answer(3498) -> 3
;
 
get_correct_answer(3499) -> 2
;
 
get_correct_answer(3500) -> 3
;
 
get_correct_answer(3501) -> 1
;
 
get_correct_answer(3502) -> 2
;
 
get_correct_answer(3503) -> 3
;
 
get_correct_answer(3504) -> 2
;
 
get_correct_answer(3505) -> 4
;
 
get_correct_answer(3506) -> 3
;
 
get_correct_answer(3507) -> 2
;
 
get_correct_answer(3508) -> 1
;
 
get_correct_answer(3509) -> 4
;
 
get_correct_answer(3510) -> 3
;
 
get_correct_answer(3511) -> 1
;
 
get_correct_answer(3512) -> 1
;
 
get_correct_answer(3513) -> 3
;
 
get_correct_answer(3514) -> 3
;
 
get_correct_answer(3515) -> 3
;
 
get_correct_answer(3516) -> 2
;
 
get_correct_answer(3517) -> 2
;
 
get_correct_answer(3518) -> 3
;
 
get_correct_answer(3519) -> 1
;
 
get_correct_answer(3520) -> 4
;
 
get_correct_answer(3521) -> 2
;
 
get_correct_answer(3522) -> 3
;
 
get_correct_answer(3523) -> 1
;
 
get_correct_answer(3524) -> 4
;
 
get_correct_answer(3525) -> 2
;
 
get_correct_answer(3526) -> 1
;
 
get_correct_answer(3527) -> 1
;
 
get_correct_answer(3528) -> 3
;
 
get_correct_answer(3529) -> 4
;
 
get_correct_answer(3530) -> 4
;
 
get_correct_answer(3531) -> 2
;
 
get_correct_answer(3532) -> 1
;
 
get_correct_answer(3533) -> 1
;
 
get_correct_answer(3534) -> 4
;
 
get_correct_answer(3535) -> 4
;
 
get_correct_answer(3536) -> 4
;
 
get_correct_answer(3537) -> 3
;
 
get_correct_answer(3538) -> 1
;
 
get_correct_answer(3539) -> 3
;
 
get_correct_answer(3540) -> 3
;
 
get_correct_answer(3541) -> 1
;
 
get_correct_answer(4001) -> 3
;
 
get_correct_answer(4002) -> 3
;
 
get_correct_answer(4003) -> 2
;
 
get_correct_answer(4004) -> 1
;
 
get_correct_answer(4005) -> 1
;
 
get_correct_answer(4006) -> 2
;
 
get_correct_answer(4007) -> 1
;
 
get_correct_answer(4008) -> 2
;
 
get_correct_answer(4009) -> 2
;
 
get_correct_answer(4010) -> 3
;
 
get_correct_answer(4011) -> 1
;
 
get_correct_answer(4012) -> 1
;
 
get_correct_answer(4013) -> 2
;
 
get_correct_answer(4014) -> 1
;
 
get_correct_answer(4015) -> 2
;
 
get_correct_answer(4016) -> 3
;
 
get_correct_answer(4017) -> 3
;
 
get_correct_answer(4018) -> 2
;
 
get_correct_answer(4019) -> 1
;
 
get_correct_answer(4020) -> 3
;
 
get_correct_answer(4021) -> 1
;
 
get_correct_answer(4022) -> 2
;
 
get_correct_answer(4023) -> 2
;
 
get_correct_answer(4024) -> 2
;
 
get_correct_answer(4025) -> 2
;
 
get_correct_answer(4026) -> 3
;
 
get_correct_answer(4027) -> 1
;
 
get_correct_answer(4028) -> 1
;
 
get_correct_answer(4029) -> 3
;
 
get_correct_answer(4030) -> 4
;
 
get_correct_answer(4031) -> 2
;
 
get_correct_answer(4032) -> 1
;
 
get_correct_answer(4033) -> 1
;
 
get_correct_answer(4034) -> 1
;
 
get_correct_answer(4035) -> 3
;
 
get_correct_answer(4036) -> 3
;
 
get_correct_answer(4037) -> 2
;
 
get_correct_answer(4038) -> 2
;
 
get_correct_answer(4039) -> 1
;
 
get_correct_answer(4040) -> 1
;
 
get_correct_answer(4041) -> 1
;
 
get_correct_answer(4042) -> 2
;
 
get_correct_answer(4043) -> 2
;
 
get_correct_answer(4044) -> 3
;
 
get_correct_answer(4045) -> 3
;
 
get_correct_answer(4046) -> 2
;
 
get_correct_answer(4047) -> 2
;
 
get_correct_answer(4048) -> 1
;
 
get_correct_answer(4049) -> 1
;
 
get_correct_answer(4050) -> 2
;
 
get_correct_answer(4051) -> 1
;
 
get_correct_answer(4052) -> 2
;
 
get_correct_answer(4053) -> 3
;
 
get_correct_answer(4054) -> 4
;
 
get_correct_answer(4055) -> 2
;
 
get_correct_answer(4056) -> 3
;
 
get_correct_answer(4057) -> 1
;
 
get_correct_answer(4058) -> 2
;
 
get_correct_answer(4059) -> 1
;
 
get_correct_answer(4060) -> 1
;
 
get_correct_answer(4061) -> 4
;
 
get_correct_answer(4062) -> 3
;
 
get_correct_answer(4063) -> 3
;
 
get_correct_answer(4064) -> 2
;
 
get_correct_answer(4065) -> 4
;
 
get_correct_answer(4066) -> 1
;
 
get_correct_answer(4067) -> 1
;
 
get_correct_answer(4068) -> 3
;
 
get_correct_answer(4069) -> 2
;
 
get_correct_answer(4070) -> 3
;
 
get_correct_answer(4071) -> 2
;
 
get_correct_answer(4072) -> 2
;
 
get_correct_answer(4073) -> 3
;
 
get_correct_answer(4074) -> 1
;
 
get_correct_answer(4075) -> 1
;
 
get_correct_answer(4076) -> 3
;
 
get_correct_answer(4077) -> 4
;
 
get_correct_answer(4078) -> 1
;
 
get_correct_answer(4079) -> 2
;
 
get_correct_answer(4080) -> 4
;
 
get_correct_answer(4081) -> 2
;
 
get_correct_answer(4082) -> 4
;
 
get_correct_answer(4083) -> 1
;
 
get_correct_answer(4084) -> 3
;
 
get_correct_answer(4085) -> 2
;
 
get_correct_answer(4086) -> 3
;
 
get_correct_answer(4087) -> 4
;
 
get_correct_answer(4088) -> 1
;
 
get_correct_answer(4089) -> 2
;
 
get_correct_answer(4090) -> 3
;
 
get_correct_answer(4091) -> 2
;
 
get_correct_answer(4092) -> 1
;
 
get_correct_answer(4093) -> 2
;
 
get_correct_answer(4094) -> 3
;
 
get_correct_answer(4095) -> 1
;
 
get_correct_answer(4096) -> 2
;
 
get_correct_answer(4097) -> 3
;
 
get_correct_answer(4098) -> 3
;
 
get_correct_answer(4099) -> 2
;
 
get_correct_answer(4100) -> 4
;
 
get_correct_answer(4101) -> 2
;
 
get_correct_answer(4102) -> 3
;
 
get_correct_answer(4103) -> 2
;
 
get_correct_answer(4104) -> 4
;
 
get_correct_answer(4105) -> 1
;
 
get_correct_answer(4106) -> 4
;
 
get_correct_answer(4107) -> 1
;
 
get_correct_answer(4108) -> 2
;
 
get_correct_answer(4109) -> 3
;
 
get_correct_answer(4110) -> 1
;
 
get_correct_answer(4111) -> 4
;
 
get_correct_answer(4112) -> 2
;
 
get_correct_answer(4113) -> 3
;
 
get_correct_answer(4114) -> 2
;
 
get_correct_answer(4115) -> 2
;
 
get_correct_answer(4116) -> 3
;
 
get_correct_answer(4117) -> 2
;
 
get_correct_answer(4118) -> 1
;
 
get_correct_answer(4119) -> 1
;
 
get_correct_answer(4120) -> 3
;
 
get_correct_answer(4121) -> 2
;
 
get_correct_answer(4122) -> 3
;
 
get_correct_answer(4123) -> 3
;
 
get_correct_answer(4124) -> 2
;
 
get_correct_answer(4125) -> 2
;

get_correct_answer(_Arg) ->
    ?ASSERT(false, [_Arg]),
    null.

