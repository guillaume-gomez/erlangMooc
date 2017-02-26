-module(ex).
-export([perimeter/1, area/1,  enclose/1, bitSum/1, bitSumR/1]).

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

% We can see that triangle data structure can be generalized for any shape. So a shape could be represented like this
% {shape, [{ vertex, {X1, Y1} }, { vertex, {X2, Y2} }, { vertex, {X3, Y3} }, ..., { vertex, {XN, YN} }] }
% Note: we assume that the vertices are ordered contiguously in the array.

% So the function perimeter can be extended :

% perimeter({shape, [Vertices]}) ->
perimeter({shape, [H|Q]}) ->
  iterateVertex(H, [H|Q]).

% A tool function to compute the length of an edge
distance(X1,Y1, X2, Y2) ->
  math:sqrt(math:pow(X1 - X2, 2) + math:pow(Y1 - Y2, 2)).

% iterateVertex(FirstVertex, [Vertices]).
iterateVertex({ vertex, {X1, Y1} } , [{ vertex, {X2, Y2} }]) ->
  distance(X1, Y1, X2, Y2);

iterateVertex(H, L) ->
  [{ vertex, {X1, Y1} }, { vertex, {X2, Y2} } |  Q] = L,
  distance(X1, Y1, X2, Y2) + iterateVertex(H, [{ vertex, {X2, Y2} } | Q]).

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
% -> 17.071067811865476
%ex:perimeter({ shape,[{ vertex, {0, 0} }, { vertex, {0, 5} }, { vertex, {5, 0} }] }).
% -> 17.071067811865476
%ex:perimeter({ shape,[{ vertex, {0, 0} }, { vertex, {0, 5} }, { vertex, {5, 5} } ,{ vertex, {5, 0} }] }).
% -> 20

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
%ex:area({ shape,[{ vertex, {0, 0} }, { vertex, {0, 5} }, { vertex, {5, 5} } ,{ vertex, {5, 0} }] }).
% -> 12.5

% I could not manage the area function for any shape, because the results depends on sereral parameters.(Is the shape concave or convex ? Is it a regular polygon ? )


% Enclose

% For simple shapes
enclose({rectangle, {X, Y}, W, H}) ->
  {rectangle, {X, Y}, W, H};


enclose({square, {X, Y}, W}) ->
  {rectangle, {X, Y}, W, W};


enclose({rhombus, {X, Y}, W}) ->
  {rectangle, {X, Y}, W, W};

enclose({circle, {X, Y}, R}) ->
  {rectangle, {X, Y}, R, R};

% For generic shape
enclose({_, [{vertex, {X, Y} }|Q]}) ->
  enclose([{vertex, {X, Y} }|Q], X, X, Y, Y).


enclose([ {vertex, {X, Y} }|Q], XMin, XMax, YMin, YMax) ->
  NewXmin = min(X, XMin),
  NewXMax = max(X, XMax),
  NewYMin = min(Y, YMin),
  NewYMax = max(Y, YMax),
  enclose(Q, NewXmin, NewXMax, NewYMin, NewYMax);

enclose([], XMin, XMax, YMin, YMax) ->
  CenterX = (XMin + XMax)/2,
  CenterY = (YMin + YMax)/2,
  { rectangle, { CenterX, CenterY }, distance(XMin, 0, XMax, 0), distance(0, YMin, 0, YMax) }.


% examples
% ex:enclose({ shape,[{ vertex, {0, 0} }, { vertex, {0, 5} }, { vertex, {5, 5} } ,{ vertex, {5, 0} }] }).
% --> {rectangle,{2.5,2.5},5.0,5.0}
% ex:enclose({rectangle,{5,5}, 5, 2 }).
% --> {rectangle,{2.5,2.5},5.0,5.0}
% ex:enclose({square,{5,5}, 5 }).
% --> {rectangle,{5,5},5,5}
%ex:enclose({rhombus,{5,5}, 5 }).
% --> {rectangle,{5,5},5,5}
% ex:enclose({circle,{5,5}, 10 }).
% --> {rectangle,{5,5},10,10}


% Summing the bits
%tail recursive version
bitSum(N) ->
  bitSum(N, 0).

bitSum(0, Acc) -> Acc;

bitSum(N, Acc) ->
  bitSum(N div 2 , Acc + N rem 2).

% direct recursive version
bitSumR(0) -> 0;

bitSumR(N) ->
  bitSumR(N div 2) + N rem 2.


% Which do you think is better? Why?
% tail recursive is more efficiant than direct recursive because it optimizes the stack view : no intermediate states.
