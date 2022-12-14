#' Gradient tree boosting with least squares (LS) loss
#' 
#' A poor-man's implementation of stochastic gradient tree boosting with LS 
#' loss.
#' 
#' @param X A data frame of only predictors.
#' 
#' @param y A vector of response values
#' 
#' @param ntree Integer specifying the number of trees to use in the ensemble.
#' 
#' @param shrinkage Numeric specifying the shrinkage factor.
#' 
#' @param depth Integer specifying the depth of each tree.
#' 
#' @param subsample Numeric specifying the proportion of the training data to
#' randomly sample before building each tree. Default is \code{0.5}.
#' 
#' @param init Numeric specifying the initial value to boost from. Defaults to
#' the mean response (i.e., \code{mean(y)}).
#' 
#' @return An object of class \code{"lsboost"} which is just a list with the 
#' following components:
#' \itemize{
#'   \item \code{trees} A list of length \code{ntree} containing the individual 
#'   \code{\link[rpart]{rpart}} tree fits.
#'   \item \code{shrinkage} The corresponding shrinkage parameter.
#'   \item \code{depth} The maximum depth of each tree.
#'   \item \code{subsample} The (row) subsampling rate.
#'   \item \code{init} The initial constant fit.
#' }
#' 
#' @note 
#' By design, the final model does not include the predictions from the initial
#' (constant) fit. So the constant is stored in the \code{init} component of the
#' returned output to be used later by \code{predict.lsboost()}.
#'
#' @rdname lsboost
#' 
#' @export
#' 
#' @examples 
#' # Simulate data from the Friedman 1 benchmark problem
#' set.seed(1025)  # for reproducibility
#' trn <- gen_friedman1(500)  # training data
#' tst <- gen_friedman1(500)  # test data
#' 
#' # Gradient boosted decision trees
#' set.seed(1027)  # for reproducibility
#' bst <- lsboost(subset(trn, select = -y), y = trn$y, depth = 2)
#' pred <- predict(bst, newdata = tst)
#' mean((pred - tst$y) ^ 2)
lsboost <- function(X, y, ntree = 100, shrinkage = 0.1, depth = 6, 
                    subsample = 0.5, init = mean(y)) {
  yhat <- rep(init, times = nrow(X))  # initialize fit
  trees <- vector("list", length = ntree)  # to store each tree
  ctrl <- rpart::rpart.control(cp = 0, maxdepth = depth, minbucket = 10)
  for (tree in seq_len(ntree)) {
    id <- sample.int(nrow(X), size = floor(subsample * nrow(X)))
    samp <- X[id, ]
    samp$pr <- y[id] - yhat[id]
    trees[[tree]] <- 
      rpart::rpart(pr ~ ., data = samp, control = ctrl)
    yhat <- yhat + shrinkage * predict(trees[[tree]], newdata = X)
  }
  res <- list("trees" = trees, "shrinkage" = shrinkage, "depth" = depth,
              "subsample" = subsample, "init" = init)
  class(res) <- "lsboost"
  res
}


#' Print method for \code{lsboost} objects
#' 
#' Print basic information about a fitted \code{"lsboost"} object.
#' 
#' @param x An object of class \code{"lsboost"}.
#' 
#' @param ... Additional optional arguments. (Currently ignored.)
#'
#' @rdname lsboost
#' 
#' @export
print.lsboost <- function(x, ...) {
  cat("Gradient tree boosting with least squares (LS) loss", "\n\n")
  cat("            Initial fit:", x$init[1L], "\n")
  cat("        Number of trees:", length(x$trees), "\n")
  cat("Shrinkage/learning rate:", x$shrinkage, "\n")
  cat("     Maximum tree depth:", x$depth, "\n")
  cat("     Row subsample rate:", x$subsample, "\n")
}


#' Predict method for \code{lsboost} objects
#' 
#' Compute predictions from an \code{"lsboost"} object using new data.
#' 
#' @param object An object of class \code{"lsboost"}.
#' 
#' @param newdata Data frame of new observations for making predictions.
#' 
#' @param ntree Integer specifying the number of trees in the ensemble to use.
#' Defaults to using all the trees in the ensemble.
#'
#' @param individual Logical indicating whether or not to return the (shrunken)
#' predictions from each tree individually (\code{TRUE}) or the overall ensemble
#' prediction (\code{FALSE}). Default is \code{FALSE}.
#' 
#' @param ... Additional optional arguments. (Currently ignored.)
#' 
#' @return A vector (\code{individual = TRUE}) or matrix 
#' (\code{individual = FALSE}) of predictions.
#'
#' @rdname lsboost
#' 
#' @export
predict.lsboost <- function(object, newdata, ntree = NULL, 
                            individual = FALSE, ...) {
  if (is.null(ntree)) {
    ntree <- length(object[["trees"]])
  }
  shrinkage <- object[["shrinkage"]]
  trees <- object[["trees"]][seq_len(ntree)]
  pmat <- sapply(trees, FUN = function(tree) {
    shrinkage * predict(tree, newdata = newdata)
  })
  if (isTRUE(individual)) {
    pmat
  } else {
    rowSums(pmat) + object$init
  }
}
