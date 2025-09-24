library(readr)

data <- read_csv("data/badminton_worldtour.csv")

View(data)

head(data)

summary(data)

colSums(is.na(data))

sum(duplicated(data))

### According to the steps above, we can find there are no missing values
## and no duplicated rows.

write_csv(data, "data/cleaned_data.csv")
