%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <Crussader>
%%% @doc
%%%
%%% @end
%%% Created : 16. Aug 2026 6:31 pm
%%%-------------------------------------------------------------------
-module(payment_server).
-author("manishkumarpandey").

-behavior(gen_server).

%% API
-export([
  start_link/0,
  transfer/3,
  get_account/1,
  create_account/2,
  deposit/2
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

create_account(Id, Name) ->
  gen_server:call(
    payment_server,{create_account, Id, Name}
  ).

get_account(Id) ->
  gen_server:call(
    payment_server,{get_account, Id}
  ).

transfer(FromId, ToId, Amount) ->
  gen_server:call(
    payment_server,{transfer, FromId, ToId, Amount}
  ).

deposit(Id, Amount) ->
  gen_server:call(payment_server,{deposit, Id, Amount}).

init([]) -> {
  ok, #{}
}.

handle_call(
    {create_account, Id, Name},
    _From,
    Accounts
) ->
  Account = account:create(Id, Name),
  NewAccounts = Accounts#{
    Id => Account
  },
  {reply, {ok, Account}, NewAccounts};

handle_call(
    {get_account, Id},
    _From,
    Accounts
) ->
  case maps:find(Id, Accounts) of
    {ok, Account} ->
      {reply, {ok, Account}, Accounts};

    error ->
      {reply, {error, account_not_found}, Accounts}
  end;

handle_call(
    {deposit, Id, Amount},
    _From,
    Accounts
) ->
  case maps:find(Id, Accounts) of
    {ok, Account} ->
      case account:deposit(Account, Amount) of
        {ok, UpdatedAccount} ->
          NewAccounts = Accounts#{
            Id => UpdatedAccount
          },

          {reply,
            {ok, UpdatedAccount},
            NewAccounts};

        {error, Reason} ->
          {reply,
            {error, Reason},
            Accounts
          }
      end;

    error -> {
      reply,
      {error, account_not_found},
      Accounts
    }
  end;

handle_call(
    {transfer, FromId, ToId, Amount},
    _From,
    Accounts
) ->
  case {
    maps:find(FromId, Accounts),
    maps:find(ToId, Accounts)
  } of
    {{ok, FromAccount}, {ok, ToAccount}} ->
      case payment:transfer(
        FromAccount,
        ToAccount,
        Amount
      ) of
        {ok, UpdatedFrom, UpdateTo, Transaction} ->
          NewAccounts = Accounts#{
            FromId => UpdatedFrom,
            ToId => UpdateTo
          },
          {reply,
            {ok, Transaction},
            NewAccounts};
        {error, Reason} ->
          {reply,
            {error, Reason},
            Accounts}
      end;

    _ ->
      {reply,
        {error, account_not_found},
        Accounts}
  end.


handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason,_State) ->
  ok.

code_change(_OldVersion, State, _Extra) ->
  {ok, State}.