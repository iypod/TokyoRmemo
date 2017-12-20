paste(Sys.Date(), "時点")

start <- as.Date("2017-06-01")
today <- as.Date("2017-06-20")
all_days <- seq(start, today, by = "day")
all_days

year <- as.POSIXlt(all_days)$year + 1900
urls <- paste0('http://cran-logs.rstudio.com/', year, '/', all_days, '.csv.gz')
download.file(urls, "testdl_cranpackage.tsv")

check_file <- read.csv("testdl_cranpackage.tsv")
dim(check_file)
