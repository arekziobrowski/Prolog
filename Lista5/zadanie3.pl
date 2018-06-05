browse(Term) :-
	action([Term]).

push(X, Stack, Stack_new) :-
	Stack_new = [X | Stack].

pop(Y, Stack, Stack_new) :-
	Stack = [Y | T],
	Stack_new = T.

action([]).

action([H | T]) :-
	format('~q~n', [H]),
	format('command: '),
	read(C),
	traverse(C, [H | T]).

traverse(i, Stack) :-
	Stack = [H | _],
	H =.. [_ | [Arg1 | _]],
	push(Arg1, Stack, Stack_new),
	!,
	action(Stack_new).

traverse(o, Stack) :-
	pop(_, Stack, Stack_new),
	!,
	action(Stack_new).

traverse(n, Stack) :-
	pop(Y, Stack, Stack_new),
	Stack_new = [Parent | _],
	Parent =.. [_ | Args],
	append(_, [Y, X | _], Args),
	push(X, Stack_new, Stack_new_new),
	!,
	action(Stack_new_new).

traverse(p, Stack) :-
	pop(Y, Stack, Stack_new),
	Stack_new = [Parent | _],
	Parent =.. [_ | Args],
	append(_, [X, Y | _], Args),
	push(X, Stack_new, Stack_new_new),
	!,
	action(Stack_new_new).

traverse(_, Stack) :-
	action(Stack).
