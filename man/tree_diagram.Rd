% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tree_diagram.R
\name{tree_diagram}
\alias{tree_diagram}
\title{Tree diagram}
\usage{
tree_diagram(object, prob = TRUE, box.palette = "BuOr", ...)
}
\arguments{
\item{object}{An \code{\link[rpart]{rpart}} object.}

\item{prob}{Logical indicating whether or not to display leaf node probability
estimates for classification trees; default is \code{TRUE}.}

\item{box.palette}{Chjaracter string specifying the palette to use for 
coloring the nodes; see \code{\link[rpart.plot]{rpart.plot}} for details.}

\item{...}{Additional optional argumebts to be passed onto 
\code{\link[rpart.plot]{rpart.plot}}.}
}
\value{
No return value, only called for side effects; in this case, a 
decision tree diagram constructed by a simple call to 
\code{\link[rpart.plot]{rpart.plot}}.
}
\description{
Draw a decision tree diagram from a fitted \code{\link[rpart]{rpart}} model.
}
\note{
This function is just a light wrapper around 
\code{\link[rpart.plot]{rpart.plot}} and was used to produce several of the
tree diagrams in the accompanying book.
}
