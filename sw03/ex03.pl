% a)
add_tail(X, [], [X]).

add_tail(X, [H | T], [H | T1]) :-
    add_tail(X, T, T1).

% add_tail(x, [a, b, c], L).

% b)
del([], _, []).

del([X | T], X, T1) :-
    del(T, X, T1).

del([H | T], X, [H | T1]) :-
    H \= X,
    del(T, X, T1).

% del([a, b, c, a, d, a], a, L).

% c)
mem_d(X, L) :- del(L, X, L1), L \= L1.

% mem_d(a, [a, b, c]).
% mem_d(x, [a, b, c]).

% d)
rev_acc([], A, A).
rev_acc([H | T], A, R) :- rev_acc(T, [H | A], R).

% rev_acc([a, b, c, d], [], L).

% e)
rev(L, R) :- rev_acc(L, [], R).
