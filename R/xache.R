#' xache
#'
#' `xache` works as follows:
#' 
#' 1. If the specified variable exists, nothing happens because there is no need
#'    to recompute its contents.
#' 2. If it the variable does not exist, `xache` will attempt to load it from the
#'    specified RData file.
#' 3. If the RData file does not exist, the specified function will evaluate the
#'    specified function, and store its results in the specified variable as well
#'    as in the RData file.
#'
#' @param symbol A string representing the variable that holds the results.
#' @param file A path towards a RData file from which to load and to which to #'   save the contents of the above variable.
#' @param init A function that will generate the contents if it does not already exist.
#' @param ... Arguments to pass to the init function.
#' @param verbose Whether to print debug messages to screen.  Defaults to FALSE.
#' @param force Whether to force recomputation.  Defaults to FALSE.
#' @param envir The environment in which to look for, and if it does not already exist, to create the variable of interest.
#' @export
#' @examples
#' xache("test", "test.RData", function () {
#'  # do some calculation
#'  2 * 2 # dummy result
#' })

xache <- function(symbol,
                  file,
                  init,
                  ...,
                  verbose = FALSE,
                  force   = FALSE,
                  envir   = parent.frame()) {

  if (base::exists(symbol, envir = envir) && !force) {
    # Do nothing if variable exists in environment
  } else if (file.exists(file) && !force) {
    if (verbose)
      message(paste("Load workspace from file", file))
    # Load workspace from file into environment if workspace exists when variable does not exist
    load(file, envir = envir)
  } else {
    if (verbose)
      message(paste("Compute into variable", symbol))
    # Compute into variable in environment
    sub.envir       <- new.env(envir)
    sub.envir$init  <- init
    envir[[symbol]] <- with(sub.envir, init)(...)
    # Save environment to disk
    save(list  = symbol,
         file  = file,
         envir = envir)
  }
}
