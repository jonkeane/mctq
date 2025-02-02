#' Round time values
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `round_time()` takes a `Duration`, `Period`, `difftime`, `hms`, `POSIXct`, or
#' `POSIXlt` object and round its `numeric` value at the ones place.
#'
#' @details
#'
#' `round_time()` uses [base::round()] for rounding. That is to say that
#' `round_time()` uses the same IEC 60559 standard (_"go to the even digit"_)
#' for rounding off a 5. Therefore, `round(0.5)` is equal to 0 and `round(-1.5)`
#' is equal to -2. See `?round` to learn more.
#'
#' @param x An object belonging to one of the following classes: `Duration`,
#'   `Period`, `difftime`, `hms`, `POSIXct`, or `POSIXlt`.
#'
#' @return An object of the same class of `x` with its `numeric` value rounded
#'   at the ones place.
#'
#' @seealso Other date-time rounding functions: [hms::round_hms()]
#'   [hms::trunc_hms()] [lubridate::round_date()].
#'
#' @family utility functions
#' @export
#'
#' @examples
#' ## __ Scalar example __
#' lubridate::dmilliseconds(123456789)
#' #> [1] "123456.789s (~1.43 days)" # Expected
#' round_time(lubridate::dmilliseconds(123456789))
#' #> [1] "123457s (~1.43 days)" # Expected
#'
#' lubridate::microseconds(123456789)
#' #> [1] "123.456789S" # Expected
#' round_time(lubridate::microseconds(123456789))
#' #> [1] "123S" # Expected
#'
#' as.difftime(12345.6789, units = "hours")
#' #> Time difference of 12345.68 hours # Expected
#' round_time(as.difftime(12345.6789, units = "hours"))
#' #> Time difference of 12346 hours # Expected
#'
#' hms::as_hms(12345.6789)
#' #> 03:25:45.6789 # Expected
#' round_time(hms::as_hms(12345.6789))
#' #> 03:25:46 # Expected
#'
#' lubridate::as_datetime(12345.6789, tz = "EST")
#' #> [1] "1969-12-31 22:25:45 EST" # Expected
#' as.numeric(lubridate::as_datetime(12345.6789, tz = "EST"))
#' #> [1] 12345.68 # Expected
#' round_time(lubridate::as_datetime(12345.6789, tz = "EST"))
#' #> [1] "1969-12-31 22:25:46 EST" # Expected
#' as.numeric(round_time(lubridate::as_datetime(12345.6789, tz = "EST")))
#' #> [1] 12346 # Expected
#'
#' ## __ Vector example __
#' x <- c(lubridate::dhours(5.6987), lubridate::dhours(2.6875154))
#' x
#' #> [1] "20515.32s (~5.7 hours)"    "9675.05544s (~2.69 hours)" # Expected
#' round_time(x)
#' #> [1] "20515s (~5.7 hours)" "9675s (~2.69 hours)" # Expected
round_time <- function(x) {
    classes <- c("Duration", "Period", "difftime", "hms", "POSIXct", "POSIXlt")
    checkmate::assert_multi_class(x, classes)

    class <- class(x)[1]
    if (class == "difftime") units <- units(x)
    if (class %in% c("POSIXct", "POSIXlt")) tz <- attributes(x)$tzone[1]

    x <- round(as.numeric(x))

    if (class == "difftime") {
        as.difftime(x, units = units)
    } else if (class %in% c("POSIXct", "POSIXlt")) {
        convert(x, class, tz = tz, quiet = TRUE)
    } else {
        convert(x, class, quiet = TRUE)
    }
}
