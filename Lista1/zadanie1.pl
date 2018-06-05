kobieta(babcia).
kobieta(mama).
kobieta(córka).

mężczyzna(dziadek).
mężczyzna(tato).
mężczyzna(syn).

matka(babcia, mama).
matka(mama, syn).
matka(mama, córka).

ojciec(dziadek, mama).
ojciec(tato, syn).
ojciec(tato, córka).

rodzic(babcia, mama).
rodzic(dziadek, mama).
rodzic(mama, córka).
rodzic(mama, syn).
rodzic(tato, syn).
rodzic(tato, córka).


jest_matką(X) :- matka(X, _).
jest_ojcem(X) :- ojciec(X, _).
jest_synem(X) :- 
	mężczyzna(X),
	rodzic(_, X).
siostra(X, Y) :- 
	kobieta(X),
	rodzic(Z, X),
	rodzic(Z, Y),
	X \= Y.
dziadek(X, Y) :- 
	ojciec(X, Z),
	rodzic(Z, Y).
rodzeństwo(X, Y) :-
	rodzic(Z, X),
	rodzic(Z, Y),
	X \= Y.


