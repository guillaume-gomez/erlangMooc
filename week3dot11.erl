-module(week3dot11).
-export([add/1,times/1,compose/2,id/1,iterate/1, sub/1, composer/1, twice/1, multByThree/0]).


%%
% Code base
%%

add(X) ->
    fun(Y) -> X + Y end.

times(X) ->
    fun(Y) ->
      X * Y end.

compose(F,G) ->
    fun(X) -> G(F(X)) end.

id(X) ->
    X.

iterate(0) ->
    dummy;
iterate(_N) ->
    dummy.


sub(X) ->
  fun(Y) -> X - Y end.


%%
% My work
%%

%%
% In the shell exercice
%%

% Add = fun(X,Y) -> X + Y end.
% #Fun<erl_eval.12.52032458>
% Add(2,4).
% 6
% Sum = fun(Xs) -> lists:foldr(fun(X,Y) -> X + Y end, 0, Xs) end.
% #Fun<erl_eval.6.52032458>
% Sum([1,2,3,4]).
% 10
% Sum2 = fun(Xs) -> lists:foldr(Add, 0, Xs) end.
% #Fun<erl_eval.6.52032458>
% Sum2([1,2,3,4]).
% 10
% EmptyTest = fun([]) -> true ; ([_H| _T]) -> false end.
% #Fun<erl_eval.6.52032458>
% EmptyTest([3,4]).
% false
% EmptyTest([]).
% true
% Foo = fun Product([]) -> 1; Product([H|T]) -> H * Product(T) end.
% #Fun<erl_eval.30.52032458>
% Foo([2,5]).
% 10
% Product([2,5]).
% * 1: variable 'Product' is unbound





%%
%% Composition
%%

% Non commutative
% S = week3dot11:compose(week3dot11:sub(7), week3dot11:sub(5)).
% S(3). = 1
% A = week3dot11:compose(week3dot11:sub(5), week3dot11:sub(7)).
% A(3). = 5


% Commutative
% A = week3dot11:compose(week3dot11:add(5), week3dot11:add(7)).
% A(3). = 15
% S = week3dot11:compose(week3dot11:add(7), week3dot11:add(5))
% S(3). = 15


composer([H| T]) ->
  lists:foldr(fun compose/2, H, T).



% S = week3dot11:composer([week3dot11:add(4), week3dot11:add(6), week3dot11:sub(3)]).
% S(3).
% -2
% D = week3dot11:composer([week3dot11:add(4), week3dot11:add(6)]).
% D(3).
% 13
% D(10).
% 20
% S(10).
% -9
% R = week3dot11:composer([week3dot11:add(4), week3dot11:sub(6)]).
% R(3).
% 7

%%
%%  Twice
%%


multByThree() ->
  fun(X) ->  X * 3 end.

twice(F) ->
  compose(F, F).

% week3dot11:twice(week3dot11:multByThree()).
% #Fun<week3dot11.2.42111034>
% X = week3dot11:twice(week3dot11:multByThree()).
% #Fun<week3dot11.2.42111034>
%  X(2).
% 18


% C = week3dot11:twice(week3dot11:twice(week3dot11:multByThree())).
% #Fun<week3dot11.2.42111034>
% C(2).  = 2 * 3 * 3 * 3 * 3
% 162


%
% Iteration
%




