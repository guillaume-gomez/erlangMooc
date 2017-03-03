-module(week2dot9).
-export([double/1, evens/1, evensT/1, median/1, myLength/1, mergeSort/1]).

% Transforming list elements
% Define an Erlang function double/1 to double the elements of a list of numbers.

double([]) ->
  [];


double([H | T]) ->
  [H * 2 | double(T)].


%   Filtering lists
% Define a function evens/1 that extracts the even numbers from a list of integers.

evens([]) ->
  [];

evens([H | T]) when H rem 2 == 0 ->
  [H |  evens(T) ];

evens([_H| T]) ->
  evens(T).


evensT(List) ->
  evensT(List, []).


% in this pattern, the list entered in terminal clause with a reverse list
% if a reverse the second clause as  "evensT(T, [List| H]);". I have a list like this [ [ [ [], 2],4],8]

evensT([], List) ->
  lists:reverse(List);

evensT([H | T], List) when H rem 2 == 0 ->
  evensT(T, [H | List]);

evensT([_H | T], List) ->
  evensT(T, List).

median(List) ->
  median(lists:sort(List), 0, myLength(List)).

median([First | _T ], Increment, Length) when Length rem 2 == 1 , Length div 2 == Increment  ->
  First;

median([First, Second | _T ], Increment, Length) when Length rem 2 == 0 , Length div 2 == (Increment + 1)  ->
  (First + Second) / 2;

median([_h | T], Increment, Length) ->
  median(T, Increment + 1, Length).

% the modes of a list of numbers: this is a list consisting of the numbers that occur most frequently in the list; if there is is just one, this will be a list with one element only


% Tool methods


% partially works
mergeSort([H| []]) ->
  H;

mergeSort(List) when is_list(List) ->
  Middle = myLength(List) div 2,
  Array1 = lists:sublist(List, Middle),
  Array2 = lists:sublist(List, Middle+1, Middle+1),
  merge(mergeSort(Array1), mergeSort(Array2)).

merge([], List) ->
  List;

merge(List, []) ->
  List;

merge(Val1, Val2) when Val1 =< Val2 ->
  [Val1, Val2];

merge(Val1, Val2) when Val1 > Val2 ->
  [Val2, Val1];

merge([H1| T1], [H2| T2]) when H1 =< H2 ->
  [H1, merge( T1 , [H2|T2])];


merge([H1| T1], [H2| T2]) when H1 > H2 ->
  [H2, merge( T2 , [H1|T1])].



% the median of a list of numbers: this is the middle element when the list is ordered (if the list is of even length you should average the middle two)
myLength([]) ->
  0;

myLength([_H | T]) ->
  1 + myLength(T).
