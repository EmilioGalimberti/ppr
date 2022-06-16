sumaL::[Float]->Float
sumaL []=0
sumL (x:xs)=x+sumL xs

prom xs= sum xs/fromIntegral(length xs)

promList::[[Float]]->[Float]
promList xs=map prom xs