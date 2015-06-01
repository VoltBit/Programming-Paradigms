fT([E1,E2|R], E1, E2).
% fT([1,2,3],1,2).
% fT([1,2,3],X,Y). 

contains(X, [X|_]).
contains(X, [H|T]) :- contains(X,T).

ncontains(_, []).
ncontains(X, [H|T]) :- (X\=H), ncontains(X,T).

co(E, [E|_]).
co(E,[H|T]) :- co(E,T).

nodup([], []).
nodup([H|T], L) :- nodup(T,L), contains(H,L).

nodup2([],[]).
nodup2([H|T], [H|L]) :- nodup(T,L), ncontains(H,L).


nodup3(L, V, Lp) :- contains(E,L), nconains(E,V), nodup(L, [E|V], Lp).

% L = [1,1,2], Lp = [1,2], V- construita progresiv

is_sort(X, [], [X]).
is_sort(X, [H|T], [H|R]) :- X > H, is_sort(X,T,R).
is_sort(X, [X|T], [X|[H|T]]) :- X =< H.

insertion_s([],[]).
insertion_s([H|T], R) :- insertion_s(T,Rp), is_sort(H,Rp,R).

height(void,0)
height(node(L,_,R), N) :- height(L,N1), height(R,N2), N is (max(N1, N2) + 1).

%append - 3 liste : spune daca primele doua liste sunt ce-a de-ea treia

flatten(void, [])
flatten(node(L,K,R), List) :- flatten(L,L1), flatten(R,L2), append(L1, L2,_). %***<- e gresit!


% se da un arbore si o inaltime N

%arbori de executie ****
