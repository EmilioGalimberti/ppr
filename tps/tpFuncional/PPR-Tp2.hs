crecimientoPorAnio :: Integer -> Integer
crecimientoPorAnio x
	| x == 1 = 22
	| x == 2 = 20
	| x == 3 = 18
	| x == 4 = 16
	| x == 5 = 14
	| x == 6 = 12
	| x == 7 = 10
	| x == 8 = 8
	| x == 9 = 6
	| x == 10 = 4
	| x == 11 = 2
	| x == 12 = 1
	| otherwise = 0

sumar :: [Integer] -> Integer 
sumar [] = 0
sumar (x:xs) = crecimientoPorAnio x + sumar xs

crecimientoEntre :: Integer -> Integer -> Integer
crecimientoEntre _ 0 = 0
crecimientoEntre 0 _ = 0
crecimientoEntre 0 0 = 0
crecimientoEntre desde hasta = sumar [desde..hasta]

alturasEnUnAnio :: Integer -> [Integer] -> [Integer]
alturasEnUnAnio _ [] = []
alturasEnUnAnio 0 _ = []
alturasEnUnAnio y (x:xs) = (crecimientoPorAnio y) + x : alturasEnUnAnio y xs

alturaEnEdades :: Integer -> Integer -> [Integer] -> [Integer] 
alturaEnEdades _ _ [] = []
alturaEnEdades _ 0 _ = []
alturaEnEdades 0 _ _ = []
alturaEnEdades altura edad (x:xs) = altura + (crecimientoEntre edad x) : alturaEnEdades altura edad xs 

separarTupla :: (Integer, Integer) -> Integer -> Integer
separarTupla (edad, altura) incremento = altura + crecimientoEntre edad (edad + incremento)

alturasPara :: [(Integer, Integer)] -> [Integer] -> [Integer] 
alturasPara [] [] = []
alturasPara _ [] = []
alturasPara [] _ = []
alturasPara (x:xs) (y:ys) = separarTupla x y : alturasPara xs ys

 