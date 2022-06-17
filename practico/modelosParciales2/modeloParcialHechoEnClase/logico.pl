%Tipo Parcial
%
%Tablas 1
%codigo, nombre

localidades(1,'Cordoba').
localidades(2,'Carlos Paz').
localidades(3,'Mar Chiquita').

%Tabala 2
% codigo, domicilio(calle,numero,codigolocalidad), superficieCubierta,
% TipoInmueble(deparatamento(piso,montoExpensas),casa(superficieDescubierta))
%
%

inmuebles(111,domicilio('Parana',100,1),20,tipo(departamento(0,200))).
inmuebles(222,domicilio('Maipu',200,1),30,tipo(casa(30))).
inmuebles(333,domicilio('Salta',200,2),30,tipo(departamento(2,150))).
inmuebles(444,domicilio('Parana',100,1),25,tipo(departamento(1,20))).
inmuebles(555,domicilio('Peru',200,2),35,tipo(casa(25))).

%ALQUILADOS
%Not PARA El 3

alquilado(111).
alquilado(222).
alquilado(444).

%Ver COMO RECORRER ESTO
listaAlquilados([111,222,444]).
%MEMBER

%punto 1

importe(CodigoInmueble,ImporteAlquiler):-
%Depto

( inmuebles(CodigoInmueble,_,MetroCubierto,tipo(departamento(_,Expensas))),
ImporteAlquiler is (20*MetroCubierto)+Expensas)
;
%Casa
( inmuebles(CodigoInmueble,_,MetroCubierto,tipo(casa(MetroDesc))),
ImporteAlquiler is (20*MetroCubierto)+(10*MetroDesc)
).

%Punto2

importeTemporadaBaja(CodigoInmueble,ImporteTotal):-
importe(CodigoInmueble,ImporteAlquiler),
inmuebles(CodigoInmueble,domicilio(_,_,CodigoLoc),_,_),
%Cordoba
( ( CodigoLoc = 1,
Porcentaje is ImporteAlquiler * 0.30,
ImporteTotal is ImporteAlquiler - Porcentaje
)
;
(
CodigoLoc \= 1,
Porcentaje is ImporteAlquiler * 0.50,
ImporteTotal is ImporteAlquiler - Porcentaje
)).



%punto3

regla3(MetrosIngresados):-
inmuebles(CodigoInmueble,_,MetrosCubiertos,tipo(departamento(_,_))),
not(alquilado(CodigoInmueble)),
MetrosCubiertos >= MetrosIngresados,
write('ENCONTRADO'),!.

%USANDO lista

regla3Lista(Ref):-
inmuebles(CodigoInmueble,_,MetrosCubiertos,tipo(departameto(_,_))),
listaAlquilados(LI),
not(member(CodigoInmueble,LI)),
%Lista de alquilados LI, por cada inmueble busca la lista
%Codigo member de la lista, que el codigo del inmueble exista o no en la lista
%CodigoInmueble esta en LI
MetrosCubiertos >=Ref,!.

%punto4
regla4(ListadeMayoraMenor):-
findall(ImporteTotal,
( inmuebles(CodigoInmueble,_,_,_),
importeTemporadaBaja(CodigoInmueble,ImporteTotal),
alquilado(CodigoInmueble)
), Lista),
sort(Lista,ListaOrdenada),
reverse(ListaOrdenada,ListadeMayoraMenor).

%Existe o no, valide si existe o no, cheque si existe o no
%Siempre tendremos que cortar , !.

%Punto4 CON LISTA
%

regla4Lista(ListaOrd):-
findall(
%valor
Alq,
%Espacio de solucion
( inmueble(CodInm,_,_,_),
listaAlquilados(LI),
member(CodInm,LI),
importeTemporadaBaja(CodInm,Alq)
),Lista),
%LISTA DEVUELTA
sort(Lista,ListaOrd).
%Sort ordena y elimina repetidos

%uso del length(LO,X)
%sum_list(L,x) VER SI ES TODO JUNTO O ASI
%meber()
