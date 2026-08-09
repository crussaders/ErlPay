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
-export([create/2, deposit/2, withdraw/2, balance/1, can_withdraw/2]).

create(Id, Name) ->
  #{
    id => Id,
    name => Name,
    balance => 0
  }.

deposit(Account, Amount) when Amount >0 ->
  CurrentBalance = maps:get(balance, Account),
  Account#{balance => CurrentBalance + Amount};

deposit(_Account, _Amount) ->
  {error, invalid_Amount}.

%%% Amount > 0 is a guard
withdraw(Account, Amount) when Amount > 0 ->
  CurrentBalance = maps:get(balance, Account),

  case CurrentBalance >= Amount of
    true ->
      NewAccount = Account#{balance => CurrentBalance - Amount},
      {ok, NewAccount};

    false ->
      {error, insufficient_funds}
  end;

withdraw(_Account, _Amount) ->
  {error, invalid_amount}.

can_withdraw(Account, Amount) when Amount > 0 ->
  CurrentBalance = maps:get(balance, Account),
  CurrentBalance >= Amount;

can_withdraw(_Account, _Amount) ->
  false.

balance(Account) ->
  maps:get(balance, Account).