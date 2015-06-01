
%% pair(_,[],[]).
%% pair(E, [X|XS], Pairs):- pair(E, XS, Rest), Pairs = [[E,X], Rest].

%% cartesian([], _, []).
%% cartesian([X|XS], Y, Prod):- pair(X,Y,Pairs), cartesian(XS,Y,S), append(Pairs, Rest, Prod).

%% union([], X, X).
%% union([X|XS], Y, U):- member(X,Y), union(XS, Y, Aux), U = [X|Aux].
%% union([X|XS], Y, U):- member(X,Y), union(XS, Y, U).


%% %% {1,2,3} => {vid, {1},{2},{3},{1,2},{1,3},{2,3},{1,2,3}}

%% %% # la multimea vida powersetul este multimea vida
%% %% {vid} =>{vid, {3}} => {vid, {3},{2},{2,3}} => {vid,{3},{2},{2,3},{1},{1,2},{1,2},{1,2,3}}

%% pow([],[[]]).
%% pow([X|XS],[[]]).

%% %% # Faci powersetul lui [X|XS] si apoi faci  o functie care primeste o lista de liste si un element si la fiecare element din lista de liste adauga elementul in fata

%% insAll(_,[],[]).
%% insAll(X,[H|T],Rez):- insAll(X,T,R), Rez = [[X|H],R].

%% powerset([],[[]]).
%% powerset([H|T], Power):- powerset(T, Aux), insAll(H,Aux,A), append(Aux,A,Power).

%% putEverywhere(X, L, [X|L]).
%% putEverywhere(X, [H|T], [H|T1]):- putEverywhere(X,T,T1).
%% perm([],[]).
%% perm([H|T], Y):- perm(T,U), putEverywhere(H,U,Y).

%% %% comb(N, L1, L2).

%% %% -> tradus: in U daca bagam undeva pe H se ajunge la Y

%% %% combinari :
%% [1,2,3]
%% [1,2,3]
%% [1,3,4]
%% [2,3,4]

comb(0,_,[]).
comb(N,[X|XS],[X|Comb]):- N>0,N1 is N-1,comb(N,XS,Comb).
comb(N,[_|XS],comb(N,XS,Comb)):- N>0, comb(N,XS,Comb).
