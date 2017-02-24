-module(pattern_m).
-export([x_or/2, xOr/2, xOr2/2, xOr3/2, maxThree/3, howManyEqual/3]).

x_or(A, B) ->
  A =/= B.

xOr(A, B) ->
  (not(A) and B) or (A and not(B)).

xOr2(true, false) ->
  true;

xOr2(false, true) ->
  true;

xOr2(true, true) ->
  false;

xOr2(false, false) ->
  false.

xOr3(A, B) ->
  A == not(B).

maxThree(A, A, A) ->
  A;

maxThree(A, A, B) ->
  max(A, B);

maxThree(A, B, A) ->
  max(A, B);

maxThree(A, B, C) ->
  max(A, max(B, C)).

howManyEqual(A, A, A) ->
  3;

howManyEqual(A, A, _) ->
  2;

howManyEqual(_, A, A) ->
  2;

howManyEqual(_, _, _) ->
  0.
