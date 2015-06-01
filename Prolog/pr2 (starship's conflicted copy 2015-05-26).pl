
studies(gigle,aa).
studies(giigle,aa).
len(L,R):- L=[],R = 0.
len(L,R):- L=[_|T], len(T,Rp), R is 1+Rp.

rev(L,R):- L=[], R = [].
rev([H|T],R):- rev(T,Rp), append(Rp,[H],R).

test1(L,R):-
