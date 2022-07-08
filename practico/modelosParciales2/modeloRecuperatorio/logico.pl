%Tabla 1
%
% CodigoPedido,Estado,RepartidorAsignado,cliente(NroTelefono,Calle,Altura),
% CarritoItems
%
pedidosProgramados(1,4,'Lara',cliente(11111,'Salta',250),['A','A','D']).
pedidosProgramados(2,2,'Tina',cliente(22222,'Av. Colono',101),['B','C']).
pedidosProgramados(3,3,'Lali',cliente(44444,'San Martin',1321),['A','D']).
pedidosProgramados(4,1,'Tina',cliente(33333,'Avellabeda',3213),['B','D','D']).
pedidosProgramados(5,4,'Lara',cliente(99999,'9 de julio',2123),['A','B','B','B','E']).
pedidosProgramados(6,4,'Tina',cliente(88888,'Urquiza',1503),['D','D']).

%Tabla 2
%
%Codigo,Descripcion

estados(1,'Registrado').
estados(2,'En preparacion').
estados(3,'En camino').
estados(4,'Entregado').
estados(5,'Canceladoo').

%Tabla 3
%Codigo,Descripcion,Precio

listadoDeItems('A','Pack 1',2500).
listadoDeItems('B','Pack 2',1900).
listadoDeItems('C','Pack 3',2200).
listadoDeItems('D','Pack 4',2800).
listadoDeItems('E','Pack 5',2000).

%1) Conocer la descripción del estado de pedido, la calle y altura del domicilio de entrega, de todos los pedidos programados cuyo nombre de repartidor se especifica. Predicado sugerido para esta regla: regla1/4. (15 puntos)

regla1(NombreRepartidor, Descripcion, Calle, Altura):-
    pedidosProgramados(_,Estado,NombreRepartidor,cliente(_,Calle,Altura),_),
    estados(Estado,Descripcion).




