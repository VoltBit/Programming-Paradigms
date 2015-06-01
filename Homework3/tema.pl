/*
 * Compact flows are represented as lists of bindings, and each binding
 * is actually a list of two elements, the first being the field name
 * and the second - the expected value or the 'any' atom.
 *
 * A special compact flow is 'cvoid' - the null compact flow.
 * While the rest of the compact flows are lists with the length equal
 * with the number of fields in the problem, the null flow is only this
 * atom.
 *
 * Flows are represented by lists meaning reunions of compact flows.
 *
 * Example 1:
 * The flow [[[src, 1], [dst, 3]], [[src, 2], [dst, 3]]]
 * means the reunion of the two compact flows, each
 * having the destination field set to 3.
 * 
 * Example 2:
 * The flow []
 * is the null flow.
 *
 * Please manually compile Prolog if the PlUnit module is not available
 * under linux (uninstall the one from the package manager first to be
 * sure it doesn't trigger any conflicts).
 *
 *  git clone git://prolog.cs.vu.nl/home/pl/git/pl.git
 *  cd pl
 *  ./configure # Answer 'yes' at the first question, then '3' at the second
 *  make
 *  sudo make install
 *
 * And then, inside the interpreter:
 * :- ['tema.pl', 'checker.plt']
 * :- run_tests.
 *
 * 
 * Under Windows, the SWI-Prolog program has PlUnit built-in.
 */


/*
 * setCf(+cflow, +header_name, +value, -cflow_out)
 *
 * Overwrite a field value in a compact flow
 * The set function works on cflows that contain precisely two bindings - a source and a destination.
 * I did not tke into accound cflows that contain a 'port' element.
 * H,T - the first and second bindings in the flow.
 */

setCf([H,T], Hn, V, O):- H = [Hn,_], O = [[Hn,V],T], !; T = [Hn,_], O = [H,[Hn,V]].
%% setCf([[S|V1],[D|V2]], Hn, V, [[S|V],[D|V2]]):- Hn = S, 

%% cflow:[[], []]
/*
 * set(+flow, +header_name, +value, -flow_out)
 * Overwrite a field value in a flow
 *
 */
%% set([[P,S,D]|T],Hn, V, O):- setCf([S,D],Hn,V,O), set(T, Hn, V, O).
%% set([[P,S,D]|T],Hn, V, O):- setCf([S,D],Hn,V,Op), set(T, Hn, V, O).
%% set([H|T], Hn, V, O):- setCf(H, Hn, V, Op), set(T, Hn,V, O).
set([],[],_,[]).
set([],_,_,[]).
set([[P,S,D]|T], Hn, V, [[P|Op]|O]):- set(T, Hn, V, O), setCf([S,D], Hn, V, Op), !.
set([[S,D]|T], Hn, V, [Op|O]):- set(T, Hn, V, O), setCf([S,D], Hn, V, Op), !.
set(_, _, _, _).

/******************** Misc list functions ******************************/
/*
 * rmDup(+in_list, -out_list)
 *
 * Removes duplicates from a list. 
 *
 * The membership test to the rest of the set is the one present in the member/2
 * implementation.
 * The cut below is to simplify the tests (no choicepoint means deterministic testing).
 */
%% rmDup(_, _).
rmDup([],[]).
%% rmDup([],[_]).
%% rmDup(_,[]).
rmDup([H|T], [H|R]):- not(member(H,T)), rmDup(T,R), !.
rmDup([H|T], R):- member(H,T), rmDup(T,R), !.

/*
 * rmVal(+in_list, +in_term, -out_list)
 *
 * Removes all instances of the in_term from the in_list
 */
%% rmVal(_, _, _).
rmVal([],_,[]).
rmVal([H|T], E, R):- H = E, rmVal(T,E,R), !.
rmVal([H|T], E, [H|R]):- rmVal(T,E,R), !.

/******************** Intersection ******************************/
/*
 * intCf(+cflow1, +cflow2, -out)
 *
 * Compact flow intersection. If the flows are disjoint, the
 * 'cvoid' atom is returned.
 */

%% intCf([[]], [[]], R)
intCf([],[],[]):- !.
intCf([[H,V]|T1], [[H,any]|T2], [[H,V]|R]):- intCf(T1,T2,R).
intCf([[H,any]|T1], [[H,V]|T2], [[H,V]|R]):- intCf(T1,T2,R).
intCf([[H,V]|T1], [[H,V]|T2], [[H,V]|R]):- intCf(T1,T2,R).
intCf([[H1,V1]|_], [[H2,V2]|_], R):- H1 = H2, not(V1 = any), not(V2 = any), not(V1 = V2), R = cvoid, !.
%% intCf([[H,V1]|_], [[H,V2]|_], R):- not(member([H,_],R)), not(V1 = V2), R = cvoid.
%% intCf([[H1,_]|_], [[H2,_]|_], R):- not(H1 = H2), R = cvoid.
%% intCf(_,[],R):- R = cvoid, !.
%% intCf([],_,R):- R = cvoid, !.

%% intCf(_, _, _).

/*
 * inter(+flow1, +flow2, -flow_out)
 *
 * Flow intersection.
 * If the flows are disjoint, the [] is returned.
 */

inter([],[],[]):- !.
inter([],_,[]):- !.
inter(_,[],[]):- !.
inter([H1|T1], [H2|T2], [H|R]):- intCf(H1,H2,H), not(H = cvoid), inter(T1,T2,R), !.
inter([_|T1], [_|T2], R):- inter(T1,T2,R).

%% inter([H1|T1], [H2|T2], [H|R]):- H = H1, inter(T1,T2,R).

%% inter(_, _, _).

/******************** Overwriting ******************************/
/*
 * modify(+flow_in, +new_bindings, -flow_out)
 *
 * Overwrite the bindings to the new values.
 * This will be used in implementing ovr network functions
 */
modify(_,[],_):- !.
modify(Flow, [[Header, Val] | TBindings], R):- modify(Flow, TBindings, R), set(Flow, Header, Val, R), !.
%% modify(_, _, _).

/******************** Subset ******************************/
/*
 * subsetCf(+cflow1, +cflow2)
 *
 * This predicate returns true if cflow1 is a subset of cflow2
 */

/* receives a binding and a list of bindings (cflow) */
bindingMembers(X,[X|_]).
bindingMembers([Header, _],[[Header,any]|_]).
bindingMembers([Header, Val], [_|T]):- bindingMembers([Header, Val], T).

subsetCf([],_).
subsetCf([H1|F1], F2):- bindingMembers(H1,F2), subsetCf(F1,F2), !.

%% subsetCf(_, _).

/*
 * subset(+flow1, +flow2)
 *
 * This predicate returns true if flow2 fully contains flow1.
 */

/* Receives two cflows and */
%% goThrough([H|Cflow1], Cflow2):- bindingMembers(H, Cflow2), goThrough(Cflow1, Cflow2).

/* Receives a cflow and a flow and tells is the cflow is member of the flow. */
cflowMember(X,[X|_]).
cflowMember(Cflow, [Hcf|Flow]):- subsetCf(Cflow, Hcf), !; cflowMember(Cflow, Flow).

subset([],_).
subset([H1|F1], F2):- cflowMember(H1, F2), subset(F1,F2), !.

%% subset(_, _).


/******************** Rule generation *************************/

/*
 * genericRule(M, F, O).
 *
 * A basic unit of our model. These may be instantiated manually
 * (as in the test below) or being asserted from a wireRule.
 *
 * The tree parameters of a generic rule are
 * Match - for a rule to match an inbound flow, the flow
 *		has to be a subset of this parameter (also a flow).
 *
 * Filter -  after a rule matches, the inbound flow is intersected
 *		with the filter flow, so that some compact flows may be dropped
 *
 * Ovr - a filtered flow should then have some values overwritten.
 *
 * ------------
 * In this example we are using two fields for each flow:
 * port - the physical port where the packet is placed
 * dst - the destination of the packet
 */

/*
 * A wireRule(R1, R2) receives two ports (physical endpoints)
 * and matches the traffic coming to the first endpoint (R1)
 * and overwrites the field 'port' to R2, representing the
 * traffic on the other endpoint.
 *
 * wireRules are instantiated by the testing suite.
 */

/*
 * Write a predicate to deduce a genericRule from a wireRule
 */

genericRule(_, _, _) :- wireRule(_, _).

/*
 * nf(+flow_in, -flow_out)
 *
 * Apply a matching network function on the flow and output the results.
 */
nf(_, _).

/******************** Reachability *************************/
/*
 * reach(+src, -out, aux)
 *
 * The 'aux' term of the predicate may be used in your implementation
 * as you wish. The initial 'reach' call will set it to the empty list.
 *
 * The 'out' term should return, each time, a flow which is derived by applying
 * network functions over the input flow or over other results.
 */
reach(_, _, _).

/*
 * reachAll(+src, -out)
 *
 * Compute all the reachable flows starting with the reachAll.
 *
 * hint: findAll
 */
reachAll(_, _).

/*
 * Loop detect
 *
 * Returns 'true' if there's a cyclic path inside the connected
 * component of the graph that contains the flow
 *
 * Bonus task,
 */
loop(_).

/*
 *
 * DO NOT EDIT THE FILE BELOW THIS POINT
 *
 */

:- style_check(-discontiguous).

/******************** Ring sample network *************************/
wireRule(p1, p2).
wireRule(p2, p3).
wireRule(p3, p1).

/******************** Bus sample network *************************/
wireRule(p10, p11).
wireRule(p11, p12).
wireRule(p12, p13).

/******************** Star sample network *************************/
wireRule(p20, p21).
wireRule(p20, p22).
wireRule(p20, p23).
wireRule(p20, p24).

/******************** Firewalled server *************************/
wireRule(p30, p31).
genericRule([[[port, p31], [dst, any]]], [[[port, any], [dst, p33]]], [[port, p32]]).
wireRule(p32, p33).

/******************** Proxy demo *************************/
wireRule(p40, p41).
genericRule([[[port, p41], [dst, any]]], [[[port, any], [dst, p41]]], [[port, p42], [dst, p49]]).
wireRule(p42, p49).

:- load_test_files([]).
