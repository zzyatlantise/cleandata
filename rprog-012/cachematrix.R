## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## This function creates a special "matrix" object that cna cache the inverse of a matrix
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setInverse <- function(inverse) m <<- inverse
  getInverse <- function() m
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


## Write a short comment describing this function
## This function computes the inverse of the spiecial "matrix" returned by makeCacheMatrix above.
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  m <- x$getInverse()
  if(!is.null(m)) {
    message("getting cached inverse of a matrix")
    return(m)
  }
  data <- solve(x$get())
  ##Set the value of the inverse
  m <- setInverse(data, ...)
  x$setInverse(m)
  return(m)
  
  
}