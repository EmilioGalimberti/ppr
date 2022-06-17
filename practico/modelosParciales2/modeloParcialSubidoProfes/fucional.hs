lista :: [Integer]
lista = [1808, 2619, 3995, 4428, 2448, 7811]

--1. Realizar una función que reciba un código de tipo cliente, un monto base y que retorne el 
--monto final a pagar teniendo en cuenta el descuento que se detalla en la Tabla 1. En el caso 
--que el código de tipo de cliente no sea ninguno de los especificados en la Tabla 1 la función 
--deberá retornar cero.
funcion1:: Int -> Float -> Float
funcion1 codigoTipoCliente monto
	| (codigoTipoCliente == 1) =  monto-monto*0.3
	| (codigoTipoCliente == 2) = (monto - (monto * 0.5))
	| (codigoTipoCliente == 3) = (monto - (monto * 0.7))
        | otherwise = 0.0

--DIFERENTE ENTRADA DE ARGUMENTOS
funcion1Dif :: (Int,Float) -> Float
funcion1Dif (codigoTipoCliente, monto)
	| (codigoTipoCliente == 1) =  monto-monto*0.3
	| (codigoTipoCliente == 2) = (monto - (monto * 0.5))
	| (codigoTipoCliente == 3) = (monto - (monto * 0.7))
        | otherwise = 0.0

--2. Realizar una función que genere una nueva lista tomando como base los elementos de la 
--lista provista que estén comprendidos entre un valor desde y hasta (no se incluye los 
--extremos). Estos últimos deben ser pasados como argumentos a la función. 

--Con recursion

--USO IF

--REPASAR BIEN EL TEMA DE CABEZA COLA
funcion2:: [Integer] -> Integer -> Integer -> [Integer]
funcion2 [] _ _ = []
funcion2 (x:xs) desde hasta = if ( x > desde && x < hasta)  then x:(funcion2 xs desde hasta) else (funcion2 xs desde hasta)


--usando guardas

--ME DA ERROR
funcion2Guardas:: [Integer] -> Integer -> Integer -> [Integer]
funcion2Guardas (x:xs) desde hasta
	| x > desde && x < hasta = x:(funcion2Guardas xs desde hasta)
	| otherwise = funcion2Guardas xs desde hasta

-- POR COMPRESION FUNCA BIEN

funcion2Compresion (x:xs) desde hasta = [x| x <- xs, x>desde && x <hasta]

--SACAR PORTENTAJE DE ALGO REGLA DE 3 SIMPLE
-- tengo 10 numeros y 6 son pares
-- 6/100  * 10

--3. Realizar una función que permita calcular el porcentaje de elementos de la lista provista 
--que cumplen con estas condiciones: 
--a. Sea superior a un determinado valor “p”.
--b. Y que sea par.
--Con respecto a la cantidad total de elementos de la misma. Implementar esta consigna 
--usando recursividad en todas las funciones que Ud. considere necesario realizar.

--PARA sacar cantidad de mayores a P y pares
funcion3a [] _ = 0
funcion3a (x:xs) p = if ( x > p && even x) then 1 + (funcion3a xs p) else (funcion3a xs p)

--Calculo porcentaje
funcion3 lista p = fromIntegral((funcion3a lista p)*100) / fromIntegral(length lista)