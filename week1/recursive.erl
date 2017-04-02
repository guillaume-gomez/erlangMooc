-module(recursive).
-export([fib/1, pieces/1]).
-export([fib_t/3, perfect_number/1, perfect_number/3]).

fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N - 1) + fib(N - 2).


pieces(0) -> 1;
pieces(1) -> 2;
pieces(N) -> N + pieces(N-1).


multipieces(0,_) -> 1;
multipieces(X,1) -> X+1;
multipieces(X,N) ->
  multipieces(X-1,N) + multipieces(X-1,N-1).


fib_t(0, _ , Acc) -> Acc;
fib_t(N, Acc , Acc2) -> fib_t(N-1, Acc2, Acc + Acc2 ).


%fib_t(4, 0, 1) -->
%  fib_t(3,1, 1)
%  fib_t(2,1, 2)
%  fib_t(1, 2, 3)
%  fib_t(0, 3, 5)
% --> 5

perfect_number(N) ->
  perfect_number(N ,N - 1, 0).

perfect_number(N, 1, Acc) -> N == Acc + 1;

perfect_number(N, Div, Acc) when N rem Div == 0 ->
  perfect_number(N, Div - 1, Acc + Div).

perfect_number(N, Div, Acc) ->
  perfect_number( N, Div - 1, Acc);



%6=1+2+3
%for 6 :
%  perfect_number(6,5, 0)
%  perfect_number(6,4, 0)
%  perfect_number(6,3, 3)
%  perfect_number(6,2, 5)
%  perfect_number(6,1, 6)
