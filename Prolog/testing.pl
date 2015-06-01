%%  	
/*
	\x.y e = y[x/e] -> toate aparitiile lui x din y sunt inlocuite cu e
	(\x.(y (x x)) ) \x.y) =(ex1 ex2)
	ex1 = \x.(y (x x)) => (\x.y (\x.x \x.x)) => (\x.y \x.x) =>
		=> 
	ex2 = \x.y 

*/

%% mincinos(X):- cretan(X).
%% cretan(X):- minicions(X).
%% cretan(john).


%% f(K):- !,g(K).
%% g(K):- !,h(K).
%% f(a).
%% g(b).
%% h(c).
%% h(d).

%% q([X1,X2|T]).

%% f(a).
%% f(b).
%% g(a).
%% g(b).
%% q(X):- f(X), !, g(X).


%% mynot(K):- K,!,fail

insSort([],[],_).
insSort([H1|T1], [H2|T2], [H1|T3]):- H2 >= H1, insSort(T1,[H2|T2],T3).
insSort([H1|T1], [H2|T2], [H1|T3]):- H2 < H1, insSort([H1|T1],T2,T3).
insSort([],[H|L2],R):- insSort([],L2,[H|R]), !.
insSort([H|L1],[],R):- insSort([],L1,[H|R]), !.