% Conocimiento sobre los contratos
% contrato(nro_contrato,distribuidor,nombre_producto,regalia,tipo_product
% o,derechos_distribucion,valor_minimo)
contrato('A234', 'Distribuidor A', 'Game of Thrones','1Q2010', 2,['DVD', 'BlueRay', 'TVP', 'Streaming'], 25000).
contrato('A423', 'Distribuidor B', 'El hombre invisible', '1M2020', 1, ['DVD', 'Streaming'], 12500).
contrato('A120', 'Distribuidor A', 'Mentes Criminales', '2M2515', 2, ['TVP', 'Streaming'], 7500).
contrato('A540', 'Distribuidor B', 'Lluvia Negra', '3M3520', 1, ['DVD', 'BlueRay'], 10000).
contrato('A255', 'Distribuidor A', 'CSI Las Vegas', '3M3520', 2, ['DVD', 'Streaming'], 30000).
contrato('A566', 'Distribuidor B', 'Cazafantasmas', '1Q2010', 1, ['Cine'], 50000).
contrato('A897', 'Distribuidor A', 'Sherlock Holmes', '1M2020', 2, ['DVD', 'BlueRay', 'TVP', 'Streaming'], 75000).
contrato('A123', 'Distribuidor C', 'El Rey Leon', '2Q3015', 1, ['DVD', 'BlueRay', 'TVP', 'Streaming'], 65000).
contrato('A453', 'Distribuidor B', 'La odisea de los giles', '1M2020', 1, ['Cine'], 35000).
contrato('A690', 'Distribuidor C', 'El Robo del Siglo', '1Q2010', 1, ['Cine'],  45000).

%Conocimiento sobre regalias
%regalia(codigo, nombre, % regalia, % costo, pais).
regalia('1Q2010', 'Regalia 1', 0.20, 0.10, 1).
regalia('1M2020', 'Regalia 2', 0.20, 0.20, 2).
regalia('2Q3015', 'Regalia 3', 0.30, 0.15, 1).
regalia('2M2515', 'Regalia 4', 0.25, 0.15, 2).
regalia('3M3520', 'Regalia 5', 0.35, 0.20, 3).

%Conocimiento sobre ingreso mensual por contrato
% ingreso_mensual(nro de contrato,fecha_ingreso(dia,mes,año),monto,monto_gasto_distribucion,pais).
ingreso_mensual_contrato('A123', fecha_ingreso(15, 03, 2020), 45000, 17500, 1).
ingreso_mensual_contrato('A123', fecha_ingreso(15, 03, 2020), 45000, 17500, 1).
ingreso_mensual_contrato('A123', fecha_ingreso(31, 03, 2020), 20000, 16500, 1).
ingreso_mensual_contrato('A123', fecha_ingreso(30, 06, 2020), 50000, 22500, 3).
ingreso_mensual_contrato('A453', fecha_ingreso(12, 06, 2020), 30000, 15000, 2).
ingreso_mensual_contrato('A453', fecha_ingreso(28, 06, 2020), 25000, 15000, 2).
ingreso_mensual_contrato('A690', fecha_ingreso(02, 02, 2020), 12000, 13500, 3).
ingreso_mensual_contrato('A690', fecha_ingreso(29, 02, 2020), 95500, 13500, 3).
ingreso_mensual_contrato('A690', fecha_ingreso(31, 03, 2020), 80000, 12500, 1).
ingreso_mensual_contrato('A897', fecha_ingreso(16, 03, 2020), 40000, 17000, 2).
ingreso_mensual_contrato('A897', fecha_ingreso(31, 03, 2020), 15000, 17000, 2).
ingreso_mensual_contrato('A897', fecha_ingreso(02, 29, 2020), 50000, 17000, 1).
ingreso_mensual_contrato('A566', fecha_ingreso(30, 04, 2020), 50000, 16500, 3).
ingreso_mensual_contrato('A255', fecha_ingreso(10, 04, 2020), 72000, 14500, 3).
ingreso_mensual_contrato('A255', fecha_ingreso(30, 04, 2020), 90000, 14500, 3).
ingreso_mensual_contrato('A540', fecha_ingreso(12, 06, 2020), 30000, 10800, 2).
ingreso_mensual_contrato('A540', fecha_ingreso(30, 06, 2020), 30800, 10700, 2).
ingreso_mensual_contrato('A540', fecha_ingreso(31, 07, 2020), 30500, 10600, 1).
ingreso_mensual_contrato('A120', fecha_ingreso(31, 07, 2020), 25500, 23400, 1).
ingreso_mensual_contrato('A234', fecha_ingreso(15, 05, 2020), 75600, 12800, 1).
ingreso_mensual_contrato('A234', fecha_ingreso(31, 05, 2020), 75600, 12800, 1).

% Conocimiento de tipo de producto
% producto(id,nombre).
producto(1, pelicula).
producto(2, serie).

% Conocimiento sobre los paises
% pais(id, nombre).
pais(1, argentina).
pais(2, brasil).
pais(3, uruguay).

% Monto minimo total con el adicional sumado
monto_minimo_total(Numero, Total) :- contrato(Numero,_,_,Regalia,_,_,MontoMinimo),
    regalia(Regalia,_,_,Costo,_),
    ingreso_mensual_contrato(Numero,_,Ingreso,Gasto,_),
    Porc is ((Ingreso - Gasto) * Costo),
    Adicional is (Ingreso - Gasto - Porc),
    Total is MontoMinimo + Adicional,!.

% Punto 2
solo_cine() :- contrato(_,_,_,_,_,Distribuciones,_),
    member('Cine',Distribuciones),
    length(Distribuciones,1),!.

% Punto 3.
monto_regalia(Numero, Mes, MontoRegalia) :- ingreso_mensual_contrato(Numero,fecha_ingreso(_,Mes,_),NetoMensual,_,_),
    contrato(Numero,_,_,Regalia,_,_,_),
    monto_minimo_total(Numero,MontoMinimo),
    regalia(Regalia,_,Monto,_,_),
    ((NetoMensual =< MontoMinimo, MontoRegalia is 0,!);(NetoMensual > MontoMinimo,    MontoRegalia is ((NetoMensual - MontoMinimo) * Monto),!)).

% Punto 4
pago_mensual(Numero, Mes, Total) :- ingreso_mensual_contrato(Numero,fecha_ingreso(_,Mes,_),NetoMensual,_,_),
    monto_minimo_total(Numero,MontoMinimo),
    monto_regalia(Numero, Mes, MontoRegalia),
    ((NetoMensual =< MontoMinimo,Total is MontoMinimo);(NetoMensual > MontoMinimo,Total is MontoMinimo + MontoRegalia)).

% Punto 5
lista5(Valor,Mes,O) :- findall(Numero,
                              (pago_mensual(Numero,Mes,Total),
                               Total > Valor)
                              ,L), sort(L,O).

% Punto 6
lista6(Valor, Numero, Nombre, NomRegalia, NomProducto) :- contrato(Numero,_,Nombre,NomRegalia,TipoProducto,Distribuciones,_),
    producto(TipoProducto, NomProducto),
    length(Distribuciones, Y), Y >= 3,
    monto_minimo_total(Numero, Total),
    Valor < Total.













