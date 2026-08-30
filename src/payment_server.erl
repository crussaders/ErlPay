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
  transfer/4,
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

transfer(IdempotencyKey,FromId, ToId, Amount) ->
  gen_server:call(
    payment_server,{transfer, IdempotencyKey, FromId, ToId, Amount}
  ).

deposit(Id, Amount) ->
  gen_server:call(payment_server,{deposit, Id, Amount}).

%%init([]) -> {
%%  ok, #{}
%%}.

%%with idempotency
init([]) ->
  State = #{
    accounts => #{},
    processed_payments => #{}
  },

  {ok, State}.

handle_call(
    {create_account, Id, Name},
    _From,
    State
) ->
  Accounts = maps:get(accounts, State),
  Account = account:create(Id, Name),
  NewAccounts = Accounts#{
    Id => Account
  },

  NewState = State#{
    accounts => NewAccounts
  },
  {reply, {ok, Account}, NewState};

handle_call(
    {get_account, Id},
    _From,
    State
) ->
  Accounts = maps:get(accounts, State),
  case maps:find(Id, Accounts) of
    {ok, Account} ->
      {reply, {ok, Account}, State};

    error ->
      {reply, {error, account_not_found}, State}
  end;

handle_call(
    {deposit, Id, Amount},
    _From,
    State
) ->

  Accounts = maps:get(accounts, State),
  case maps:find(Id, Accounts) of
    {ok, Account} ->
      case account:deposit(Account, Amount) of
        {ok, UpdatedAccount} ->
          NewAccounts = Accounts#{
            Id => UpdatedAccount
          },

          NewState = State#{
            accounts => NewAccounts
          },

          {reply,
            {ok, UpdatedAccount},
          NewState};

        {error, Reason} ->
          {reply,
            {error, Reason},
            State
          }
      end;

    error -> {
      reply,
      {error, account_not_found},
      State
    }
  end;

handle_call(
    {transfer,IdempotencyKey, FromId, ToId, Amount},
    _From,
    State
) ->

  ProcessedPayments = maps:get(processed_payments, State),

  case
%%    maps:find(FromId, Accounts),
%%    maps:find(ToId, Accounts),
    maps:find(IdempotencyKey, ProcessedPayments)
   of
    {ok, ExistingTransaction} ->
      {reply, {
        ok, ExistingTransaction
      }, State};
    error -> {Result, NewState} =
    process_transfer(IdempotencyKey, FromId, ToId, Amount, State),
      {
        reply,
        Result,
        NewState
      }
  end.

process_transfer(
    IdempotencyKey,
    FromId,
    ToId,
    Amount,
    State
) ->
  Accounts = maps:get(accounts, State),

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
        {ok, UpdatedFrom, UpdatedTo, Transaction} ->
          NewAccounts = Accounts#{
            FromId => UpdatedFrom,
            ToId => UpdatedTo
          },

          ProcesssedPayments =
          maps:get(processed_payments, State),

          NewProcessedPayments =
          ProcesssedPayments#{
            IdempotencyKey => Transaction
          },

          NewState = State#{
            accounts => NewAccounts,
            processed_payments => NewProcessedPayments
          },

          {{ok, Transaction}, NewState};

        {error, Reason} ->
          {{error, Reason}, State}
      end;

    _ ->
      {{error, account_not_found}, State}
  end.


handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason,_State) ->
  ok.

code_change(_OldVersion, State, _Extra) ->
  {ok, State}.