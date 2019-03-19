# Load required library
library(tidyverse)

# Load file
path <- "~/Downloads/toy_data.csv"
toy_data <- read.csv(path)

toy_data$genomeLength <- as.factor(toy_data$genomeLength)


# IN-LINE SUMMARY ---------------------
# Summary
df_summary <- toy_data %>%
    group_by(update,genomeLength) %>%
    summarize(count.mean = mean(countPoint), count.sd = sd(countPoint))
df_summary$n <- length(levels(toy_data$repNum))
df_summary$sem <- df_summary$count.sd/sqrt(df_summary$n-1)
df_summary$LoCI <- df_summary$count.mean + qt((1.0-0.95)/2, df=df_summary$n-1)*df_summary$sem
df_summary$HiCI <- df_summary$count.mean - qt((1.0-0.95)/2, df=df_summary$n-1)*df_summary$sem

ggplot(data=df_summary) +
    aes(x=update,y=count.mean,color=genomeLength) +
    geom_line() +
    geom_abline(slope=mutrate.indel, intercept = 0) ## what's mutrate.indel? runs w/o this line


# FUNCTION SUMMARY --------------------

# Summary Function
# doesn't work :(
summary.reps <- function(colname) {
    df_summary <- toy_data %>%
        group_by(update,genomeLength) %>%
        summarize(count.mean = mean(toy_data[[colname]]),
                  count.sd = sd(toy_data[[colname]]))
    df_summary$n <- length(levels(toy_data$repNum))
    df_summary$sem <- df_summary$count.sd/sqrt(df_summary$n-1)
    df_summary$LoCI <- df_summary$count.mean + qt((1.0-0.95)/2,
                                                  df=df_summary$n-1)*df_summary$sem
    df_summary$HiCI <- df_summary$count.mean - qt((1.0-0.95)/2,
                                                  df=df_summary$n-1)*df_summary$sem
    df_summary
}
df_summary_func <- summary.reps("countPoint")

ggplot(data=df_summary_func) +
    aes(x=update,y=count.mean,color=genomeLength) +
    geom_line() +
    geom_abline(slope=mutrate.indel, intercept = 0) # runs without this line, again


