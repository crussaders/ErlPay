%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Aug 2026 5:40 pm
%%%-------------------------------------------------------------------
-module(payment_sup).
-author("manishkumarpandey").

-behavior(supervisor).


%% API
-export([start_link/0]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE},?MODULE,[]).

init([]) ->
  TransactionServer = #{
    id => transaction_server,
    start => {
      transaction_server,
      start_link,
      []
    },
    restart => permanent,
    shutdown => 5000,
    type => worker
  },
  PaymentServer = #{
    id => payment_server,
    start => {
      payment_server,
      start_link,
      []
    },
    restart => permanent,
    shutdown => 5000,
    type => worker
  },

  {ok , {
    {one_for_one, 5, 10},
    [TransactionServer, PaymentServer]
  }}.
