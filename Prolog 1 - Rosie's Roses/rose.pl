

rose('Cottage Beauty').
rose('Golden Sunset').
rose('Mountain Bloom').
rose('Pink Paradise').
rose('Sweet Dreams').

event('Anniversary Party').
event('Charity auction').
event('Retirement').
event('Senior Prom').
event('Wedding').

item('Balloons').
item('Candles').
item('Chocolates').
item('Place cards').
item('Streamers').

person('Hugh').
person('Ida').
person('Jeremy').
person('Leroy').
person('Stella').

solve :-
    rose(HughRose),
    rose(IdaRose),
    rose(JeremyRose),
    rose(LeroyRose),
    rose(StellaRose),
    all_different([HughRose, IdaRose, JeremyRose, LeroyRose, StellaRose]),

    event(HughEvent),
    event(IdaEvent),
    event(JeremyEvent),
    event(LeroyEvent),
    event(StellaEvent),
    all_different([HughEvent, IdaEvent, JeremyEvent, LeroyEvent, StellaEvent]),

    item(HughItem),
    item(IdaItem),
    item(JeremyItem),
    item(LeroyItem),
    item(StellaItem),
    all_different([HughItem, IdaItem, JeremyItem, LeroyItem, StellaItem]),

    Quad = [ ['Hugh', HughRose, HughEvent, HughItem],
             ['Ida', IdaRose, IdaEvent, IdaItem],
             ['Jeremy', JeremyRose, JeremyEvent, JeremyItem],
             ['Leroy', LeroyRose, LeroyEvent, LeroyItem],
             ['Stella', StellaRose, StellaEvent, StellaItem] ],

    % 1. Jeremy made a purchase for the senior prom. Stella (who didn't choose flowers for a wedding) picked the Cottage Beauty variety.
    member(['Jeremy', _, 'Senior Prom', _], Quad),
    \+ member(['Stella', _, 'Wedding', _], Quad),
    member(['Stella', 'Cottage Beauty', _, _], Quad),

     % 2.
     member(['Hugh', 'Pink Paradise', _, _], Quad),
     \+ member(['Hugh', _, 'Charity auction', _], Quad),
     \+ member(['Hugh', _, 'Wedding', _], Quad),

     % 3.
     member([_, _, 'Anniversary Party', 'Streamers'], Quad),
     member([_, _, 'Wedding', 'Balloons'], Quad),

     % 4.
     member([_, 'Sweet Dreams', _, 'Chocolates'], Quad),
     \+ member(['Jeremy', 'Mountain Bloom', _, _], Quad),

     % 5.
     member(['Leroy', _, 'Retirement', _], Quad),
     member([_, _, 'Senior Prom', 'Candles'], Quad),

     tell('Hugh', HughRose, HughItem, HughEvent),
     tell('Ida', IdaRose, IdaItem, IdaEvent),
     tell('Jeremy', JeremyRose, JeremyItem, JeremyEvent),
     tell('Leroy', LeroyRose, LeroyItem, LeroyEvent),
     tell('Stella', StellaRose, StellaItem, StellaEvent).


all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z, V) :-
    write(X), write(' got '), write(Y),
    write(' roses and '), write(Z), write(' for a '), write(V), write('.'), nl.


