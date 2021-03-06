-module(week3dot5).
-export([doubleAll/1, evens/1, product/1, zip/2, zip_with/3, zip_with/2, zip_/2]).

-spec doubleAll(list(number())) -> list(number()).
-spec evens(list(integer())) -> list(integer()).
-spec product(list(number())) -> number().
-spec zip(list(number()), list(number())) -> list(tuple()).
-spec zip_with(fun((T1, T2) -> T3),list(T1), list(T2)) -> list(T3).

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

% a) Define a function zip/2 that “zips together” pairs of elements from two lists like this:
zip(_ ,[]) ->
  [];

zip([], _) ->
  [];

zip([H1| T1], [ H2 | T2]) ->
  [{H1, H2} | zip(T1,T2)].

% week3dot5:zip([1,3,5,7], [2,4]).
% [ {1,2}, {3,4} ]

zip_with(_F, [], _) ->
  [];

zip_with(_F, _, []) ->
  [];

zip_with(F, [H1|T1], [H2|T2]) ->
  [ F(H1, H2) | zip_with(F, T1, T2)].
% week3dot5:zip_with(fun(X,Y) -> X+Y end, [1,3,5,7], [2,4]).
%[ 3, 7 ]

zip_with(List1, List2) ->
  lists:map(fun add/1, zip(List1, List2)).

add({X, Y}) ->
  X + Y.

% week3dot5:zip_with([1,3,5,7], [2,4]).
%[ 3, 7 ]


% c) Re-define the function zip_with/3 using zip and lists:map.


% d) Re-define zip/2 using zip_with/3.

zip_(List1, List2) ->
  zip_with(fun(X,Y) -> { X, Y} end, List1, List2).






