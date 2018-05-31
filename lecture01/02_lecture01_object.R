# vector
1:10
c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
v.10 <- 1:10
v.str <- c('one', 'two', 'three')

length(v.10)

typeof(v.10)
typeof(v.str)

v.diff <- c(1, 'one')

# double
typeof(1)
pi
typeof(pi)

# integer
typeof(1)
typeof(1L)
typeof(1:10)

# character
typeof(c('one', 'two'))
'1'
1
'1' + 1

# logical
1 > 2
2 > 1
typeof(1 > 2)
v.logic <- c(TRUE, FALSE)
typeof(v.logic)

# Attributes
v.10 <- 1:10
v.10
attributes(v.10)
dim(v.10)
dim(v.10) <- c(2, 5)
v.10
attributes(v.10)
typeof(v.10)
class(v.10)
class(1:10)

# factor
v.10 <- 1:10
f.10 <- factor(v.10)
f.10
class(f.10)
attributes(f.10)
typeof(f.10)
letters[1:10]

grades <- c('A', 'B', 'C', 'A', 'A+', 'B-')
grades
typeof(grades)
f.grades <- factor(grades)
f.grades
class(f.grades)
uf.grades <- unclass(f.grades)
uf.grades
class(uf.grades)
typeof(uf.grades)
attributes(uf.grades)
attributes(uf.grades) <- NULL
is.vector(uf.grades)

# indexing
v.10 <- 1:10
v.10
v.10[1]
v.10[2:4]
dim(v.10) <- c(2, 10)
v.10[1, 2]
v.10[1, 3:4]
v.10[-1, c(2, 5)]
v.10[1, ]
v.10[, 2]
