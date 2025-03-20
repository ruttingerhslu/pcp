:- use_module(library(clpr)). 
fib_clp(N, F) :- { N = 0, F = 0 }. 
fib_clp(N, F) :- { N = 1, F = 1 }. 
fib_clp(N, F) :-
    { N >= 2, F = F1+F2, N1 = N-1, N2 = N-2 }, 
    fib_clp(N1, F1),
    fib_clp(N2, F2).

% a) Stack limit wird erreicht.
% b) Unendliche Rekursion mit Lösungssuche die nicht aufhört: N: 1, 2, 3, 4, 5...
% c) Mit dem cut Operator kann verhindert werden dass weitere Lösungen gesucht werden.

% d)
fib(0, 1) :- !.
fib(1, 1) :- !.

fib(N, F) :-
    fib(1, 1, 1, N, F).

fib(_F, F1, N, N, F1) :- !.
fib(F0, F1, I, N, F) :-
    F2 is F0 + F1,
    I2 is I + 1,
    F2 =< F,
    fib(F1, F2, I2, N, F).

fib(_, _, _, _, F) :-
    F < 0, !, fail.

