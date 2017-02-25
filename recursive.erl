-module(recursive).
-export([fib/1, pieces/1]).

fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N - 1) + fib(N - 2).


pieces(0) -> 1;
pieces(1) -> 2;
pieces(N) -> N + pieces(N-1).x


multipieces(0,_) -> 1;
multipieces(X,1) -> X+1;
multipieces(X,N) ->
  multipieces(X-1,N) + multipieces(X-1,N-1).