-module(week2dot18).
-export([mergeSort/1]).

mergeSort([]) ->
  [];

mergeSort([H]) ->
  [H];

mergeSort(List) when is_list(List) ->
  {Array1, Array2} = lists:split(trunc(myLength(List)/2), List),
  merge(mergeSort(Array1), mergeSort(Array2)).

merge([], List) ->
  List;

merge(List, []) ->
  List;

merge([H1| T1], [H2| T2]) when H1 =< H2 ->
  [H1| merge( T1 , [H2|T2])];


merge([H1| T1], [H2| T2]) when H1 > H2 ->
  [H2 | merge( T2 , [H1|T1])].



% the median of a list of numbers: this is the middle element when the list is ordered (if the list
% is of even length you should average the middle two)
myLength([]) ->
  0;

myLength([_H | T]) ->
  1 + myLength(T).
