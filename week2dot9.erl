-module(week2dot9).
-export([double/1]).

% Transforming list elements
% Define an Erlang function double/1 to double the elements of a list of numbers.

double([]) ->
  [];


double([H | T]) ->
  [H * 2 | double(T)].