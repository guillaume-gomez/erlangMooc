-module(rock_paper_scissors).
-export([beat/1, lose/1, result/2, tournament/2, play/1, expand/1, rock/1]).

-spec beat(atom()) -> atom().
-spec lose(atom()) -> atom().
-spec outcome(atom()) -> atom().
-spec tournament(list(number()), list(number())) -> number().

% Give the play which the arguments beats

beat(rock) ->
  paper;

beat(paper) ->
  scissors;

beat(scissors) ->
  rock;

beat(_) ->
  error.

% Give the play which the arguments loses

lose(rock) ->
  scissors;

lose(scissors) ->
  paper;

lose(paper) ->
  rock;

lose(_) ->
  error.

% Compute the result of a play

result(Move, Move) ->
  draw;

result(Move1, Move2) ->
  case beat(Move2) of
    Move1 -> win;
    _ -> lose
  end.

% tool function to convert atom into integer and vise versa
outcome(draw) ->
  0;

outcome(win) ->
  1;

outcome(lose) ->
  -1.

val(0) ->
  draw;

val(1) ->
  win;

val(-1) ->
  lose.

% compute an array of plays

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


% Strategies from the live coding 

echo([]) ->
  paper;

echo([Last | _]) ->
  Last.

rock(_) ->
  rock.

no_repeat([]) ->
  scissors;

no_repeat([H | _]) ->
  beat(H).

const(Play) ->
  fun(_) -> Play end.

cycle(List) ->
  val(length(List) rem 3).

rand_(_) ->
  val(rand:uniform(3) - 1).

%
% Interactively play against a strategy, provided as argument
%

play(Strategy) ->
  io:format("Rock - Paper - Scissors ~n"),
  io:format("Play one of rock, paper, scissors; ... ~n"),
  io:format("... r, p, s, stop, followed by '.' ~n"),
  play(Strategy,[]).


play(Strategy, Moves) ->
  {ok, P} = io:read("Play: "),
  Play = expand(P),
  case Play of
    stop ->
      io:format("Stopped~n");
    _ ->
      Result = result(Play, Strategy(Moves)),
      io:format("Result: ~p~n", [Result]),
      play(Strategy,[Play|Moves])
  end.

expand(paper) -> paper;
expand(p) -> paper;

expand(rock) -> rock;
expand(r) -> rock;

expand(scissors) -> scissors;
expand(s) -> scissors;

expand(stop) -> stop;

expand(_) ->
  io:format("Wrong command ~n"),
  stop.