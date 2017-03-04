-module(week2).
-export([get_file_contents/1,show_file_contents/1, parse/1, count_word/2, split_words/1, nopunct/1, count_occurence_in_text/2]).

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
parse(Filename) ->
  Content = get_file_contents("gettysburg-address.txt"), %get_file_contents(Filename),
  Words = parse_line(Content),
  lists:flatten(create_indexes(Words)).


parse_line([]) ->
  [];

parse_line([H|T]) ->
  [split_words(H)| parse_line(T)].

% count_word(String, Line)
count_word(Word, Line) ->
  count_word(Word, Line, 1).

count_word(_, [], Count) ->
  Count;

count_word(Word, [Word| T], Count) ->
  count_word(Word, T, Count + 1);

count_word(Word, [_H| T], Count) ->
  count_word(Word, T, Count).

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

split_words([]) ->
  [];

% change 2 by 3
split_words(Content) ->
  {Word, Remain} = split_word(Content),
  Result = limit_split(nopunct(Word), 6),
  clean_list([ Result| split_words(Remain)]).

limit_split(Word, Size) when length(Word) > Size ->
  Word;

limit_split(_Word, _Size) ->
  "".

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
  case lists:member(H, " .,\;\\:\t\n") of
    false -> [H | nopunct(T)];
    true -> nopunct(T)
  end.

count_occurence_in_text(Content, Word) ->
  count_occurence_in_text(Content, 1, Word).

count_occurence_in_text([H|T], LineCount, Word) ->
  case count_word(Word, H) of
    1 -> count_occurence_in_text(T, LineCount + 1, Word);
    _ -> [LineCount | count_occurence_in_text(T, LineCount + 1, Word)]
  end;

count_occurence_in_text([], _LineCount, Word) ->
  [].

create_index(Word, Occurences) ->
  {Word, Occurences}.

create_indexes_by_line([], _Content) ->
  [];

create_indexes_by_line([H|T], Content) ->
  [create_index(H, count_occurence_in_text(Content, H)) | create_indexes_by_line(T, Content)].

create_indexes(Content) ->
  create_indexes(Content, Content).

create_indexes([], _) ->
  [];

create_indexes([H|T], Content) ->
  [create_indexes_by_line(H, Content) |create_indexes(T, Content)].
