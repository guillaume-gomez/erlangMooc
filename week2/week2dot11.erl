-module(week2dot11).
-export([take/2]).
-spec take(integer(), [T]) -> [T].

take(0, String) ->
  [];

take(_N, []) ->
  [];

take(N, [H| T]) ->
  [H | take(N-1, T)].


% Examples
% take(0,"hello") = []

% take(4,"hello") = "hell"

% take(5,"hello") = "hello"

% take(9,"hello") = "hello"