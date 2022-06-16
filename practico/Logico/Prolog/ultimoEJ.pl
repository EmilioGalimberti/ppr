cls:- write('\33\[2J').
%trabajador()
%contratado()
%efectivo()
%domicilio es un puntor
% contratado y efectivo tmb son puntores pero excluyentes por el
% enunciado

trabajador(111, 'Maria', 'Richardi', domicilio('Jujuy',142,1),3,contrado(24, 25.5, 5)).
trabajador(222, 'Vera', 'Petro', domicilio('Calle 1', 339, 2),3,contrado(20, 25.5, 7)).
trabajador(333, 'Lara', 'Pointer', domicilio('Peru', 721, 3),2,efectivo(2200, 1, 2)).
trabajador(444, 'Victoria', 'Dove', domicilio('Jujuy', 344, 4),2, efectivo(2000, 12, 1.5)).
trabajador(555, 'Ximena', 'Coraggo', domicilio('Salta', 545, 1),3,contrado(24, 25.5, 5)).
trabajador(666, 'Gaspar', 'Giogia', domicilio('Chile', 123, 1),3,contrado(20, 25.5, 7)).
trabajador(777, 'Dana', 'Bambini', domicilio('Salta', 888, 2),1, efectivo(2500, 8, 2.5)).
trabajador(888, 'Gaston', 'Bravi', domicilio('Lujan', 104, 1),2, efectivo(1800, 9, 2)).

area(1, 'Gerencia').
area(2, 'Marketing').
area(3, 'Limpieza').

localidad(1, 'Cordoba').
localidad(2, 'Capilla del Monte').
localidad(3, 'Calamuchita').
localidad(4, 'Laborde').

% 1) Legajo, cantidad de horas trabajadas al mes y nombre del área en
% la que trabajan todos los empleados contratados.


punto1(Legajo, CantidadHoras, CodArea, Desc) :- trabajador(Legajo, _, _, _, CodArea, contrado(CantDias,_,HorasDia)),area(CodArea, Desc), CantidadHoras is (CantDias * HorasDia).

%2) Legajo, nombre, apellido, nombre de la localidad, nombre
% del area y cantidad de horas trabajadas por mes de aquellos empleados
% contratados que trabajen al mes más de 125hs.

punto2(Legajo, Nombre, Apellido, NombreLocalidad, NombreArea, CantidadHoras) :- trabajador(Legajo, Nombre, Apellido, domicilio(_,_,CodLoc), CodArea, contrado(CantDias,_,HorasDia)), area(CodArea,NombreArea), localidad(CodLoc, NombreLocalidad), CantidadHoras is (CantDias * HorasDia), CantidadHoras > 125.

%3) Legajo, nombre, apellido, nombre de la localidad, nombre
%del área y antigüedad de aquellos empleados efectivos con
%más de 10 años de antigüedad.

punto3(Legajo, Nombre, Apellido, NombreLocalidad, NombreArea, Antiguedad) :- trabajador(Legajo, Nombre, Apellido, domicilio(_,_,CodLoc), CodArea, efectivo(_,Antiguedad,_)), area(CodArea,NombreArea), localidad(CodLoc, NombreLocalidad), Antiguedad > 10.

% Legajo y salario (sin incluir los v iáticos) de todos los empleados, tanto contratados como efectivos.

punto4(Leg, SalContra, SalEfec):- trabajador(Leg, _, _, _, _, contratado(CantDias, PrecHora, HsDia), efectivo(Basico, Antig, Coef)), SalContra is (CantDias * PrecHora * HsDia), SalEfec is (Basico + (Basico * Antig) * (Coef / 100)