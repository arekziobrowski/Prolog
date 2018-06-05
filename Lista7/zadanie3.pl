/*
									Filozof 0

								0				4

				Filozof 1								Filozof 4

							1						3

										2
						Filozof 2				Filozof 3
*/

identifier(0, Who) :- format('[~w]   ', [Who]), !.
identifier(N, Who) :-
	write(' '),
	N_new is N - 1,
	identifier(N_new, Who).

identifier(Who) :-
	Number is Who,
	identifier(Number, Who).

write_task(Task, Who) :-
	with_mutex(print, (identifier(Who),
		write(Task),
		nl)).

think(Who, ML, MR) :-
	write_task('mysli', Who),
	sleep(2),
	up_right_fork(Who, ML, MR).

up_right_fork(Who, ML, MR) :-
	write_task('chce prawy widelec', Who),
	mutex_lock(MR),
	write_task('podnosi prawy widelec', Who),
	up_left_fork(Who, ML, MR).

up_left_fork(Who, ML, MR) :-
	write_task('chce lewy widelec', Who),
	mutex_lock(ML),
	write_task('podnosi lewy widelec', Who),
	eat(Who, ML, MR).

eat(Who, ML, MR) :-
	write_task('je', Who),
	sleep(2),
	down_right_fork(Who, ML, MR).

down_right_fork(Who, ML, MR) :-
	write_task('odklada prawy widelec', Who),
	mutex_unlock(MR),
	down_left_fork(Who, ML, MR).

down_left_fork(Who, ML, MR) :-
	write_task('odklada lewy widelec', Who),
	mutex_unlock(ML),
	think(Who, ML, MR).

start(Who, Left_fork, Right_fork) :-
	think(Who, Left_fork, Right_fork).

philosophers :-
	/*
	%may be in deadlock
	mutex_create(F0),
	mutex_create(F4),
	thread_create(start(0, F4, F0), T0, []),
	mutex_create(F1),
	thread_create(start(1, F0, F1), T1, []),
	mutex_create(F2),
	thread_create(start(2, F1, F2), T2, []),
	mutex_create(F3),
	thread_create(start(3, F2, F3), T3, []),
	thread_create(start(4, F3, F4), T4, []),
	*/
	
	
	%non-blocking solution
	mutex_create(F0),
	mutex_create(F4),
	thread_create(start(0, F4, F0), T0, []),
	mutex_create(F1),
	thread_create(start(1, F1, F0), T1, []),
	mutex_create(F2),
	thread_create(start(2, F2, F1), T2, []),
	mutex_create(F3),
	thread_create(start(3, F3, F2), T3, []),
	thread_create(start(4, F4, F3), T4, []),
	
	
	thread_join(T0, _),
	thread_join(T1, _),
	thread_join(T2, _),
	thread_join(T3, _),
	thread_join(T4, _).
