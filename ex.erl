-module(ex).
-export([perimeter/1, area/1, bitSum/1, bitSumR/1]).

%Shapes
% let's is begin with simple shapes like square, rhombus, rectangle, and circle
perimeter({ square, {_X, _Y}, W }) ->
  W * 4;

perimeter({ rhombus, {_X, _Y}, W} ) ->
  W * 4;

perimeter({ rectangle, {_X, _Y}, W, H }) ->
  W * 2 + H * 2;

perimeter({ circle, {_X, _Y}, R }) ->
  2 * math:pi() * R;

% a triangle can be represented like this {triangle,[{vertex, {X1, Y1}}, {vertex, {X2, Y2}}, {vertex, {X3, Y3}}])
% the data is composed of an atom and an array of three vertices
perimeter({ triangle,[{ vertex, {X1, Y1} }, { vertex, {X2, Y2} }, { vertex, {X3, Y3} }] }) ->
  Edge1 = distance(X1, Y1, X2, Y2),
  Edge2 = distance(X1, Y1, X3, Y3),
  Edge3 = distance(X2, Y2, X3, Y3),
  Edge1 + Edge2 + Edge3;

perimeter({shape, Vertices}) ->
  iterateVertex(Vertices).

% A tool function de compute the length of an edge
distance(X1,Y1, X2, Y2) ->
  math:sqrt(math:pow(X1 - X2, 2) + math:pow(Y1 - Y2, 2)).


% Examples of perimeter for different shapes
%ex:perimeter({square,{5,5}, 25 }).
% -> 100
%ex:perimeter({rectangle,{5,5}, 25, 5 }).
% -> 60
%ex:perimeter({rhombus,{5,5}, 25 }).
% -> 100
%ex:perimeter({circle,{5,5}, 1 }).
% -> 6.283185307179586
%ex:perimeter({ triangle,[{ vertex, {0, 0} }, { vertex, {0, 5} }, { vertex, {5, 0} }] }).

area({ square, {_X, _Y}, W }) ->
  W * W;

area({ rhombus, {_X, _Y}, W} ) ->
  W * W;

area({ rectangle, {_X, _Y}, W, H }) ->
  W * H;

area({ circle, {_X, _Y}, R }) ->
  2 * math:pi() * R * R;

area({ triangle,[{ vertex, {X1, Y1} }, { vertex, {X2, Y2} }, { vertex, {X3, Y3} }] }) ->
  Edge1 = distance(X1, Y1, X2, Y2),
  Edge2 = distance(X1, Y1, X3, Y3),
  Edge3 = distance(X2, Y2, X3, Y3),
  % compute the perimeter as the previous version
  Sp =  (Edge1 + Edge2 + Edge3)/ 2,
  math:sqrt(Sp*(Sp - Edge1)*(Sp - Edge2)*(Sp - Edge3)).


% ex:area({square,{5,5}, 25 }).
% -> 625
% ex:area({square,{5,5}, 5 }).
% -> 25
% ex:area({rhombus,{5,5}, 5 }).
% -> 25
% ex:area({rectangle,{5,5}, 5, 2 }).
% -> 10
% ex:area({rectangle,{5,5}, 5, 3 }).
% -> 15
% ex:area({circle,{5,5}, 1 }).
% -> 6.283185307179586
% ex:area({circle,{5,5}, 2 }).
% -> 25.132741228718345
%ex:area({ triangle,[{ vertex, {0, 0} }, { vertex, {0, 5} }, { vertex, {5, 0} }] }).
% -> 12.5

% we can see that triangle data structure can be generalized for any shape. So a shape could be represented like this
% {shape, [{ vertex, {X1, Y1} }, { vertex, {X2, Y2} }, { vertex, {X3, Y3} }, ..., { vertex, {XN, YN} }] }

%[{ vertex, {0, 0} }, { vertex, {5, 0} }, { vertex, {0, 5} }]

% perimeter({shape, [Vertices]}) ->
%   iterateVertex([Vertices]).

iterateVertex([{ vertex, {X2, Y2} }]) ->
  %distance(X1, Y1, X2, Y2);
  0;

iterateVertex(L) ->
  [{ vertex, {X1, Y1} }, { vertex, {X2, Y2} } |  Q] = L,
  distance(X1, Y1, X2, Y2) + iterateVertex([{ vertex, {X2, Y2} } | Q]).



% Shapes
% Define a function perimeter/1 which takes a shape and returns the perimeter of the shape.

% Choose a suitable representation of triangles, and augment area/1 and perimeter/1 to handle this case too.

% Define a function enclose/1 that takes a shape an returns the smallest enclosing rectangle of the shape.



% Summing the bits
% Define a function bits/1 that takes a positive integer N and returns the sum of the bits in the binary representation. For example bits(7) is 3 and bits(8) is 1.

% See whether you can make both a direct recursive and a tail recursive definition.

% Which do you think is better? Why?



bitSum(N) ->
  bitSum(N, 0).


bitSum(0, Acc) -> Acc;

bitSum(N, Acc) ->
  bitSum(N div 2 , Acc + N rem 2).

bitSumR(0) -> 0;

bitSumR(N) ->
  bitSumR(N div 2) + N rem 2.