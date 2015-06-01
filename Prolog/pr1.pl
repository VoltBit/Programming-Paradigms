%% KB1:
woman(mia). 
woman(jody). 
woman(yolanda). 
%% playsAirGuitar(jody). 
party.

%% happy -> predicate
%% in KB2 there are 5 clauses, 3 rules and two facts

%% KB2:
happy(yolanda). %% predicate
listens2Music(mia). %% 
listens2Music(yolanda):-  happy(yolanda). 
playsAirGuitar(mia):-  listens2Music(mia). 
playsAirGuitar(yolanda):- listens2Music(yolanda).

happy(vincent). 
listens2Music(butch).
playsAirGuitar(vincent):- listens2Music(vincent), happy(vincent). 
playsAirGuitar(butch):- happy(butch).
playsAirGuitar(butch):- listens2Music(butch).

loves(vincent,mia).
loves(marsellus,mia).
loves(pumpkin,honey_bunny). 
loves(honey_bunny,pumpkin).

jealous(X,Y):- loves(X,Z), loves(Y,Z).

wizard(ron). 
hasWand(harry). 
quidditchPlayer(harry).  
hasBroom(X):-  quidditchPlayer(X).
wizard(X):-  hasBroom(X),  hasWand(X).

dodos(X,Y):- dodos(X,mia).


