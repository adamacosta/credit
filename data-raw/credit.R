library(dplyr)
library(car)

url <- paste0('https://archive.ics.uci.edu/ml/machine-learning-databases/',
              'credit-screening/crx.data')

inFile <- file.path('data', 'crx.data')
outFile <- file.path('data', 'crx.rda')

if (file.exists(outFile)) stop('crx.dra already exists')

if (!file.exists(inFile)) {
    download.file(url = url, destfile = inFile, method = 'curl')
}

crx <- read.csv(inFile,
                na.strings = '?',
                colClasses = c('factor', 'numeric', 'numeric',
                               'factor', 'factor', 'factor',
                               'factor', 'numeric', 'factor',
                               'factor', 'integer', 'factor',
                               'factor', 'integer', 'integer',
                               'character')) %>%
    tbl_df()

names(crx) <- c('A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9',
                'A10', 'A11', 'A12', 'A13', 'A14', 'A15', 'accepted')
crx$accepted <- car::recode(crx$accepted,
                            recodes = "'+' = 1; '-' = 0")
save(crx, file = outFile)
system(paste('rm -f', inFile))
rm(list = ls())
