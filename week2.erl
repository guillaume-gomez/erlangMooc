-module(week2).
%uncomment this command if you want to test each function separately
-compile(export_all).
%-export([get_file_contents/1, parse/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
  {ok,File} = file:open(Name,[read]),
  Rev = get_all_lines(File,[]),
  lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File,Partial) ->
  case io:get_line(File,"") of
      eof -> file:close(File),
            Partial;
      Line -> {Strip,_} = lists:split(length(Line)-1,Line),
            get_all_lines(File,[Strip|Partial])
  end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
 show_file_contents([]) ->
    ok.


%% My personnal work %%

% display the output %
display_indexes([]) ->
  ok;

display_indexes([H|T]) ->
  io:format("~p~n",[H]),
  display_indexes(T).


% parse the file passed as parameter%
parse(Filename) ->
  parse(Filename, false).

parse(Filename, GetData) ->
  Content = get_file_contents("mytest.txt"), %get_file_contents(Filename),
  WordsByLines = parse_line(Content),
  Words = nub(lists:merge(WordsByLines)),
  Result = create_indexes(Words, WordsByLines),
  case GetData of
     false -> display_indexes(mySort(Result));
     true  -> mySort(Result)
   end.

parse_line([]) ->
  [];

parse_line([H|T]) ->
  [split_words(H)| parse_line(T)].

% Example
% week2:parse_line(["First line of the text.", "Second line","Conclusion"]).
%-> [["first","line","text"],["second","line"],["conclusion"]]

% count the number of occurence of the 'Word' in a line
count_word(Word, Line) ->
  count_word(Word, Line, 0).

count_word(_, [], Count) ->
  Count;

count_word(Word, [Word| T], Count) ->
  count_word(Word, T, Count + 1);

count_word(Word, [_H| T], Count) ->
  count_word(Word, T, Count).

% Example
% week2:count_word("foo", ["This", "is", "an", "example", "of", "foo", "count_word.", "foo", "foo"]).
% 3
% week2:count_word("foobar", ["This", "is", "an", "example", "of", "foo", "count_word.", "foo", "foo"]).
% 0
%%%

% Split each word in each line
split_word([]) ->
  [];

split_word(Content) ->
  split_word(Content, []).

split_word([H| T], List) ->
  case lists:member(H," ") of
    true -> {lists:reverse(List), T};
    false -> split_word(T, [H | List])
  end;

split_word([], List) ->
  {lists:reverse(List), []}.

% Example
% week2:split_word("Lorem Ipsum is simply dummy text of the printing and typesetting industry.").
%{"Lorem", "Ipsum is simply dummy text of the printing and typesetting industry."}

split_words([]) ->
  [];

% change 4 by 3
split_words(Content) ->
  {Word, Remain} = split_word(Content),
  Result = limit_split(nocaps(nopunct(Word)), 3),
  clean_list([ Result| split_words(Remain)]).

% Example
% week2:split_words("Lorem Ipsum is simply dummy text of the printing and typesetting industry.").
% ["lorem","ipsum","simply","dummy","text","printing", "typesetting","industry"]
%

%  remove in split_words words of length less than Size
limit_split(Word, Size) when length(Word) >= Size ->
  Word;

limit_split(_Word, _Size) ->
  "".

% Example
% week2:limit_split("jjj",3).
% "jjj"
% week2:limit_split("jjjj",3).
% "jjjj"
% week2:limit_split("jj",3).
% []
%

clean_list([[]| T]) ->
  clean_list(T);

clean_list([H| T]) ->
  [ H | clean_list(T)];

clean_list([]) ->
  [].

% Method from  week 2.15
nopunct([]) ->
  [];

nopunct([H| T]) ->
  case lists:member(H, " .,\;\\:\t\n`\"('!?)") of
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


% Method from week 2.13
nub([]) ->
  [];

nub([H|T]) ->
  [H|nub(remove_all(T, H))].

remove_all([], _Compared) ->
  [];

remove_all([H|T], H) ->
  remove_all(T, H);

remove_all([H|T], Compared) ->
  [H | remove_all(T, Compared)].


% Create an array with the lines where the word occurs.

count_occurence_in_text(Content, Word) ->
  count_occurence_in_text(Content, 1, Word).

count_occurence_in_text([], LineCount, Word) ->
  [];

count_occurence_in_text([H|T], LineCount, Word) ->
  case count_word(Word, H) of
    0 ->
      count_occurence_in_text(T, LineCount + 1, Word);
    _ ->
      [LineCount | count_occurence_in_text(T, LineCount + 1, Word)]
  end.

% Example
% week2:count_occurence_in_text([["lorem","ipsum","simply","dummy","text"],["lorem", "text"], [""], ["lorem"]], "lorem").
% [1,2,4]
%

% format the previous array as expected array
format_occurence([]) ->
  [];

format_occurence([H|T]) ->
  format_occurence(H, H, T).


format_occurence(Begin, Compared, []) ->
  [{Begin, Compared}];

format_occurence(Begin, Compared, [H|T]) ->
  case Compared + 1 == H of
    true -> format_occurence(Begin, H, T);
    false -> [{Begin, Compared} | format_occurence(H, H, T)]
  end.

% Example
% week2:format_occurence([1,2,4]).
% [{1,2},{4,4}]
%

% create an index in the parsing function
create_index(Word, Occurences) ->
  {Word, Occurences}.

create_indexes([], _) ->
  [];

create_indexes([H|T], Content) ->
  io:format("~p~n", [Content]),
  [create_index(H, format_occurence(count_occurence_in_text(Content, H))) |create_indexes(T, Content)].

% Example
% week2:create_indexes(["lorem"], [["lorem", "ipsum"],[""], ["lorem", "again"], ["lorem"]]).
% [{"lorem",[{1,1},{3,4}]}]
%

% sort alphabetically result of parse
mySort(List) ->
  Func = fun({Word1, _}, {Word2, _}) ->
    Word1 < Word2
  end,
  lists:sort(Func, List).

% Example
% week2:mySort([{"lorem",[{1,1},{3,4}]}, {"ispum",[{1,1},{3,4}]}, {"and",[{1,1},{3,4}]} ]).
% [
 % {"and",[{1,1},{3,4}]},
 % {"ispum",[{1,1},{3,4}]},
 % {"lorem",[{1,1},{3,4}]}]
%]
%
