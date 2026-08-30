%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Aug 2026 9:10 pm
%%%-------------------------------------------------------------------
-module(concurrency_test).
-author("manishkumarpandey").

%% API
-export([run/0]).

run() ->
  spawn(fun() ->
    Result1 = payment_server:transfer(
      1001,
      1002,
      8000
    ),
    io:format(
      "Payment 1: ~p~n",
      [Result1]
    )
        end),

spawn(fun() ->
  Result2 = payment_server:transfer(
    1001,
    1003,
    7000
  ),
  io:format(
    "Payment 1: ~p~n",
    [Result2]
  )
      end),

  ok.

%%R1 = payment_server:transfer(
%%<<"PAY-001">>,
%%1001,
%%1002,
%%20000
%%).

