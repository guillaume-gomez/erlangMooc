-module(week2dot6).
-export([product/1, productT/1, maximum/1,maximumT/1]).

% the product of a list
product([]) ->
  1;

product([H| T]) ->
  product(T) * H.


productT([], Sum) ->
  Sum;

productT([H|T], Sum) ->
  productT(T, H * Sum).

productT(List) ->
  productT(List, 1).


% the maximum of a list

maximumT([H|T]) ->
  maximumT(T, H).

maximumT([], Max) ->
  Max;

maximumT([H|T], Max) ->
  NewMax = max(H, Max),
  maximumT(T, NewMax).


maximum([H]) ->
  H;

maximum([H|T]) ->
  max(maximum(T), H).


% I find the direct recusion for the prodcut function. On the opposite, tail recursion seems more intuitive to implement for maximum