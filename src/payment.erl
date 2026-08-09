%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Aug 2026 10:09 pm
%%%-------------------------------------------------------------------
-module(payment).
-author("manishkumarpandey").

%% API
-export([transfer/3]).

transfer(FromAccount, ToAccount, Amount) when Amount > 0 ->
  case account:withdraw(FromAccount, Amount) of
    {ok, UpdatedFromAccount} ->
      UpdatedToAccount = account:deposit(ToAccount, Amount),
      {ok, UpdatedFromAccount, UpdatedToAccount};

    {error, Reason} ->
      {error, Reason}
  end;
transfer(_FromAccount, _ToAccount, _Amount) ->
  {error, invalid_Amount}.
