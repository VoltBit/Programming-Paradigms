
studies(gigle,aa).
studies(giigle,aa).
len(L,R):- L=[],R = 0.
len(L,R):- L=[_|T], len(T,Rp), R is 1+Rp.

rev(L,R):- L=[], R = [].
rev([H|T],R):- rev(T,Rp), append(Rp,[H],R).

%% test1(L,R):-

member(X,[X|_]).
member(M,[_|T]):- member(M,T).
a2b([],[]).
a2b([a|Ta],[b|Tb]):- a2b(Ta,Tb).

second(M,[_,M | _]).
%% second(M,[_,S | T]):- second(M,[S|T]).

swap12([H1|T1],[H2|T2], R1, R2):- T1 = T2, R1 = [H1|T2], R2 = [H2|T1].

tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine). 

%% listtran([Hg|Tg],E):- listtran(Tg,E), tran(Hg,X), E = [X|E].
listtran([],[]).
listtran([Hg|Tg],[He|Te]):- tran(Hg,He), listtran(Tg,Te).

twice([],[]).
twice([H|T],[Ho,Ho|To]):- Ho = H, twice(T,To).

combine1([],[],[]).
combine1([H1|T1],[H2|T2],[H1,H2|T3]):- combine1(T1,T2,T3).


combine2([],[],_).
combine2([H1|T1],[H2|T2],R):- combine2(T1,T2,Rp), R = [[H1,H2]|Rp].

%% firstTwo(_,_,[]).
%% firstTwo(_,_,[_]).
firstTwo(X,Y,[_,_|T],R):- R = [X,Y|T].
%% firstTwo(X,Y,[E1,E2|T],[Rh1,Rh2|Rt]):- Rh1 = X, Rh2 = Y, Rt = T.

not(contains(_,[])).
%% contains(_,[]).
%% contains(E,E|_).
contains(E,[M|T]):- M = E; contains(E,T).

%% append([],[],_).
append([],L,L).
%% append(L,[],L).
append([H1|T1],L2,[H1|L3]):- append(T1,L2,L3).

prefix(P,L):- append(P,_,L).
suffix(S,L):- append(_,S,L).

sublist(SubL,L):- suffix(S,L), prefix(SubL,S).

%% rev2(L,Acc,R):- rev2(L,[],R).
rev2([H|T],A,R):- rev2(T,[H|A],R). 
rev2([],A,A).

check(X):- X = [H|T], H = T, [T,1] = X.

