%Akceptuje slowa z jezyka L = {a^nb^n : n >= 0}.
g1 --> [].
g1 --> [a], g1, [b].

%Akceptuje slowa z jezyka L = {a^nb^nc^n : n >= 0}.
a(0) --> [].
a(N) --> [a], a(N_new), {N is N_new + 1}.

b(0) --> [].
b(N) --> [b], b(N_new), {N is N_new + 1}.

c(0) --> [].
c(N) --> [c], c(N_new), {N is N_new + 1}.

g2 --> a(N), b(N), c(N).

%Akceptuje slowa z jezyka L = {a^nb^(fib(n)) : n >= 0}, gdzie fib(n) jest n-tym wyrazem ciagu Fibonacciego.
fib(0, 1) :- !.
fib(1, 1) :- !.
fib(N, Wynik) :- 
	N1 is N - 1,
	N2 is N - 2,
	fib(N1, Wynik1),
	fib(N2, Wynik2),
	Wynik is Wynik1 + Wynik2.

g3 --> a(N), {fib(N, FibN)}, b(FibN).

