-module(week2).
-export([get_file_contents/1,show_file_contents/1, parse/1, split_words/1]).

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

%% My Answer %%
parse(Filename) ->
  [Hy| Content] = get_file_contents(Filename),
  io:format("~s~n",[Hy]),
  count_word("Lorem", Content).

% count_word(String, Content)
count_word(Word, Content) ->
  count_word(Word, Content, 0).

count_word(_, [], Count) ->
  Count;

count_word(Word, [Word| T], Count) ->
  count_word(Word, T, Count + 1);

count_word(Word, [_H| T], Count) ->
  count_word(Word, T, Count).


split_word([]) ->
  [];

split_word(Content) ->
  split_word(Content, []).

% 32 = space
split_word([H| T], List) ->
  case lists:member(H,[32]) of
    true -> {lists:reverse(List), T};
    false -> split_word(T, [H | List])
  end;

split_word([], List) ->
  {lists:reverse(List), []}.

split_words([]) ->
  [];

split_words(Content) ->
  {Word, Remain} = split_word(Content),
  [Word |  split_words(Remain)].


