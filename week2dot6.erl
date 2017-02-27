-module(week2dot6).
-export([product/1, productT/1, maximum/1]).

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
maximum(1) -> 1.