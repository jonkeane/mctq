% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fd.R
\name{fd}
\alias{fd}
\title{Compute MCTQ work-free days}
\usage{
fd(wd)
}
\arguments{
\item{wd}{An \link[checkmate:checkIntegerish]{integerish} \code{numeric} object or
an \code{integer} object corresponding to the \strong{number of workdays per week}
from a standard or micro version of the MCTQ questionnaire.}
}
\value{
An \code{integer} object corresponding to the difference between the
number of days in a week (7) and the number of workdays (\code{wd}).
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#maturing}{\figure{lifecycle-maturing.svg}{options: alt='[Maturing]'}}}{\strong{[Maturing]}}

\code{fd()} computes the \strong{number of work-free days per week} for standard
and micro versions of the Munich Chronotype Questionnaire (MCTQ).
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
}
\section{Guidelines}{


Roenneberg, Allebrandt, Merrow, & Vetter (2012) and The Worldwide
Experimental Platform (n.d.) guidelines for \code{fd()} (\eqn{FD}) computation are
as follows.

\strong{\deqn{7 - WD}}

Where:
\itemize{
\item \eqn{WD} = number of workdays ("I have a regular work schedule and work ___
days per week").
}
}

\examples{
## __ Scalar example __
fd(5)
#> [1] 2 # Expected
fd(4)
#> [1] 3 # Expected
fd(as.numeric(NA))
#> [1] NA # Expected

## __ Vector example __
fd(0:7)
#> [1] 7 6 5 4 3 2 1 0 # Expected
fd(c(1, NA))
#> [1]  6 NA # Expected
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
\code{\link{gu}()},
\code{\link{le_week}()},
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
