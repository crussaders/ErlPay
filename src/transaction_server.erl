%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Aug 2026 8:32 pm
%%%-------------------------------------------------------------------
-module(transaction_server).
-author("manishkumarpandey").
-behavior(gen_server).

%% API
-export([start_link/0,
    save/1,
    get/1,
    list/0,
    stop/0
]).

-export([
  init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3
]).

start_link() ->
  gen_server:start_link(
    {local, ?MODULE},
    ?MODULE,
    [],
    []
  ).

init([]) ->
  Table = ets:new(transactions,[set, protected]),
  {ok, Table}.

save(Transaction) ->
  gen_server:call(transaction_server, {save, Transaction}).

get(Id) ->
  gen_server:call(transaction_server,{get, Id}).

list() ->
  gen_server:call(transaction_server, list).

stop() ->
  gen_server:call(transaction_server, stop).

handle_call({save, Transaction}, _From, Table) ->
  Id = maps:get(id, Transaction),
  ets:insert(Table, {Id, Transaction}),
  {reply, {ok, Transaction}, Table};

handle_call({get, Id}, _From, Table) ->
   case ets:lookup(Table, Id) of
     [{Id, Transaction}] ->
       {reply, {ok, Transaction}, Table};

     [] ->
       {reply, {error, not_found}, Table}
   end;

handle_call(list, _From, Table) ->
  Transactions = ets:tab2list(Table),
  {reply, Transactions, Table};

handle_call(stop, _From, Table) ->
  {stop, normal, ok, Table}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVersion, State, _Extra) ->
  {ok, State}.
