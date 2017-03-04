-module(week2dot13).
-export([nub/1, bun/1, nub2/1, removeAll2/2]).
-spec nub([T]) -> [T].
-spec bun([T]) -> [T].


% FIRST OCCURRENCE SOLUTION

nub([]) ->
  [];

nub([H|T]) ->
  [H|removeAll(T, H)].

removeAll([H|T], Comparared)  when H =/= Comparared ->
  nub([H|T]);

removeAll([H|T], H) ->
  removeAll(T, H);

removeAll([], _Comparared) ->
  [].



% IMPROVED SOLUTION

nub2([]) ->
  [];

nub2([H|T]) ->
  [H|nub2(removeAll2(T, H))].

removeAll2([], _Comparared) ->
  [];

removeAll2([H|T], H) ->
  removeAll2(T, H);

removeAll2([H|T], Comparared) ->
  [H | removeAll2(T, Comparared)].


% LAST OCCURRENCE SOLUTION
bun([]) ->
  [];

bun([H|T]) ->
  case member(H, T) of
    true -> bun(T);
    false ->[H | bun(T)]
  end.

member(_X, []) ->
  false;

member(H, [H| _T]) ->
  true;

member(X, [_H| T]) ->
  member(X, T).
