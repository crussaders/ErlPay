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
      case account:deposit(ToAccount, Amount) of
      {ok, UpdatedToAccount} ->
        Transaction = transaction:create(UpdatedFromAccount, UpdatedToAccount, Amount),
        transaction_store:save(Transaction),
        {ok, UpdatedFromAccount, UpdatedToAccount, Transaction};

        {error, Reason} ->
          {error, Reason}
      end;
        {error, Reason} ->
          {error, Reason}
  end;
transfer(_FromAccount, _ToAccount, _Amount) ->
  {error, invalid_Amount}.
