%%%%%%%  magos
%harry
esMago(harry).
sangre(harry,mestiza).
caracteristica(harry,corajudo).
caracteristica(harry,inteligente).
caracteristica(harry,amistoso).
caracteristica(harry,orgulloso).
odiariaIrA(harry,slytherin).

%draco
esMago(draco).
sangre(draco,pura).
caracteristica(draco,inteligente).
caracteristica(draco,orgulloso).
odiariaIrA(draco,hufflepuff).

%hermione
esMago(hermione).
sangre(hermione,impura).
caracteristica(hermione,inteligente).
caracteristica(hermione,orgulloso).
caracteristica(hermione,responsable).

%inventado, roberto
esMago(roberto).
sangre(roberto,mestiza).
caracteristica(roberto,amistoso).

%%%%%%%%%%%%%%%%%%%  casas
%gryffindor
casa(gryffindor).
caracteristicaImportante(gryffindor,corajudo).

%slytherin
casa(slytherin).
caracteristicaImportante(slytherin,inteligente).
caracteristicaImportante(slytherin,orgulloso).

%hufflepuff
casa(hufflepuff).
caracteristicaImportante(hufflepuff,amistoso).

%ravenclaw
casa(ravenclaw).
caracteristicaImportante(ravenclaw,responsable).
caracteristicaImportante(ravenclaw,inteligente).


%%%%% parte 1

%%ej1

permiteEntrar(Casa,Mago):-
    casa(Casa),
    esMago(Mago),
    Casa \= slytherin.

permiteEntrar(slytherin,Mago):-
    esMago(Mago),
    not(sangre(Mago,impura)).

%%ej2

tieneCaracterApropiadoParaEntrar(Mago,Casa):-
    esMago(Mago),
    casa(Casa),
    forall(caracteristicaImportante(Casa,Caracteristica),caracteristica(Mago,Caracteristica)).

%%ej3

puedeQuedarSeleccionado(Mago,Casa):-
    tieneCaracterApropiadoParaEntrar(Mago,Casa),
    not(odiariaIrA(Mago,Casa)),
    permiteEntrar(Casa,Mago).

puedeQuedarSeleccionado(hermione,gryffindor).

%%ej4

cadenaDeAmistades(Magos):-
    sonAmistosos(Magos),
    vivenEnLaMismaCasa(Magos).

sonAmistosos(Magos):-
    foreach(member(Mago,Magos), caracteristica(Mago,amistoso)).
    %forall(member(Mago,Magos), caracteristica(Mago,amistoso)).

vivenEnLaMismaCasa(Magos):-
    casa(Casa),
    foreach(member(Mago,Magos), puedeQuedarSeleccionado(Mago,Casa)).
    %forall(member(Mago,Magos), puedeQuedarSeleccionado(Mago,Casa)).

%%%%%parte 2

%%ej1


% posibilidad de eliminar puntaje en irA en accion para hacer
%predicado donde se especifique cada puntaje en particular
%no se si sera necesario igual

%hermione
accion(hermione,irA(tercerPiso,-75)).
accion(hermione,irA(seccionRestringidaBiblioteca,-10)).
accion(hermione,usarIntelecto,50).
esDe(hermione, gryffindor).

%ron
accion(ron,ganarAjedrez,50).
esDe(ron, gryffindor).

%harry
accion(harry,andarFueraDeLaCama).
accion(harry,irA(bosque,-50)).
accion(harry,irA(tercerPiso,-75)).
accion(harry,ganarAVoldemort,60).
esDe(harry, gryffindor).

%draco
accion(draco,irA(mazmorras,0)).
esDe(draco, slytherin).

%luna
esDe(luna, ravenclaw).

accionMala(Accion):-
    accion(_,Accion),
    accion(_,irA(bosque,_)),
    accion(_,irA(tercerPiso,_)),
    accion(_,irA(seccionRestringidaBiblioteca,_)).
   
accionMala(Accion):-
    accion(_,Accion),
    accion(_,andarFueraDeLaCama).

accionBuena(Accion):-
    accion(_,Accion),
    esReconocida(Accion).

esReconocida(Accion):-
    accion(_,Accion),
    accion(_,_,Puntaje),
    between(0, 100000, Puntaje). %uso esto para que sea inversible
    
%tendria que encontrar forma de que la accion
%buena se encuentre cuando la accion no es mala
%pero me parece q no se puede por el not sad

