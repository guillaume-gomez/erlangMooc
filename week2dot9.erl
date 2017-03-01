-module(week2dot9).
-export([double/1, evens/1, evensT/1]).

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
