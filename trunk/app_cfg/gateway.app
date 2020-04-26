%% auther:  
%% email: 
%% date: 2011.04.09
  
{   
    application, gateway,
    [   
        {description, "This is an sm game gateway."},   
        {vsn, "1.0a"},   
        {modules,
		[
			sm
		]},   
        {registered, [sm_gateway_sup]},   
        {applications, [kernel, stdlib, sasl]},   
        {mod, {sm_gateway_app, []}},   
        {start_phases, []}

	%%{env,[{logger_node, 'sm_logger@127.0.0.1'},
	%%	{db_host, "localhost"}, 
    %%    {db_port, 3306}, 
	%%	{db_conn_num, 1},
	%%	{bg_db_host, "localhost"},
    %%    {bg_db_port, 3306}, 
	%%	{bg_db_conn_num, 1}]
    %%    }
    ]   
}.    
 
%% File end.  
