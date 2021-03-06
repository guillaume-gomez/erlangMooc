-module(rock_paper_scissors).
-export([beat/1, lose/1, result/2, tournament/2, play/1, expand/1, rock/1, create_count_moves/1, min_occur/1, max_occur/1]).
-define(Interacts, [rock, scissors, paper]).


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
  rock;

val(1) ->
  scissors;

val(-1) ->
  paper.

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

least([]) ->
  rock;

least(List) ->
  {Item, Val} = min_occur(List),
  Item.

most([]) ->
  rock;

most(List) ->
  {Item, Val} = max_occur(List),
  Item.

composeStrategy(F,G) ->
    fun(X) -> G(F(X)) end.

randomStrategy(ListOfStrategy) ->
  lists:nth(rand:uniform(length(ListOfStrategy)), ListOfStrategy).


% Tool methods %
create_count_moves(Moves) ->
  create_count_moves([rock, scissors, paper], Moves).

create_count_moves([], _Moves) ->
  [];

create_count_moves([H|T], Moves) ->
  [ {H, count_occur(Moves, H)} | create_count_moves(T, Moves)].


count_occur(List, Comparant) ->
  count_occur(List, Comparant, 0).

count_occur([], _Comparant, Val) ->
  Val;

count_occur([Comparant|T], Comparant, Val) ->
  count_occur(T, Comparant, Val + 1);

count_occur([H|T], Comparant, Val) ->
  count_occur(T, Comparant, Val).

filter_occur(F, [H|T]) ->
  filter_occur(F, [H|T], H).

filter_occur(_F,[],{Item, Val}) ->
  {Item, Val};

filter_occur(F,[{Item, H}|T], {_ItemStored, Val}) ->
  case F(H, Val) of
    true -> filter_occur(F,T, {Item, H});
    false -> filter_occur(F, T, {_ItemStored, Val})
  end.

min_occur(List) ->
  filter_occur(fun (X, Y) -> X =< Y end, List).

max_occur(List) ->
  filter_occur(fun (X, Y) -> X > Y end, List).

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

% Example
%rock_paper_scissors:play(fun () -> rock end)
%