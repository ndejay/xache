xache
=====

If you're like me, you probably find yourself writing some variation of the
following routine in order to avoid unnecessarily performing heavy
computations multiple times, across instances of R:

```{r}
init <- function () {
  # do some calculation
  2 * 2 # dummy result
}

if (!exists("test")) { # Do nothing if variable exists in environment
  file <- "test.RData"
  if (!file.exists(file)) {
    load("test.RData") # Load workspace that contains the variable
  } else {
    test <- init() # Compute content of variable by calling a zero argument function
    save("test", "test.RData") # Save variable into workspace
  }
}
```

I wrote the `xache` function to be able to simplify this process to the
following bit of code:

```{r}
xache("test", "test.RData", init)

xache("test", "test.RData", function () {
  # do some calculation
  2 * 2 # dummy result
})
```

`xache` works as follows:

1. If the specified variable exists, nothing happens because there is no need
   to recompute its contents.
2. If it the variable does not exist, `xache` will attempt to load it from the
   specified RData file.
3. If the RData file does not exist, the specified function will evaluate the
   specified function, and store its results in the specified variable as well
   as in the RData file.

Installation
------------

```{r}
install.packages("devtools")
library("devtools")
devtools::install_github("ndejay/xache")
library("xache")
```

License
-------

Copyright (c) 2016 Nicolas De Jay

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
