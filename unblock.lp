%%Autores: Arturo Ramos Rey             arturo.ramos.rey@udc.es
%%         Adriano Miranda Seoane       adriano.miranda@udc.es
#const size = 6.

#program always.
    occupy(B, X..X+S-1, Y) :- h(block(B, vert, S), p(X,Y)).
    occupy(B, X, Y..Y+S-1) :- h(block(B, hori, S), p(X,Y)).

    ncells(-(size-1)..(size-1)).
    action(move(B, N)) :- block(B, _, _), ncells(N).
    
#program dynamic.
    % Action generation
    1 {o(A) : _action(A) } 1.

    %Effect axioms
    h(block(B, vert, S), p(X+N, Y)) :- 'h(block(B, vert, S), p(X, Y)), o(move(B, N)).
    h(block(B, hori, S), p(X, Y+N)) :- 'h(block(B, hori, S), p(X, Y)), o(move(B, N)).

    %Out of grid constraints
    :- h(_, p(X,_)), X<0.
    :- h(_, p(X,_)), X>size-1.
    :- h(block(B, vert, S), p(X,_)), X+S-1>size-1.
    :- h(_, p(_,Y)), Y<0.
    :- h(_, p(_,Y)), Y>size-1.
    :- h(block(B, hori, S), p(_,Y)), Y+S-1>size-1.

    %Ocupation constraints
    :- o(move(B,N)), 'h(block(B, vert, S), p(X, Y)), 'occupy(B', X..X+N+S-1, Y), B!=B', N>0.
    :- o(move(B,N)), 'h(block(B, hori, S), p(X, Y)), 'occupy(B', X, Y..Y+N+S-1), B!=B', N>0.
    :- o(move(B,N)), 'h(block(B, vert, S), p(X, Y)), 'occupy(B', X+N..X, Y), B!=B', N<0.
    :- o(move(B,N)), 'h(block(B, hori, S), p(X, Y)), 'occupy(B', X, Y+N..Y), B!=B', N<0.

    % Inertia: c(F,V)=value V(block position) has changed
    h(F,V) :- 'h(F,V), not c(F).
    c(F)   :- 'h(F,V), h(F,W), V!=W. 
    
    move(B,N) :- o(move(B, N)).

#program final.
    goal :- h(block(b, hori, 2), p(2, 2)).
    :- not goal.

#show move/2.