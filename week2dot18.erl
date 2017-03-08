-module(week2dot18).
-export([say/2, join/1, mergeSort/1, member/2]).

say([],[]) ->
  [];

say([],String) ->
  String;

say(String, []) ->
  String;

say([H| T], String) ->
  [H | say(T, String)].

join([]) ->
  [];

join([H |T]) ->
  say(H,join(T)).

member(_, []) ->
  false;

member(Val, [Val | _T]) ->
  true;

member(Val, [H| T]) ->
  member(Val, T).

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
