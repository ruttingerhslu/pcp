set_difference([], _, []).              % base case

set_difference([X|Xs], Set2, Diff) :-
    member(X, Set2),                    % if X in Set2, ignore X (cut)
    !,                                  
    set_difference(Xs, Set2, Diff).

set_difference([X|Xs], Set2, [X|Diff]) :-
    \+ member(X, Set2),                 % if X not in Set2, take X into Diff
    set_difference(Xs, Set2, Diff).
