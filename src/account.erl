%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Aug 2026 5:35 pm
%%%-------------------------------------------------------------------
-module(account).
-author("manishkumarpandey").

%% API
-export([create/2, deposit/2, withdraw/2, balance/1]).

create(Id, Name) ->
  #{
    id => Id,
    name => Name,
    balance => 0
  }.

deposit(Account, Amount) ->
  CurrentBalance = maps:get(balance, Account),
  Account#{balance => CurrentBalance + Amount}.

withdraw(Account, Amount) ->
  CurrentBalance = maps:get(balance, Account),
  Account#{balance => CurrentBalance - Amount}.

balance(Account) ->
  maps:get(balance, Account).