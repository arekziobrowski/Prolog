rybki(Kto) :-
	zagadka(Kto), !.

na_lewo(X, Y, L) :-
	append(_, [X, Y | _], L).

na_prawo(X, Y, L) :-
	append(_, [Y, X | _], L).

obok(X, Y, L) :-
	na_lewo(X, Y, L);
	na_prawo(X, Y, L).

/**
    Norweg zamieszkuje pierwszy dom
    Anglik mieszka w czerwonym domu.
    Zielony dom znajduje się bezpośrednio po lewej stronie domu białego.
    Duńczyk pija herbatkę.
    Palacz papierosów light mieszka obok hodowcy kotów.
    Mieszkaniec żółtego domu pali cygara.
    Niemiec pali fajkę.
    Mieszkaniec środkowego domu pija mleko.
    Palacz papierosów light ma sąsiada, który pija wodę.
    Palacz papierosów bez filtra hoduje ptaki.
    Szwed hoduje psy.
    Norweg mieszka obok niebieskiego domu.
    Hodowca koni mieszka obok żółtego domu.
    Palacz mentolowych pija piwo.
    W zielonym domu pija się kawę.

*/
%dom(kolor, kto, zwierze, napoj, palenie)
zagadka(X) :-
	length(Domy, 5),
	Domy = [dom(_, 'Norweg', _, _, _) | _],
	member(dom(czerwony, 'Anglik', _, _, _), Domy),
	na_lewo(dom(zielony, _, _, _, _), dom(bialy, _, _, _, _), Domy),
	member(dom(_, 'Dunczyk', _, herbata, _), Domy),
	obok(dom(_, _, _, _, light), dom(_, _, koty, _, _), Domy),
	member(dom(zolty, _, _, _, cygaro), Domy),
	member(dom(_, 'Niemiec', _, _, fajka), Domy),
	Domy = [_, _, dom(_, _, _, mleko, _), _, _],
	obok(dom(_, _, _, _, light), dom(_, _, _, woda, _), Domy),
	member(dom(_, _, ptaki, _, bezfiltra), Domy),
	member(dom(_, 'Szwed', psy, _, _), Domy),
	obok(dom(_, 'Norweg', _, _, _), dom(niebieski, _, _, _, _), Domy),
	obok(dom(_, _, konie, _, _), dom(zolty, _, _, _, _), Domy),
	member(dom(_, _, _, piwo, mentolowe), Domy),
	member(dom(zielony, _, _, kawa, _), Domy),
	member(dom(_, X, rybki, _, _), Domy).
