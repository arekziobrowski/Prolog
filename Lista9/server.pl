:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).

:- use_module(form).
:- use_module(queens).

:- http_handler(root(queens), handler_queens, []).
:- http_handler(root(solution), handler_solution, []).
:- http_handler(root(.), http_reply_from_files('pic', []), [prefix]).

% server(+Port) uruchomienie serwera na danym porcie
%
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

handler_queens(_Request) :-
    format('Content-type: text/html~n~n'),
    format('<!DOCTYPE html><html><head><title>Form</title>~n', []),
    format('<meta http-equiv="content-type" content="text/html; charset=UTF-8">~n', []),
    format('</head><body>~n', []),
    format('<h1>Gimme size of the problem</h1>~n', []),
    build_form([action(solution), method(post)],
           [label(size, 'Size:'), input(text, size), br,
            input(submit)]),
    format('</body></html>~n', []).

handler_solution(Request) :-
    member(method(post), Request), !,
    http_read_data(Request, Data, []),
    reply_html_page(title('Solution'),
            [h1('Solution'),
            table([\board(Data)])
            ]).

board([size=SIZE]) -->
    {
        atom_number(SIZE, NUMBER),
        once(once(queens(NUMBER, P)) ; P = [])
    },
    row(P, NUMBER).

row([], _) --> [].
row([H | T], NUMBER) -->
    html(tr(\col(H, NUMBER))),
    row(T, NUMBER).

col(_, 0) --> [].
col(H, INDEX) -->
    {
        INDEX_NEW is INDEX - 1,
        (
            INDEX = H ->
            (
                SRC = '/queen.png'
            )
            ;
            (
                SRC = '/empty.png'
            )
        )
    },
    col(H, INDEX_NEW), html(td(img(src(SRC)))).
