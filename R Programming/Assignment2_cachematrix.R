## The project contains two functions that cache the inverse of the matrix

## The function creates a list of
##      set the value of the matrix
##      get the value of the matrix
##      set the value of the inverse matrix
##      get the value of the inverse matrix


## Asumming all the the matrices are invertible

makeCacheMatrix <- function(x = matrix()) {
        
        #inverse variable
        inv <- NULL 
        
        set <- function(y) 
        {
                x <<- y
                inv <<- NULL
        }
        
        get <- function() x

        setinv <- function(solve) inv <<- solve
        
        getinv <- function() inv
        
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
        
        ## Returns a list described above
}


## The function checks if there already exists an inverse matrix.
## If so, then it is returned. Elsewise, it computes it.

cacheSolve <- function(x, ...) {
        
        
        inv <- x$getinv()
        
        if(!is.null(inv)) 
        {
        message("getting cached data")
        return(inv)
        }
        
        data <- x$get()
        inv <- solve(data, ...)
        x$setinv(inv)
        inv
        
        ## Returns a matrix that is the inverse of 'x' 
}
