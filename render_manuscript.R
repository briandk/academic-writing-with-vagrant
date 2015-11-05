arguments <- commandArgs()
manuscript <- arguments[length(arguments)]

rmarkdown::render(manuscript)
