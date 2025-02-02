% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/le_week.R
\name{le_week}
\alias{le_week}
\title{Compute MCTQ average weekly light exposure}
\usage{
le_week(le_w, le_f, wd)
}
\arguments{
\item{le_w}{A \code{Duration} object corresponding to the \strong{light exposure on
workdays} from a standard version of the MCTQ questionnaire.}

\item{le_f}{A \code{Duration} object corresponding to the \strong{light exposure on
work-free days} from a standard version of the MCTQ questionnaire.}

\item{wd}{An \link[checkmate:checkIntegerish]{integerish} \code{numeric} object or
an \code{integer} object corresponding to the \strong{number of workdays per week}
from a standard version of the MCTQ questionnaire.}
}
\value{
A \code{Duration} object corresponding to the vectorized weighted mean of
\code{le_w} and \code{le_f} with \code{wd} and \code{fd(wd)} as weights.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#maturing}{\figure{lifecycle-maturing.svg}{options: alt='[Maturing]'}}}{\strong{[Maturing]}}

\code{le_week()} computes the \strong{average weekly light exposure} for the standard
version of the Munich Chronotype Questionnaire (MCTQ).
}
\details{
\strong{Standard MCTQ} functions were created following the guidelines in
Roenneberg, Wirz-Justice, & Merrow (2003), Roenneberg, Allebrandt, Merrow, &
Vetter (2012), and from The Worldwide Experimental Platform (theWeP, n.d.).

\strong{\eqn{\mu}MCTQ} functions were created following the guidelines in Ghotbi
\emph{et.al} (2020), in addition to the guidelines used for the standard MCTQ.

\strong{MCTQ\eqn{^{Shift}}{ Shift}} functions were created following the
guidelines in Juda, Vetter, & Roenneberg (2013), in addition to the
guidelines used for the standard MCTQ.

See the References section to learn more.
\subsection{Class requirements}{

The \code{mctq} package works with a set of object classes specially created to
hold time values. These classes can be found in the \link[hms:hms-package]{hms}
and \link[lubridate:lubridate-package]{lubridate} package. If your data do not
conform to the object classes required, you can use the \code{mctq}
\code{\link[=convert]{convert()}} function to convert it.
}

\subsection{Rounding and fractional time}{

Some operations may produce an output with fractional time (\emph{e.g.},
\code{"19538.3828571429s (~5.43 hours)"}; \code{01:15:44.505}). If you want, you
can round it with the \code{mctq} function \code{\link[=round_time]{round_time()}}.

Our recommendation is to avoid rounding, but, if you do, make sure that you
only round your values after all computations are done, that way you can
avoid \href{https://en.wikipedia.org/wiki/Round-off_error}{round-off errors}.
}
}
\section{Guidelines}{


Roenneberg, Allebrandt, Merrow, & Vetter (2012) and The Worldwide
Experimental Platform (n.d.) guidelines for \code{le_week()}
(\eqn{LE_{week}}{LE_week}) computation are as follows.
\subsection{Notes}{
\itemize{
\item The average weekly light exposure is the weighted average of the light
exposure on work and work-free days in a week.
\item If you are visualizing this documentation in plain text (\code{ASCII}), you may
have some trouble understanding the equations. If you want a better viewer,
you can see this documentation on the package
\href{https://gipsousp.github.io/mctq/reference/}{website}.
}
}

\subsection{Computation}{

\strong{\deqn{\frac{LE_W \times WD + LE_F \times FD}{7}}{
(LE_W * WD + LE_F * FD) / 7}}

Where:
\itemize{
\item \eqn{LE_W} = light exposure on workdays.
\item \eqn{LE_F} = light exposure on work-free days.
\item \eqn{WD} = number of workdays per week ("I have a regular work schedule and
work ___ days per week").
\item \eqn{FD} = number of work-free days per week.
}

\strong{*} \eqn{W} = workdays; \eqn{F} = work-free days.
}
}

\section{Missing sections in standard and micro MCTQ versions}{


Although the standard and micro versions of the MCTQ asks for subjects to
complete the workdays and work-free days sections, even when he/she do not
have a regular work schedule (\code{wd = 0}) or have a 7 day/week work schedule
(\code{wd = 7}), some of them may still end skipping one of this parts of the
questionnaire. In those cases, \code{sd_week()}, \code{sloss_week()}, \code{le_week()},
\code{msf_sc()}, \code{sjl_rel()}, and \code{sjl()} will produce \code{NA} (Not Available) as
output. That's because those computations combine workdays and work-free days
variables.

For those special standard and micro MCTQ cases, where one section is
missing, a \code{NA} value is the correct output for the functions mentioned above
when \code{wd} (number of workdays per week) are \code{wd > 0 & wd < 7}, but it may not
be when \code{wd == 0} or \code{wd == 7}. There are different approaches to deal with
those cases. See \code{vignette("missing-sections", package = "mctq")} to learn
more.
}

\examples{
## __ Scalar example __
le_w <- lubridate::dhours(1.5)
le_f <- lubridate::dhours(3.7)
wd <- 5
le_week(le_w, le_f, wd)
#> [1] "7662.85714285714s (~2.13 hours)" # Expected

le_w <- lubridate::dhours(3)
le_f <- lubridate::dhours(1.5)
wd <- 6
le_week(le_w, le_f, wd)
#> [1] "10028.5714285714s (~2.79 hours)" # Expected

le_w <- lubridate::dhours(5.6)
le_f <- lubridate::as.duration(NA)
wd <- 3
le_week(le_w, le_f, wd)
#> [1] NA # Expected

## __ Vector example __
le_w <- c(lubridate::dhours(3), lubridate::dhours(2.45))
le_f <- c(lubridate::dhours(3), lubridate::dhours(3.75))
wd <- c(4, 5)
le_week(le_w, le_f, wd)
#> [1] "10800s (~3 hours)" # Expected
#> [2] "10157.1428571429s (~2.82 hours)" # Expected

## __ Checking second output from vector example __
if (requireNamespace("stats", quietly = TRUE)) {
    i <- 2
    x <- c(le_w[i], le_f[i])
    w <- c(wd[i], fd(wd[i]))
    lubridate::as.duration(stats::weighted.mean(x, w))
}
#> [1] "10157.1428571429s (~2.82 hours)" # Expected

## __ Converting the output to `hms` __
le_w <- lubridate::dhours(1.25)
le_f <- lubridate::dhours(6.23)
wd <- 3
x <- le_week(le_w, le_f, wd)
x
#> [1] "14744.5714285714s (~4.1 hours)" # Expected
convert(x, "hms")
#> 04:05:44.571429 # Expected

## __ Rounding the output at the seconds level __
le_w <- lubridate::dhours(3.4094)
le_f <- lubridate::dhours(6.2345)
wd <- 2
x <- le_week(le_w, le_f, wd)
x
#> [1] "19538.3828571429s (~5.43 hours)" # Expected
round_time(x)
#> [1] "19538s (~5.43 hours)" # Expected
}
\references{
Ghotbi, N., Pilz, L. K., Winnebeck, E. C., Vetter, C., Zerbini, G., Lenssen,
D., Frighetto, G., Salamanca, M., Costa, R., Montagnese, S., & Roenneberg, T.
(2020). The \eqn{\mu}MCTQ: an ultra-short version of the Munich ChronoType
Questionnaire. \emph{Journal of Biological Rhythms}, \emph{35}(1), 98-110.
\doi{10.1177/0748730419886986}.

Juda, M., Vetter, C., & Roenneberg, T. (2013). The Munich ChronoType
Questionnaire for shift-workers (MCTQ\eqn{^{Shift}}{ Shift}). \emph{Journal of
Biological Rhythms}, \emph{28}(2), 130-140. \doi{10.1177/0748730412475041}.

Roenneberg T., Allebrandt K. V., Merrow M., & Vetter C. (2012). Social jetlag
and obesity. \emph{Current Biology}, \emph{22}(10), 939-43.
\doi{10.1016/j.cub.2012.03.038}.

Roenneberg, T., Wirz-Justice, A., & Merrow, M. (2003). Life between clocks:
daily temporal patterns of human chronotypes. \emph{Journal of Biological
Rhythms}, \emph{18}(1), 80-90. \doi{10.1177/0748730402239679}.

The Worldwide Experimental Platform (n.d.). MCTQ. Retrieved from
\url{https://www.thewep.org/documentations/mctq/}.
}
\seealso{
Other MCTQ functions: 
\code{\link{fd}()},
\code{\link{gu}()},
\code{\link{msf_sc}()},
\code{\link{ms}()},
\code{\link{napd}()},
\code{\link{sd24}()},
\code{\link{sd_overall}()},
\code{\link{sd_week}()},
\code{\link{sd}()},
\code{\link{sjl_weighted}()},
\code{\link{sjl}()},
\code{\link{so}()},
\code{\link{tbt}()}
}
\concept{MCTQ functions}
