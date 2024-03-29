%Hechos

% tabla 1 promociones
% Codigo de promocion , Slogan, Cantidad de litros de combustible,
% Porcentaje de descuento% Hecho

promocion('AAA','Carganod 10 litros o mas de cualquier combustible, descuneto del 8%', 10, 8).
promocion('BBB','Carganod 8 litros o mas de cualquier combustible, descuneto del 5%', 8, 5).
promocion('CCC','Carganod 12 litros o mas de cualquier combustible, descuneto del 10%', 12, 10).

% tabla 2 Venta Combustible
% Codigo venta, Codigo de promocion Asignado, Fecha(Dia,Mes,A�o),
% suritdor, Litros cargargados

venta('V1', 'AAA', fecha(29, 9 ,2019), '1', 12.5).
venta('V2', 'BBB', fecha(16, 10 ,2019), '2', 10.0).
venta('V3', 'AAA', fecha(16, 9 ,2019), '4', 15.5).
venta('V4', 'AAA', fecha(18, 9 ,2019), '8', 8.0).
venta('V5', 'CCC', fecha(18, 9 ,2019), '9', 12.0).

%Tabla 3
%codigo del item, descripcion, Precio por litro, Surtidores
%

combustible('A', 'Super', 45.67, ['1','2','3']).
combustible('B', 'Premium', 52.97, ['4','5']).
combustible('C', 'Diesel', 44.69, ['6']).
combustible('D', 'Diesel Premium', 50.84, ['7']).
combustible('E', 'GNC', 20.99, ['8','9','0']).

%REGLAS
%1)
% Conocer el codigo de venta, slogan, mes y anio, de aquellas ventas en
% las que se haya vendido mas de 12 litros de cualquier combustible.
% Predicado sugerido: reglas1/4(ARIDAD)


regla1(CodigoVenta, Slogan, Mes, Anio) :- venta(CodigoVenta,CodigoPromo,fecha(_, Mes, Anio), _, LitrosCargados), promocion(CodigoPromo, Slogan,_,_), LitrosCargados > 12.

%2)
% Para un determinado codigo de venta que se especifica, conocer el
% porcentaje de descuento en caso de corresponderle, segun la promocion
% vigente. Tener en cuenta que en caso de no corresponderle, este
% porcentaje dde descuenta ser 0. Predicado sugerido para esta regla:
% regla 2/2

%Muestra todos y por codigo
regla2(CodigoVenta,X) :-
    venta(CodigoVenta,CodigoPromo,_,_,LitrosCargados),
    promocion(CodigoPromo,_,CantLitros,PorcentajeDescuento),
    ((LitrosCargados >= CantLitros, X is PorcentajeDescuento) ; (LitrosCargados < CantLitros, X is 0)),!. %Break, No olvidarse de los paratnesis en el or

%3)
% Generar una lista con aquellos codigos de ventas en las que se haya
% cargado cierto combustible cuyo nombre se especifica. Luego de generar
% el listado, orfenar sus elementos, ascendentemente por codigo de
% venta. Predicado sugerido para esta regla: regla3/2

regla3(NombreCombustible,Lista):-
    findall(CodigoVenta, (venta(CodigoVenta,_,_,Surtidor,_),
                          combustible(_,NombreCombustible,_,Surtidores),
                          member(Surtidor,Surtidores)),ListaCodigosVentas),
    sort(ListaCodigosVentas, Lista).

%findall , primer parametro(devuevlo los codigos de ventas)
%segundo parametro entre parentisis
%Tercer parametro la lista que quiero devolver
%
% Entro a combustible y obtengo la lista de surtidores, entro a la venta
% y saco el surtidor

regla33(NombreCombustible,Lista):-
    findall(CodigoVenta, (venta(CodigoVenta,_,_,Surtidor,_),
                          combustible(_,NombreCombustible,_,Surtidores),
                          member(Surtidor,Surtidores)),ListaCodigosVentas),
    sort(ListaCodigosVentas, ListaOr),
    reverse(ListaOr, Lista).

% regla ACME: Listar los codigos de ventas, junto con los importes
% finales, Tener en cuenta las promociones segun corresponda
% Explicacion 1:18:25

reglaACME(Lista):-
    findall((CodigoVentas, ImporteFinal),
            (venta(CodigoVentas,_,_,Surtidor,LitrosCargados),
             combustible(_,_,PrecioLitro,ListaSurtidores),
             member(Surtidor, ListaSurtidores),
             regla2(CodigoVentas, PorcDesc),
             Importe is PrecioLitro * LitrosCargados,
             Descuento is (Importe * PorcDesc)/100,
             ImporteFinal is Importe - Descuento
            ),
            Lista).
% para cada venta tendra en cuenta el combustible, dsp va checkear que
% el surtidor, este como miembro de la lista de combustible, Cuando todo
% eso es verdadero, recien ahi, llamara la regla2, hace esta regla
% ligando al codigo el porcentaje de descuento y luego hago los calculos
