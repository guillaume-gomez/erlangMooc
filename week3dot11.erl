-module(hof).
-export([add/1,times/1,compose/2,id/1,iterate/1]).

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
iterate(N) ->
    dummy.


%%
% My work
%%