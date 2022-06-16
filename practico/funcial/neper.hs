factorial::Float->Float
factorial 0=1
factorial (n)=(n)*factorial(n-1)

neper::Float->Float
neper 0=1
neper (n)=neper(n-1)+1/(factorial n)

euler::Float->Float
euler 0.0=1
euler n=1.0/product[1..n]+euler(n-1.0) 