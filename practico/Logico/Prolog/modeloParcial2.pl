%TABLAS
%DNI,ApellidoyNombre, Medidores
usuario(2358964,'Perez Maria',[161,164]).
usuario(24135664,'Gomez Jose',[162,163]).
usuario(2567364,'Garcia Delfina',[165]).
% NroLiquidacion,NroMedidor,LecturaAnterior(Fecha,KWH),LecturaActual(fecha
% ,KWH),CodigoEscalofon
factura('00010-33550', 161, lecturaAnterior(fecha(20,7,2018),32993),lecturaActual(fecha(20,8,2018),33156),1).
factura('00010-33551', 162, lecturaAnterior(fecha(20,7,2018),27645),lecturaActual(fecha(20,8,2018),27895),2).
factura('00010-33552', 163, lecturaAnterior(fecha(23,7,2018),31895),lecturaActual(fecha(23,8,2018),33015),1).
factura('00010-33553', 164, lecturaAnterior(fecha(27,7,2018),15689),lecturaActual(fecha(27,8,2018),16000),1).
factura('00010-33554', 165, lecturaAnterior(fecha(27,7,2018),42589),lecturaActual(fecha(27,8,2018),42789),2).
%CodigoEscalofon, Precio unitario por KWH
escalon(1,2.72).
escalon(2,3.53).

%1)
%Mostra el numero de liquidacion e importe neto de cada factura. El
% importe neto es igual al consumo actual multiplicado por el precio
% unitario, a lo cual se le suma el cargo fijo. Para ello considerar:
% Cargo fijo de $47.84
% Consumo actual: que es igual a la resta de la cantidad de kWh de la
% lectura actual menos la cantidad de kWh de la lectura anterior.
% Precio unitario: depende del codigo de escalon asociado al medidor.
%

regla1(Lista):-
    findall((CodigoFactura,ImporteFinal),
            (
             factura(CodigoFactura,_,lecturaAnterior(_,Lectura_anterior),lecturaActual(_,Lectura_actual),CodigoEscalon),
             escalon(CodigoEscalon,PrecioUnitario),
             Consumo is Lectura_actual - Lectura_anterior,
             Importe is Consumo * PrecioUnitario,
             ImporteFinal is Importe + 48.84

            ),
            Lista).
