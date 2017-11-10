
## These functions will allow you cache the inverse of a matrix rather than compute it repeatedly

# Example Usage
#
# Create a vector
#     A <- matrix( c(1, 4, 5, 4, 1, 5, 2, 12, 8), nrow=3, ncol=3)
#
# Create the special vector which contains a list of funtions required to call the cacheSolve function
#     tmp <- makeCacheMatrix(A)
#
# Return the inverse of the matrix, either by getting it in the cache, or by calculating it
#     cacheSolve(tmp)


## Creates the special vector which contains a list of funtions (set, get, setsolve, getsolve) required to call the cacheSolve function
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) m <<- solve
  getsolve <- function() m
  list(set = set, get = get,
    setsolve = setsolve,
    getsolve = getsolve)
}



# Return the inverse of the matrix x, either by getting it in the cache, or by calculating it
cacheSolve <- function(x, ...) {
  m <- x$getsolve()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setsolve(m)
  m
}

