print(fibo(1) == 1)
print(fibo(2) == 1)
print(fibo(3) == 2)
print(fibo(4) == 3)
print(fibo(5) == 5)

fibo <- function(n) {
  if(n > 2)
    fibo(n - 2) + fibo(n - 1)
  else
    1
}
