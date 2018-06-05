:- consult('scanner.pl').
:- consult('zadanie1.pl').
:- consult('interpreter.pl').

wykonaj(NazwaPliku) :-
	open(NazwaPliku, read, Strumien),
	scanner(Strumien, Tokeny),
	close(Strumien),
	phrase(program(Program), Tokeny),
	interpreter(Program).