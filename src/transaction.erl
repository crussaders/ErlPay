%%%-------------------------------------------------------------------
%%% @author manishkumarpandey
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Aug 2026 7:32 pm
%%%-------------------------------------------------------------------
-module(transaction).
-author("manishkumarpandey").

%% API
-export([create/3]).

create(FromAccount, ToAccount, Amount) ->
  #{
    id => generate_id(),
    from => maps:get(id, FromAccount),
    to => maps:get(id, ToAccount),
    amount => Amount,
    status => success
  }.

generate_id() ->
  integer_to_binary(erlang:unique_integer([positive])).