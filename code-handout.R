
### Creating objects in R

















### Challenge
##
## What are the values after each statement in the following?
##
## mass <- 47.5            # mass?
## age  <- 122             # age?
## mass <- mass * 2.0      # mass?
## age  <- age - 20        # age?
## mass_index <- mass/age  # mass_index?















### Vectors and data types





















## ## We’ve seen that atomic vectors can be of type character, numeric, integer, and
## ## logical. But what happens if we try to mix these types in a single
## ## vector?
## 
## ## What will happen in each of these examples? (hint: use `class()` to
## ## check the data type of your object)
## num_char <- c(1, 2, 3, "a")
## 
## num_logical <- c(1, 2, 3, TRUE)
## 
## char_logical <- c("a", "b", "c", TRUE)
## 
## tricky <- c(1, 2, 3, "4")
## 
## ## Why do you think it happens?
## 
## ## You've probably noticed that objects of different types get
## ## converted into a single, shared type within a vector. In R, we call
## ## converting objects from one class into another class
## ## _coercion_. These conversions happen according to a hierarchy,
## ## whereby some types get preferentially coerced into other types. Can
## ## you draw a diagram that represents the hierarchy of how these data
## ## types are coerced?















### Challenge (optional)
##
## * Can you figure out why `"four" > "five"` returns `TRUE`?





heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

# 1.
heights_no_na <- heights[!is.na(heights)] 
# or
heights_no_na <- na.omit(heights)
# or
heights_no_na <- heights[complete.cases(heights)]

# 2.
median(heights, na.rm = TRUE)

# 3.
heights_above_67 <- heights_no_na[heights_no_na > 67]
length(heights_above_67)

## ### Challenge
## 1. Using this vector of heights in inches, create a new vector with the NAs removed.
##
##    heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
##
## 2. Use the function `median()` to calculate the median of the `heights` vector.
##
## 3. Use R to figure out how many people in the set are taller than 67 inches.
### Presentation of the survey data

## download.file(url="https://ndownloader.figshare.com/files/2292169",
##               destfile = "data_raw/portal_data_joined.csv")









str(surveys)

## * class: data frame
## * how many rows: 34786,  how many columns: 13
## * how many taxa: 4








## # get all the records that have species as "albigula"
## surveys[surveys$species == "albigula",]
## # save all the records that have species as "albigula" into a variable
## albigula_data <- surveys[surveys$species == "albigula",]
## # how many records have species as "albigula" in the surveys data frame?
## nrow(albigula_data)



### Factors

sex <- factor(c("male", "female", "female", "male"))







year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)               # Wrong! And there is no warning...
as.numeric(as.character(year_fct)) # Works...
as.numeric(levels(year_fct))[year_fct]    # The recommended way.

## bar plot of the number of females and males captured during the experiment:
plot(surveys$sex)





## Challenges
##
## * Rename "F" and "M" to "female" and "male" respectively.
## * Now that we have renamed the factor level to "undetermined", can you recreate the
##   barplot such that "undetermined" is last (after "male")

## ## Compare the difference between our data read as `factor` vs `character`.
## surveys <- read.csv("data_raw/portal_data_joined.csv", stringsAsFactors = TRUE)
## str(surveys)
## surveys <- read.csv("data_raw/portal_data_joined.csv", stringsAsFactors = FALSE)
## str(surveys)
## ## Convert the column "plot_type" into a factor
## surveys$plot_type <- factor(surveys$plot_type)



## ## Challenge:
## ##  There are a few mistakes in this hand-crafted `data.frame`,
## ##  can you spot and fix them? Don't hesitate to experiment!
## animal_data <- data.frame(
##       animal = c(dog, cat, sea cucumber, sea urchin),
##       feel = c("furry", "squishy", "spiny"),
##       weight = c(45, 8 1.1, 0.8)
##       )



## ## Challenge:
## ##   Can you predict the class for each of the columns in the following
## ##   example?
## ##   Check your guesses using `str(country_climate)`:
## ##   * Are they what you expected? Why? why not?
## ##   * What would have been different if we had added `stringsAsFactors = FALSE`
## ##     when we created this data frame?
## ##   * What would you need to change to ensure that each column had the
## ##     accurate data type?
## country_climate <- data.frame(country = c("Canada", "Panama", "South Africa", "Australia"),
##                                climate = c("cold", "hot", "temperate", "hot/temperate"),
##                                temperature = c(10, 30, 18, "15"),
##                                northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
##                                has_kangaroo = c(FALSE, FALSE, FALSE, 1))
# R Base
surveys[surveys$species == "albigula" &
        surveys$year == 1977, ]

# Tidyverse
filter(surveys, species == "albigula", year == 1977)



# Load the tidyverse package
library(tidyverse)

surveys <- read_csv("data_raw/portal_data_joined.csv")



# Print the first 15 rows
print(surveys, n = 15)

# Inspect the data
str(surveys)

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1)

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1, colour = "blue")

# Assign plot to a variable
surveys_plot <- ggplot(data = surveys, 
                       mapping = aes(x = weight, y = hindfoot_length))

# Draw a scatter plot
surveys_plot + 
    geom_point()

surveys_plot +
    geom_smooth()

surveys_plot +
  geom_point() +
  geom_smooth()





#save plot that you would like to save into a variable
out_plot <- surveys_plot + geom_density2d()
#save plot to file
ggsave(filename="img_output/plot_weight_hindfoot_density2d.png", plot = out_plot)

# Save plot to file
ggsave(filename = "img_output/plot_weight_hindfoot_density2d.png")

## # Extract species_id, weight, hindfoot_lenth, year and sex columns from surveys dataset.
## select(surveys, species_id, weight, hindfoot_length, year, sex)

## # Select all columns of the surveys dataset apart from record_id and species_id columns.
## select(surveys, -record_id, -species_id)

## # Keep only the observations of animals collected from 1995 onwards from the surveys dataset.
## filter(surveys, year >= 1995)

## # Keep only the observations of animals collected from 1995 onwards
## # that are female from the surveys dataset.
## filter(surveys, year >= 1995, sex == "F")

# Assign plot to a variable
surveys_plot <- ggplot(data = surveys, 
                       mapping = aes(x = weight, y = hindfoot_length))

# Draw a scatter plot
surveys_plot + 
    geom_point()

## # Which values of the weight column are missing?
## is.na(surveys$weight)
## 
## # Which values of the weight column are not missing?
## !is.na(surveys$weight)

## filter(surveys,
##   !is.na(weight), # remove rows that have weight as NA
##   !is.na(hindfoot_length))  # remove rows that have hindfoot_length as NA

drop_na(surveys, weight, hindfoot_length)

drop_na(surveys)

surveys_complete <- drop_na(surveys)

## surveys2 <- select(surveys_complete, species_id, weight, hindfoot_length, year, sex)
## surveys_recent <- filter(surveys2, year >= 1995)

## surveys_recent <- filter(
##                     select(surveys_complete,
##                            species_id, weight, hindfoot_length, year, sex)
##                     , year >= 1995)

## surveys_complete %>%
##   select(species_id, weight, hindfoot_length, year, sex) %>%
##   filter(year >= 1995)

## surveys_recent <- surveys_complete %>%
##                   select(species_id, weight, hindfoot_length, year, sex) %>%
##                   filter(year >= 1995)
## 
## surveys_recent

surveys_complete %>%
  # Select columns
  select(species_id, weight, hindfoot_length, year, sex) %>%
  # Filter rows
  filter(year >= 1995) %>%
  # Plot transformed data
  ggplot(mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point()

survey_recent <- surveys_complete %>%
                  select(species_id, weight, hindfoot_length, year, sex) %>%
                  filter(year >= 1995)
ggplot(mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(data = surveys_complete) +
  geom_point(data = survey_recent, colour = "red")





surveys_complete %>%
  # Add weight_kg column
  mutate(weight_kg = weight / 1000) %>%
  # Select columns
  select(species_id, weight_kg, hindfoot_length, year, sex) %>%
  # Filter rows
  filter(year >= 1995) %>%
  # Plot transformed data
  ggplot(mapping = aes(x = year, y = weight_kg)) +
    geom_boxplot()

surveys_complete %>%
  # Add weight_kg column
  mutate(weight_kg = weight / 1000) %>%
  # Select columns
  select(species_id, weight_kg, hindfoot_length, year, sex) %>%
  # Filter rows
  filter(year >= 1995) %>%
  # Convert the year column to a factor
  mutate(year = as_factor(year)) %>%
  # Plot transformed data
  ggplot(mapping = aes(x = year, y = weight_kg)) +
    geom_boxplot()

surveys_complete %>%
  # Add weight_kg column
  mutate(weight_kg = weight / 1000) %>%
  # Select columns
  select(species_id, weight_kg, hindfoot_length, year, sex) %>%
  # Filter rows
  filter(year >= 1995) %>%
  # Convert the year variable and plot transformed data
  ggplot(mapping = aes(x = as_factor(year), y = weight_kg)) +
    geom_boxplot()

# Sort weight in ascending order (default)
surveys_complete %>%
  arrange(weight)
library(rmarkdown)
paged_table(surveys_complete %>% arrange(weight))

# Sort weight in descending order 
surveys_complete %>%
  arrange(desc(weight))
library(rmarkdown)
paged_table(surveys_complete %>% arrange(desc(weight)))

# Sort weight in ascending order and hindfoot_length in descending order
surveys_complete %>%
  arrange(weight, desc(hindfoot_length))
library(rmarkdown)
paged_table(surveys_complete %>% arrange(weight, desc(hindfoot_length)))

surveys_complete %>%
  mean_weight = mean(weight)

surveys_complete %>%
  summarise(mean_weight = mean(weight))

  surveys_complete %>%
    count(sex)

surveys_complete %>%
  count(sex, species) 

surveys_complete %>%
    count(plot_type) 

surveys_complete %>%
  count(sex, species) %>%
  arrange(species, desc(n))

yearly_counts <- surveys_complete %>%
  count(year, genus)

yearly_counts







ggplot(surveys_complete, aes(weight)) +
  geom_histogram()

ggplot(surveys_complete, aes(weight, fill = sex)) +
  geom_histogram(bins = 100)

ggplot(surveys_complete, aes(weight, colour = sex)) +
  geom_freqpoly()

surveys_complete %>%
  # Extract females
  filter(sex == "F") %>%
  summarise(mean_weight = mean(weight))

surveys_complete %>%
  # Extract males
  filter(sex == "M") %>%
  summarise(mean_weight = mean(weight))

surveys_complete %>%
  group_by(sex) %>%
  summarise(mean_weight = mean(weight))

surveys_complete %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight))

surveys_complete %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight),
            min_weight = min(weight))

surveys_complete %>%
    group_by(species_id) %>%
    summarise(
        mean_hindfoot_length = mean(hindfoot_length),
        min_hindfoot_length = min(hindfoot_length),
        max_hindfoot_length = max(hindfoot_length),
        n_obs = n()
    )

surveys_complete %>%
    group_by(year) %>%
    filter(weight == max(weight)) %>%
    select(year, genus, species_id, weight) %>%
    arrange(year)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
    geom_line() +
    facet_wrap(facets = vars(genus))

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
    geom_line() +
    facet_wrap(facets = vars(genus), scales = "free")

yearly_sex_counts <- surveys_complete %>%
                      count(year, genus, sex)

yearly_sex_counts

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, colour = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
    geom_line() +
    # Display the genera as columns
    facet_grid(cols = vars(genus))

ggplot(data = yearly_sex_counts, 
  mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_grid(rows = vars(sex), cols = vars(genus))

ggplot(data = yearly_sex_counts, 
  mapping = aes(x = year, y = n, colour = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_grid(cols = vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of animals")

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, colour = sex)) +
    geom_line() +
    facet_grid(cols = vars(genus)) +
    labs(title = "Observed genera through time",
         x = "Year of observation",
         y = "Number of animals")  +
    theme(axis.text.x = element_text(size = 7, angle = 90, vjust = 0.5), 
          axis.text.y = element_text(size = 7), 
          strip.text=element_text(size = 7, angle = 45))

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, colour = sex)) +
    geom_line() +
    facet_grid(cols = vars(genus)) +
    labs(title = "Observed genera through time",
         x = "Year of observation",
         y = "Number of animals")  +
    theme(axis.text.x = element_text(size = 7, angle = 90, vjust = 0.5), 
          axis.text.y = element_text(size = 7), 
          strip.text = element_text(size = 7, angle = 45)) +
    scale_colour_brewer("Sex", 
                       palette = "Set1", 
                       breaks = c("F", "M"), 
                       labels = c("Female", "Male"))

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point() +
  theme_bw()

surveys_complete %>%
  group_by(year, species) %>%
  summarise(avg_weight = mean(weight)) %>%
  ggplot(mapping = aes(x = year, y = avg_weight)) +
    geom_line() +
    facet_wrap(facets = vars(species)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5))



















write_csv(surveys_complete, path = "data_output/surveys_complete.csv")
