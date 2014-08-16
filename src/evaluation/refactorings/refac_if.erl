%%%-------------------------------------------------------------------
%%% @author Roberto Souto Maior de Barros Filho <>
%%% @copyright (C) 2014, Roberto S. M. de Barros Filho, Simon  Thompson
%%% @doc 
%% If - Where possible, simplifies if expressions by the result of their evaluation. This refactoring uses Wrangler API and can be found in <em>Wrangler -> Refactor -> gen_refac Refacs -> Symbolic Evaluation -> If</em>.
%%
%% Examples of usage:
%% <ul>
%% <li>
%% <em>
%%if<br/>
%%<div class="first_align">
%%false -> [2];<br/>
%%true -> []<br/>
%%</div>
%%end.<br/>
%% </em>
%% <strong>is simplified to</strong> <em>[]</em>.
%% </li>
%% <li>
%% <em>
%% begin <br/>
%% <div class="first_align">
%%    X = true,<br/>
%%    if<br/>
%% <div class="second_align">
%%	X -> [2];<br/>
%%	true -> []<br/>
%% </div>
%%    end<br/>
%% </div>
%% end.<br/>
%% </em>
%% <strong>becomes</strong> <br/>
%% <em>
%% begin <br/>
%% <div class="first_align">
%%    X = true,<br/>
%%    [2]<br/>
%% </div>
%% end.<br/>
%% </em>
%% </li>
%% </ul>
%%
%%@end
-module(refac_if).
-behaviour(gen_refac).

%% Include files
-include_lib("wrangler/include/wrangler.hrl").

%%%===================================================================
%% gen_refac callbacks
-export([input_par_prompts/0,select_focus/1, 
	 check_pre_cond/1, selective/0, 
	 transform/1]).

%%%===================================================================
%%% gen_refac callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Prompts for parameter inputs
%%
%% @spec input_par_prompts() -> [string()]
%% @end
%%--------------------------------------------------------------------
input_par_prompts() -> refac:input_par_prompts().

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Select the focus of the refactoring.
%%
%% @spec select_focus(Args::#args{}) ->
%%                {ok, syntaxTree()} |
%%                {ok, none}
%% @end
%%--------------------------------------------------------------------
select_focus(Args) -> refac:select_focus(Args).

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Check the pre-conditions of the refactoring.
%%
%% @spec(check_pre_cond(Args::args{}) -> ok | {error, Reason})
%% @end
%%--------------------------------------------------------------------
check_pre_cond(_Args) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Selective transformation or not.
%%
%% @spec selective() -> boolean()
%% @end
%%--------------------------------------------------------------------
selective() ->
    false.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function does the actual transformation.
%%
%% @spec transform(Args::#args{}) -> 
%%            {ok, [{filename(), filename(), syntaxTree()}]} |
%%            {error, Reason}
%% @end
%%--------------------------------------------------------------------
transform(Args)-> 
    refac:try_call_transform(Args, fun core_if:rules/2).
