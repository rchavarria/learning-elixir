{application,stack,
             [{description,"stack"},
              {vsn,"0.1.0"},
              {modules,['Elixir.Stack','Elixir.Stack.Server']},
              {applications,[kernel,stdlib,elixir,logger]},
              {mod,{'Elixir.Stack',[]}},
              {env,[{initial_stack,[1,2,3,4,5,6]}]},
              {registered,[stack]}]}.