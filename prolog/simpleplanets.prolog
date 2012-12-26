% use_module(library(ordsets)).


planet_radius(earth,6371).
planet_radius(mercury,2439).
planet_radius(neptune,25362).
planet_radius(jupiter,69911).
planet_radius(mars,3390).
planet_radius(lumpy,7000).
planet_radius(pluto,2000).

planet_economy(earth,['Mainly','Agricultural']).
planet_economy(mercury,['Poor','Agricultural']).
planet_economy(neptune,['Rich','Agricultural']).
planet_economy(jupiter,['Average','Industrial']).
planet_economy(mars,['Mainly','Industrial']).
planet_economy(lumpy,['Rich','Industrial']).
planet_economy(pluto,['Poor','Industrial']).

planet_inhabitants(earth,['Angry','Humanoids']).
planet_inhabitants(mercury,['Black','Insectoids']).
planet_inhabitants(neptune,['Spotted','Lobstoids']).
planet_inhabitants(jupiter,['Blue','Felines']).
planet_inhabitants(mars,['Furry','Critters']).
planet_inhabitants(lumpy,['Human','Colonials']).
planet_inhabitants(pluto,['Furry','Felines']).

planet_techlevel(earth,9).
planet_techlevel(mercury,12).
planet_techlevel(neptune,5).
planet_techlevel(jupiter,8).
planet_techlevel(mars,14).
planet_techlevel(lumpy,11).
planet_techlevel(pluto,7).

planet_description(earth,['vast','oceans']).
planet_description(mercury,['frequent','war']).
planet_description(neptune,['unpredictable','solar','activity']).
planet_description(mars,['mud','tennis']).
planet_description(jupiter,['dull']).
planet_description(lumpy,['pink','plantations']).
planet_descriptions(pluto,['boring','world']).

has_mixed_economy(X):- planet_economy(X,E),memberchk('Mainly',E).

earthlike_set(X) :- list_to_ord_set(['plantations','oceans','forests'],X).
scorched_set(X) :- list_to_ord_set(['solar','war'],X).

is_gasgiant(X):-
planet_economy(X,E),
                memberchk('Industrial',E),
		planet_radius(X,R),
		R > 6870,  % thankyou cim
                or( 
			not(has_mixed_economy(X)) ,
                	not(is_earthlike(X)) 
		).

is_frozen(X):-
		planet_radius(X,R),
		R < 4500,
		planet_inhabitants(X,F),
                memberchk('Furry',F),
		not(is_earthlike(X)).

is_earthlike(X):-
		planet_description(X,D),
                sort(D,DS),
                earthlike_set(EL),
                list_to_ord_set(DS,DSS),
		ord_intersect(EL,DSS).

is_scorched(X):-
	planet_description(X,D),
	scorched_set(SS),
	list_to_ord_set(D,DSS),
	ord_intersect(SS,DSS).

determine_texture(X,T):-
	is_gasgiant(X) *-> T='Gas',! ;
	is_frozen(X) *-> T='Frozen',!;
	is_earthlike(X) *-> T='Continental'.

