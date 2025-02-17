test_that("pretty_mctq() | general test", {
    data <- data.frame(
        a = 1,
        b = lubridate::duration(1.12345),
        c = lubridate::period(1.12345),
        d = hms::hms(1.12345))

    object <- pretty_mctq(data, round = TRUE, hms = TRUE)
    expect_true(hms::is_hms(object$b), TRUE)
    expect_true(hms::is_hms(object$c), TRUE)

    object <- pretty_mctq(data, round = TRUE, hms = FALSE)
    expect_equal(object$b, lubridate::duration(as.integer(data$b)))
    expect_equal(object$c, lubridate::period(as.integer(data$c)))
    expect_equal(object$d, hms::hms(as.integer(data$d)))
})

test_that("pretty_mctq() | error test", {
    data <- datasets::iris

    # Invalid values for `data`, `round`, and `hms`
    expect_error(pretty_mctq(1, TRUE, TRUE))
    expect_error(pretty_mctq(data, "a", TRUE))
    expect_error(pretty_mctq(data, TRUE, ""))
})
