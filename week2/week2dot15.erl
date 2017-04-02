-module(week2dot15).
-export([palin/1, palindrome/1]).
%-spec palindrome([List]) -> boolean().

palindrome(List) ->
  palin(nocaps(nopunct(List))).

palin([]) -> true;

palin([_T| []]) -> true;

palin([H | T]) ->
  case lastoccurence(T) of
    H -> palin(destroylastoccurence(T));
    _ ->
      false
  end.

lastoccurence([]) ->
  [];

lastoccurence([T| []]) ->
  T;

lastoccurence([_H | T]) ->
  lastoccurence(T).


destroylastoccurence([]) ->
  [];

destroylastoccurence([_T | []]) ->
  [];

destroylastoccurence([H|T]) ->
  [ H | destroylastoccurence(T)].

nopunct([]) ->
  [];

nopunct([H| T]) ->
  case lists:member(H, ".,\;:\t\n") of
    false -> [H | nopunct(T)];
    true -> nopunct(T)
  end.

nocaps([]) ->
  [];

nocaps([H|T]) ->
  [nocap(H) | nocaps(T)].

nocap(X) ->
  case $A =< X andalso X =< $Z of
    true -> X+32;
    false -> X
  end.



% Examples

% week2dot15:palindrome("a").
% true
% week2dot15:palindrome("aa").
% true
% week2dot15:palindrome("aaa").
% true
% week2dot15:palindrome("ata").
% true
% week2dot15:palindrome("tata").
% week2dot15:palindrome("Madam !").
% false
% week2dot15:palindrome("Madam .").
% false
% week2dot15:palindrome("Madam.").
% true

