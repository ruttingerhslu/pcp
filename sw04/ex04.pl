:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(http/http_json)).  % Use http_json for automatic parsing
:- use_module(library(clpfd)).

% --- relationship ---
female(mary). female(liz). female(mia). female(tina). female(ann). female(sue).% all females
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim). % all males
parent(mary, mia). parent(mary, fred). parent(mary, tina). % all childern of mary
parent(mike, mia). parent(mike, fred). parent(mike, tina). % all children of mike
parent(liz, tom). parent(liz, joe). % allchildern of liz
parent(jack, tom). parent(jack, joe). % all childern of jack
parent(mia, ann). % all childern of mia
parent(tina, sue). parent(tina, jim). % all childern of tina
parent(tom, sue). parent(tom, jim). % all childern of tom

mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).

% mother(X, jim). 
% father(X, jim).
% parent(mary, X).

sibling(X, Y) :- parent(Z, X), parent(Z, Y).

grandmother(X, Y) :- mother(X, Z), parent(Z, Y).

% grandmother(X, jim).

offspring(X, Y) :- parent(Y, X).
offspring(X, Y) :- parent(Z, X), offspring(Z, Y).


% --- sudoku ---
sudoku(Rows) :-
    append(Rows, Vs), Vs ins 1..9,
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [A, B, C, D, E, F, G, H, I],
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I),
    maplist(label, Rows).

blocks([], [], []).
blocks([A, B, C|Bs1], [D, E, F|Bs2], [G, H, I|Bs3]) :-
    all_distinct([A, B, C, D, E, F, G, H, I]),
    blocks(Bs1, Bs2, Bs3).


% -- problem solver --
solve(Type, ID) :-
    atom_concat('http://localhost:16316/problem/', Type, URL),
    atomic_list_concat([URL, '/', ID], GET_URL),
    http_get(GET_URL, Data, [json_object(term)]),
    solve(Type, Data, Solution), 
    http_post(
        URL, 
        json(_{solution: Solution, id: ID}), _ , []
    ).

solve(relationship, json([_, firstPerson=X, relationship=Type, secondPerson=Y]), Solution) :-
    ( call(Type, X, Y) -> Solution = true ; Solution = false ).

solve(sudoku, json([_, sudoku=Sudoku]), Solution):-     
    replace_in_lists(Sudoku, Puzzle),
    Puzzle = [A, B, C, D, E, F, G, H, I],
    sudoku([A, B, C, D, E, F, G, H, I]),
    !,
    Solution = Puzzle.

replace_zeros([], []).
replace_zeros([H|T1], [H|T2]) :-
    H \= 0,
    !,
    replace_zeros(T1, T2).
replace_zeros([0|T1], [_|T2]) :-
    replace_zeros(T1, T2).

replace_in_lists([], []).
replace_in_lists([H|T1], [R|T2]) :-
    replace_zeros(H, R),
    replace_in_lists(T1, T2).

