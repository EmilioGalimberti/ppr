% Tabla 1: Obras Artísticas

% Codigo de Obra, Titulo, Codigo de direccion, Año de estreno version
% original

obrasArtisticas(ob1, 'El lago de los Cisnes', dir1, 1877).
obrasArtisticas(ob2, 'Rincon de Luz', dir2, 1955).
obrasArtisticas(ob3, 'Floricienta', dir2, 2004).


% Tabla 2: Directores

% Codigo, Nombre, Apellido, Porcentaje de comision por dirigir [%]

directores(dir1, 'Victoria', 'Carreras', 10).
directores(dir2, 'Cris', 'Morena', 30).
directores(dir3, 'Arturo', 'Pulg', 10).


% Tabla 3: Funciones

% CodigoFuncion, CodigoObra, Fecha(Dia, Mes, año), Hora(Hora, Minutos),
% Sala

funciones(fun1, ob1, fecha(18, 05, 2022), hora(18, 00), 1).
funciones(fun2, ob1, fecha(18, 05, 2022), hora(22, 00), 1).
funciones(fun3, ob2, fecha(18, 05, 2022), hora(16, 30), 2).
funciones(fun4, ob2, fecha(18, 05, 2022), hora(21, 30), 2).
funciones(fun5, ob1, fecha(19, 05, 2022), hora(18, 00), 1).
funciones(fun6, ob1, fecha(19, 05, 2022), hora(21, 00), 1).
funciones(fun7, ob1, fecha(20, 05, 2022), hora(18, 30), 1).
funciones(fun8, ob2, fecha(20, 05, 2022), hora(21, 00), 2).
funciones(fun9, ob1, fecha(21, 05, 2022), hora(18, 00), 1).
funciones(fun10, ob1, fecha(21, 05, 2022), hora(22, 00), 1).


% Tabla 4: Entradas Habilitadas

% CodEntrada, CodFuncion, ImpBasico, Vendida, Platea(nroButaca),
% VIP(CodPalco, SrvCatering).


entradas(en1, fun1, 500, no, platea(1)).
entradas(en2, fun1, 500, si, platea(3)).
entradas(en3, fun1, 500, no, platea(79)).
entradas(en4, fun1, 500, si, platea(99)).
entradas(en5, fun1, 200, si, vip('A', no)).
entradas(en6, fun1, 200, si, vip('B', si
)).
entradas(en7, fun2, 500, no, platea(9)
).
entradas(en8, fun2, 500, si, platea(55)).
entradas(en9, fun2, 500, si, platea(59)).
entradas(en10, fun2, 300, no, vip('A', si)
).
entradas(en11, fun2, 700, si, vip('F', no)).
entradas(en12, fun3, 500, si, platea(99)).
entradas(en13, fun3, 500, no, vip('B', si)).
entradas(en14, fun3, 500, si, platea(11)).
entradas(en15, fun3, 200, si, vip('C', si)).
entradas(en16, fun4, 500, si, platea(51)).
entradas(en17, fun4, 500, si, vip('A', no)).
entradas(en18, fun4, 500, no, platea(1)).
entradas(en19, fun4, 200, si, vip('F', si)).
entradas(en20, fun4, 500, si, platea(5)).


cls :- write('\33\[2J').

% Tabla 5: Palcos

% CodigoPalco, Descripcion, ListaDeAsientosHabilitados



% ------------- FORMULACION DE REGLAS ------------------

% Para cierto código de entrada se deberá conocer el día, mes y año de la función asociada, como así
% también la hora y minutos de inicio de esta. También se deberá poder
% conocer el título de la obra, y el
% nombre y apellido del director.

datos_entrada(CodEntrada, Dia, Mes, Anio, Hora, Min, TituloObra, NomDir, ApDir):-
    entradas(CodEntrada, CodFunc, _, _, _),
    funciones(CodFunc, CodObra, fecha(Dia, Mes, Anio), hora(Hora, Min), _),
    obrasArtisticas(CodObra, TituloObra, CodDir, _),
    directores(CodDir, NomDir, ApDir, _).

existe_entrada_vendida_butaca_entre(EntreX,EntreY):-
    entradas(_,_,_,Vendida,platea(NumeroButaca)),
    NumeroButaca >= EntreX,
    NumeroButaca =< EntreY,
    Vendida = 'si'.
