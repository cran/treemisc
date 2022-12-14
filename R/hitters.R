#' Baseball data (corrected)
#' 
#' Major League Baseball data from the 1986 and 1987 seasons.
#' 
#' @name hitters
#' 
#' @docType data
#' 
#' @format A data frame with 322 observations of major league players on the
#' following 20 variables.  
#' 
#' \describe{ 
#'   \item{AtBat}{Number of times at bat in 1986.} 
#'   \item{Hits}{Number of hits in 1986.}
#'   \item{HmRun}{Number of home runs in 1986.} 
#'   \item{Runs}{Number of runs in 1986.} 
#'   \item{RBI}{Number of runs batted in in 1986.}
#'   \item{Walks}{Number of walks in 1986.} 
#'   \item{Years}{Number of years in the major leagues.} 
#'   \item{CAtBat}{Number of times at bat during his career.} 
#'   \item{CHits}{Number of hits during his career.}
#'   \item{CHmRun}{Number of home runs during his career.}
#'   \item{CRuns}{Number of runs during his career.}
#'   \item{CRBI}{Number of runs batted in during his career.}
#'   \item{CWalks}{Number of walks during his career.}
#'   \item{League}{A factor with levels \code{A} and \code{N} indicating 
#'   player's league at the end of 1986.} 
#'   \item{Division}{A factor with levels \code{E} and \code{W} 
#'   indicating player's division at the end of 1986.} 
#'   \item{PutOuts}{Number of put outs in 1986.}
#'   \item{Assists}{Number of assists in 1986.}
#'   \item{Errors}{Number of errors in 1986.} 
#'   \item{Salary}{1987 annual salary on opening day in thousands of dollars.}
#'   \item{NewLeague}{A factor with levels \code{A} and \code{N} indicating 
#'   player's league at the beginning of 1987.} 
#' }
#' 
#' @references 
#' James, G., Witten, D., Hastie, T., and Tibshirani, R. (2013)
#' \emph{An Introduction to Statistical Learning with applications in R},
#' \url{https://www.statlearning.com}, Springer-Verlag, New York.
#' 
#' Hoaglin, D. C. and Velleman, P. F. (1995). 
#' \emph{A critical look at some analyses ofmajor league baseball salaries}.
#' The American Statistician, 49(3):277-285.
#' 
#' @note This is a corrected version of the \code{\link[ISLR]{Hitters}} data set 
#' based on the corrections listed in Hoaglin and Velleman (1995).
#' 
#' @seealso \code{\link[ISLR]{Hitters}}.
#' 
#' @keywords datasets
#' 
#' @examples
#' summary(hitters <-  treemisc::hitters)
#' plot(log(Salary) ~ Years, data = hitters)
NULL