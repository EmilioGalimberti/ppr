%Tabla 1
%
% CodigoPedido,TecnicoAsignado,dniCliente,domicilio(calle,altura,codigobarrio),se
% rvicioInstalar)

pedidosProgramados(1,111,30000000,domicilio('Salta',250,1),['television cable','wi fi']).
pedidosProgramados(2,111,20000000,domicilio('Av. Colon',101,2),['wi fi']).
pedidosProgramados(3,222,15000000,domicilio('San Martin',1321,1),['internet cable']).
pedidosProgramados(4,333,12000000,domicilio('Avellaneda',3213,2),['internet cable','wi fi']).
pedidosProgramados(5,333,25000000,domicilio('9 de julio',2123,1),['television cable']).
pedidosProgramados(6,111,20000000,domicilio('Urquiza',1203,3),['television satelite']).

%Tabla 2
%
%Legajo,Apellido,Nombre

tecnicos(111,'Olazabal','Juliana').
tecnicos(222,'Luchetti','Gertudis').
tecnicos(333,'Manfredi','Luiggi').

%Tabla 3
%%Codigo, Nombre Barrio, PorcjDescuento

descBarrio(1,'Centro',10).
descBarrio(2,'Alberdi',20).
descBarrio(3,'Cofico',15).
descBarrio(4,'Maipu',20).

% 1) Una lista con los nombres de los barrios en los que se deberán
% realizar instalaciones durante la jornada actual. El nombre de cada
% barrio deberá aparecer una sola vez en la lista más allá que tenga
% asociado más de un pedido de instalación en la jornada actual. Nombre
% de la regla: regla1/1.

regla1(Lista):-
    findall(NombreBarrio,
           ( pedidosProgramados(_,_,_,domicilio(_,_,CodigoBarrio),_),
              descBarrio(CodigoBarrio,NombreBarrio,_)),
            ListaBarrios),
            sort(ListaBarrios,Lista).

%2)     Si esta programada o no, la instalaci�n del algun servicio
%       durante la jornada actual, para cierto cliente cuyo numero de
%       DNI se especifica. Nombre de la regla: regla2/1.


regla2(DNI):-
    (
      (   pedidosProgramados(_,_,DNI,_,_),
         write('Tiene un pedidoProgramado'),!
      )
       ;
       (
         not(pedidosProgramados(_,_,DNI,_,_)),
          write('No Tiene ningun pedido programado'),!
        )
     ).

% 3)Conocer para un cierto pedido cuyo código se especifica, el apellido
% y nombre del técnico asignado, y el importe total que deberá cobrar
% por dicha instalación. El importe total se obtiene de la siguiente
% manera:
%Se multiplica la cantidad de servicios a instalar por 500.
% Al anterior importe, se le aplica un descuento que dependerá del barrio
% en el cual se haga la instalación.

regla3(CodigoPedido,ApellidoTecn,NombreTecn,ImporteTotal):-
    pedidosProgramados(CodigoPedido,TecnicoAsignado,_,domicilio(_,_,CodigoBarrio),ListaServicios),
    tecnicos(TecnicoAsignado,ApellidoTecn,NombreTecn),
    length(ListaServicios,CantidadServicios),
    Importe is CantidadServicios * 500,
    descBarrio(CodigoBarrio,_,Desc),
    ImporteTotal is (Importe -(Importe * Desc/100)),!.
