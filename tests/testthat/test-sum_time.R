test_that("sum_time() | non-vectorized test", {
    t <- c(lubridate::dhours(1), lubridate::dminutes(30))
    u <- lubridate::hours(1)
    v <- c(as.difftime(1, units = "hours"), as.difftime(30, units = "mins"))
    w <- c(hms::parse_hm("02:00"), hms::parse_hm("02:00"))
    x <- lubridate::as_datetime("1970-01-01 20:00:00")
    y <- as.POSIXlt(lubridate::as_datetime("1970-01-01 01:00:00"))
    z <- lubridate::as.interval(lubridate::dhours(1), as.Date("1970-01-01"))

    class <- "duration"
    circular <- FALSE
    vectorize <- FALSE
    na.rm <- FALSE
    object <- sum_time(t, u, v, w, x, y, z, class = class, circular = circular,
                       vectorize = vectorize, na.rm = na.rm)
    expected <- lubridate::dhours(30)
    expect_equal(object, expected) # 30:00:00

    class <- "hms"
    circular <- TRUE
    vectorize <- FALSE
    na.rm <- FALSE
    object <- sum_time(t, u, v, w, x, y, z, class = class, circular = circular,
                       vectorize = vectorize, na.rm = na.rm)
    expected <- hms::parse_hm("06:00")
    expect_equal(object, expected) # 06:00 | 30 - 24

    i <- hms::as_hms(NA)
    class <- "period"
    circular <- FALSE
    vectorize <- FALSE
    na.rm <- FALSE
    object <- sum_time(i, t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- lubridate::as.period(NA)
    expect_equal(object, expected)

    i <- hms::as_hms(NA)
    class <- "period"
    circular <- FALSE
    vectorize <- FALSE
    na.rm <- TRUE
    object <- sum_time(i, t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- lubridate::as.period(hms::hms(108000))
    expect_equal(object, expected) # 30:00:00

    i <- hms::as_hms(NA)
    class <- "difftime"
    circular <- TRUE
    vectorize <- FALSE
    na.rm <- TRUE
    object <- sum_time(i, t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- lubridate::as.difftime(21600, units = "secs")
    expect_equal(object, expected)
})

test_that("sum_time()| vectorized test", {
    t <- c(lubridate::dhours(1), lubridate::dminutes(30))
    u <- c(lubridate::hours(1), lubridate::hours(1))
    v <- c(as.difftime(1, units = "hours"), as.difftime(30, units = "mins"))
    w <- c(hms::parse_hm("02:00"), hms::parse_hm("02:00"))
    x <- c(lubridate::as_datetime("1970-01-01 20:00:00"),
           lubridate::as_datetime("1970-01-01 10:00:00"))
    y <- c(lubridate::as_datetime("1970-01-01 01:00:00"),
           lubridate::as_datetime("1970-01-01 02:00:00"))
    y <- as.POSIXlt(y)
    z <- c(lubridate::as.interval(lubridate::dhours(4), as.Date("1970-01-01")),
           lubridate::as.interval(lubridate::dhours(1), as.Date("1970-01-01")))

    class <- "duration"
    circular <- FALSE
    vectorize <- TRUE
    na.rm <- FALSE
    object <- sum_time(t, u, v, w, x, y, z, class = class, circular = circular,
                       vectorize = vectorize, na.rm = na.rm)
    expected <- c(lubridate::dhours(30), lubridate::dhours(17))
    expect_equal(object, expected) # 30:00:00 | 17:00:00

    class <- "hms"
    circular <- TRUE
    vectorize <- TRUE
    na.rm <- FALSE
    object <- sum_time(t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- c(hms::parse_hm("06:00"), hms::parse_hm("17:00"))
    expect_equal(object, expected) # 06:00:00 | 17:00:00

    i <- c(hms::as_hms(NA), hms::as_hms(NA))
    class <- "period"
    circular <- FALSE
    vectorize <- TRUE
    na.rm <- FALSE
    object <- sum_time(i, t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- c(lubridate::as.period(NA), lubridate::as.period(NA))
    expect_equal(object, expected)

    i <- c(hms::as_hms(NA), hms::as_hms(NA))
    class <- "period"
    circular <- FALSE
    vectorize <- TRUE
    na.rm <- TRUE
    object <- sum_time(i, t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- c(lubridate::as.period(hms::hms(108000)),
                  lubridate::as.period(hms::hms(61200)))
    expect_equal(object, expected) # 30:00:00 | 17:00:00

    i <- c(hms::as_hms(NA), hms::as_hms(NA))
    class <- "difftime"
    circular <- TRUE
    vectorize <- TRUE
    na.rm <- TRUE
    object <- sum_time(i, t, u, v, w, x, y, z, class = class,
                       circular = circular, vectorize = vectorize,
                       na.rm = na.rm)
    expected <- c(lubridate::as.difftime(21600, units = "secs"),
                  lubridate::as.difftime(61200, units = "secs"))
    expect_equal(object, expected)
})

test_that("sum_time() | error test", {
    # Invalid values for `...`, `class`, `circular`, `vectorize` and `na.rm`
    expect_error(sum_time(1, class = "", circular = TRUE,
                          vectorize = TRUE, na.rm = TRUE))
    expect_error(sum_time(hms::hms(1), class = 1, circular = TRUE,
                          vectorize = TRUE, na.rm = TRUE))
    expect_error(sum_time(hms::hms(1), class = "", circular = "",
                          vectorize = TRUE, na.rm = TRUE))
    expect_error(sum_time(hms::hms(1), class = "", circular = TRUE,
                          vectorize = "", na.rm = TRUE))
    expect_error(sum_time(hms::hms(1), class = "", circular = TRUE,
                          vectorize = TRUE, na.rm = ""))

    # "When `vectorize` is `TRUE`, all values in `...` must have [...]"
    expect_error(sum_time(hms::hms(1), c(hms::hms(1), hms::hms(1)),
                          vectorize = TRUE))
})
