-module(week2dot9).
-export([double/1, evens/1, evensT/1, median/1, myLength/1, occur/2, modes/1]).

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

% the modes of a list of numbers: this is a list consisting of the numbers that occur most frequently
% in the list; if there is is just one, this will be a list with one element only
 
modes([]) ->
  [];

modes([H|T]) ->
  [ occur([H|T], H) | modes(remove(T, H))].


%modes([], _CurrentValue, _Increment) ->
  % 1.

% Tool methods

occur([], _Val) ->
  0;

occur(List, Val) ->
  occur(List, Val, 0).

occur([], _Val, Acc) ->
  Acc;

occur([H|T], H, Acc) ->
  occur(T, H, Acc + 1);

occur([H|T], Val, Acc) ->
  occur(T, Val, Acc).

remove([], _Val) ->
  [];

remove([H|T], H ) ->
  remove(T, H);

remove([H|T], Val) ->
  [ H | remove(T, Val)].


% the median of a list of numbers: this is the middle element when the list is ordered (if the list
% is of even length you should average the middle two)
myLength([]) ->
  0;

myLength([_H | T]) ->
  1 + myLength(T).
