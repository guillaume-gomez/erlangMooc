-module(recursive).
-export([fib/1, pieces/1]).
-export([fib_t/3]).

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