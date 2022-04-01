#const size = 6.
ncells(-(size-1)..(size-1)).
action(move(B, N)) :- block(B, _, _), ncells(N).

#program initial.
    block(a, vert, 3).
    block(b, hori, 2).
    block(c, vert, 2).
    block(d, hori, 3).
    block(e, hori, 2).
    h(block(a, vert, 3), p(0, 3)).
    h(block(b, hori, 2), p(2, 0)). 
    h(block(c, vert, 2), p(4, 0)). 
    h(block(d, hori, 3), p(4, 2)). 
    h(block(e, hori, 2), p(5, 3)). 

#program always.
    
    occupy(block(B, vert, S), X..X+S-1, Y) :- h(block(B, vert, S), p(X,Y)).
    occupy(block(B, hori, S), X, Y..Y+S-1) :- h(block(B, hori, S), p(X,Y)).

    %Out of grid constraints
    :- h(_, p(X,_)), X<0.
    :- h(_, p(X,_)), X>size-1.
    :- h(block(B, vert, S), p(X,_)), X+S-1>size-1.
    :- h(_, p(_,Y)), Y<0.
    :- h(_, p(_,Y)), Y>size-1.
    :- h(block(B, hori, S), p(_,Y)), Y+S-1>size-1.

#program dynamic.
    % Action generation
    1 {o(A) : _action(A) } 1.

    %Effect axioms
    h(block(B, vert, S), p(X+N, Y)) :- 'h(block(B, vert, S), p(X, Y)), o(move(B, N)).
    h(block(B, hori, S), p(X, Y+N)) :- 'h(block(B, hori, S), p(X, Y)), o(move(B, N)).

    % Inertia: c(F,V)=value V(block position) has changed
    h(F,V) :- 'h(F,V), not c(F).
    c(F)   :- 'h(F,V), h(F,W), V!=W. 

#program final.
    goal :- h(block(b, hori, 2), p(2, 1)).
    :- not goal.

#show action/1.