-module(week3dot5).
-export([doubleAll/1, evens/1, product/1]).
-spec doubleAll(list(number())) -> list(number()).
-spec evens(list(integer())) -> list(integer()).
-spec product(list(number())) -> number().

doubleAll(List) ->
  lists:map(fun double/1, List).

double(X) ->
  2 * X.

% week3dot5:doubleAll([1,3,5,7,9]).
% [2,6,10,14,18]

evens(List) ->
  lists:filter(fun is_even/1, List).

is_even(Number) ->
  Number rem 2 == 0.

% week3dot5:evens([1,3, 2,5,7,8,9]).
% [2,8]


product(List) ->
  lists:foldr(fun prod/2, 1, List).

prod(X, Acc) ->
  X * Acc.

% week3dot5:product([1,2,3,4]).
% 24