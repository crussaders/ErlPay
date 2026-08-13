%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Aug 2026 8:01 pm
%%%-------------------------------------------------------------------
-module(transaction_store).
-author("manishkumarpandey").

%% API
-export([start/0, stop/0, save/1, get/1, list/0]).

-define(TABLE, transactions).

start() ->
  case ets:info(?TABLE) of
    undefined ->
      ets:new(?TABLE, [named_table, set, public]),
      {ok, started};

    _ ->
      {ok, already_started}
  end.

stop() ->
  case ets:info(?TABLE) of
    undefined ->
      {error, not_started};

    _ ->
      ets:delete(?TABLE),
      ok
  end.

save(Transaction) ->
  Id = maps:get(id, Transaction),
  ets:insert(?TABLE, {Id, Transaction}),
  {ok, Transaction}.

get(Id) ->
  case ets:lookup(?TABLE, Id) of
    [{Id, Transaction}] ->
      {ok, Transaction};

    [] ->
      {error, not_found}
  end.

list() ->
  ets:tab2list(?TABLE).
