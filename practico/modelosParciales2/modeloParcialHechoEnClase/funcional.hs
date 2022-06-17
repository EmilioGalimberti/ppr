--1) Una función llamada importeAlquilerCasa que reciba 4 parámetros: la 
--cantidad de metros cuadrados cubiertos, la cantidad de metros cuadrados 
--descubiertos, el código de localidad, y el código de temporada 
--(1:”Temporada Baja”, 2:”Otras Temporadas”). La función deberá calcular y 
--devolver el importe de alquiler de dicho inmueble. En caso que el código 
--de temporada no sea ni 1 ni 2, la función deberá devolver -1.0. 
--Utilizar expresiones: con guardas, if-then-else y where. 

--MetrosCubiertos, MetrosDescubiertos, CodigoLocalidad, CodigoTemporada

--USANDO EL ELSE
--USANDO EL THEN

importeAlquilerCasa::(Float,Float,Int,Int)->Float
importeAlquilerCasa(cub,descub,loc,temp)
	| temp == 1 = if loc==1 then alq-alq*0.3 else alq-alq*0.5
	| temp == 2 = alq
	| otherwise = -1.0
	where alq = 20.0*cub+10.0*descub

--2) Una función llamada importeAlquilerDepto que reciba 4 parámetros: la 
--cantidad de metros cuadrados cubiertos, el monto de expensas, el código 
--de localidad, y el código de temporada (1:”Temporada Baja”, 2:”Otras 
--Temporadas”). La función deberá calcular y devolver el importe de alquiler 
--de dicho inmueble. No validar el código de temporada. Utilizar 
--expresiones: case-of, if-then-else y where.


--SIN USAR EL ELSE
--SIN USAR EL THEN
importeAlquilerDepto::(Float,Float,Int,Int) -> Float
importeAlquilerDepto(cantMetros,expensas,codLoc,codTemp)
	| codTemp == 1 && codLoc == 1 = alq-alq*0.3
	| codTemp == 1 && codLoc /= 1 = alq-alq*0.5
	| codTemp == 2 = alq
	| otherwise = 0.0
	where alq = (20.0*cantMetros)+expensas

--3) Una función importePromedioAlquiler que reciba como parámetro una 
--lista con los importes de alquiler y devuelva el valor promedio de todos 
--los importes de la lista. Durante el cálculo del valor promedio se deberá 
--utilizar recursividad.

--sumar::[Integer]-> Integer
sumar []= 0
sumar (x:xs) =  x + sumar(xs)


--contar::[Integer]-> Integer
contar []=0
contar (_:xs) = 1 + contar(xs)

--importePromedioAlquiler:: [Integer]-> Integer
importePromedioAlquiler listaImportes
	| contador == 0 = 0
	| otherwise = suma / contador
	where
          contador=contar listaImportes 
          suma = sumar listaImportes

--otra forma de hacer
-- El `div` acepta enteros, entonces al usar el tipificado Integer, necistaremos usar el div, osino nos dara fractional error

promedioAlquiler listaImportes = sumar listaImportes `div` fromIntegral(length listaImportes)
	