:- use_module(library(sgml)).
:- use_module(library(xpath)).
:- use_module(library(url)).

serwery(NazwaPliku, ListaSerwerow) :-
	load_html(NazwaPliku, DOM, []),
	setof(Host, znajdzHosty(DOM, Host), ListaSerwerow).

znajdzHosty(DOM, Host) :-
	xpath(DOM, //a(@href), HREF),
	parse_url(HREF, 'https://localhost/', X),
	X = [protocol(_), host(Host), path(_)].