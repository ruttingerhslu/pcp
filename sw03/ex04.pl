p(X):- a(X).            % r1
p(X):- b(X), !, c(X).      % r2
p(X):- d(X).            % r3
a(1).
b(2). b(3).
c(2). c(3).
d(4).

% trace.
% p(X).
