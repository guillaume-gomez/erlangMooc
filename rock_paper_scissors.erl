-module(rock_paper_scissors).
-export([beat/1, lose/1, result/2, tournament/2]).

-spec beat(atom()) -> atom().
-spec lose(atom()) -> atom().
-spec outcome(atom()) -> atom().
-spec tournament(list(number()), list(number())) -> number().

beat(rock) ->
  paper;

beat(paper) ->
  scissors;

beat(scissors) ->
  rock;

beat(_) ->
  error.


lose(rock) ->
  scissors;

lose(scissors) ->
  paper;

lose(paper) ->
  rock;

lose(_) ->
  error.


result(Move, Move) ->
  draw;

result(Move1, Move2) ->
  case beat(Move2) of
    Move1 -> win;
    _ -> lose
  end.

outcome(draw) ->
  0;

outcome(win) ->
  1;

outcome(lose) ->
  -1.


tournament([], _) ->
  0;

tournament(_, []) ->
  0;

tournament(List1, List2) ->
  lists:foldr(
    fun add/2,
    0,
    lists:zipwith(fun result_and_outcome/2, List1, List2)
  ).

result_and_outcome(Move1, Move2) ->
  outcome(result(Move1, Move2)).

add(H, Acc) ->
  H + Acc.

