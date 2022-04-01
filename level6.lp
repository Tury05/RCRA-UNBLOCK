#program initial.
block(a,vert, 3).
h(block(a,vert, 3), p(0, 2)).
block(b,vert, 2).
h(block(b,vert, 2), p(0, 3)).
block(c,vert, 3).
h(block(c,vert, 3), p(0, 5)).
block(d,hori, 2).
h(block(d,hori, 2), p(2, 0)).
block(e,vert, 2).
h(block(e,vert, 2), p(2, 3)).
block(f,vert, 2).
h(block(f,vert, 2), p(3, 1)).
block(g,hori, 2).
h(block(g,hori, 2), p(4, 2)).
#program final.
 goal :-h(block(d,hori, 2), p(2, 4)). 
 :- not goal.