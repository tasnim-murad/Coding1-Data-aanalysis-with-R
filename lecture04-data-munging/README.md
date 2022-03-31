# Lecture 04: Data Munging with R
*Coding course to complete Data Analysis in R*

This lecture introduces students to how to manipulate raw data in various ways with `dplyr` from `tidyverse`.


## Learning outcomes
After successfully completing the code in *raw_codes* students should be able to:

[`data_munging.R`](https://github.com/gabors-data-analysis/da-coding-rstats/blob/main/lecture04-data-munging/raw_codes/data_munging.R)
  - Add variables
  - Separate a character variable into two (or more) variables
  - Convert different type of variables to specific types:
    - character to numeric
    - character to factor
  - Further string manipulations
  - Rename variables
  - Filter out different observations
    - select observations with specific values
    - tabulate different values of a variable
    - filter out missing values
    - replace specific values with others
    - handle duplicates in various ways
  - use pipes to do multiple manipulations at once
  - sort data ascending or descending according to a specific variable 

## Lecture Time

Ideal overall time: **40-60 mins**.

Showing [`data_munging.R`](https://github.com/gabors-data-analysis/da-coding-rstats/blob/main/lecture04-data-munging/raw_codes/data_munging.R)takes around *30 minutes* while doing the tasks would take the rest.
 

## Homework

*Type*: quick practice, approx 15 mins

WIP

## Further material

  - Hadley Wickham and Garrett Grolemund R for Data Science: [Chapter 5](https://r4ds.had.co.nz/transform.html) provides an overview of the type of variables, selecting, filtering, and arranging along with others. [Chapter 15](https://r4ds.had.co.nz/factors.html) provides further material on factors. [Chapter 18](https://r4ds.had.co.nz/pipes.html) discusses pipes in various applications.
  - Jae Yeon Kim: R Fundamentals for Public Policy, Course material, [Lecture 3](https://github.com/KDIS-DSPPM/r-fundamentals/blob/main/lecture_notes/03_1d_data.Rmd) is relevant for factors, but includes many more. [Lecture 6](https://github.com/KDIS-DSPPM/r-fundamentals/blob/main/lecture_notes/06_slicing_dicing.Rmd) introduces similar manipulations with tibble.
  - Grant McDermott: Data Science for Economists, Course material, [Lecture 5](https://github.com/uo-ec607/lectures/blob/master/05-tidyverse/05-tidyverse.pdf) is a nice overview on tidyverse with easy data manipulations.


## Folder structure
  
  - [raw_codes](https://github.com/gabors-data-analysis/da-coding-rstats/edit/main/lecture04-data-munging/raw_codes) includes one code, which is ready to use during the course but requires some live coding in class.
    - [`data_munging.R`](https://github.com/gabors-data-analysis/da-coding-rstats/blob/main/lecture04-data-munging/raw_codes/data_munging.R)
  - [complete_codes](https://github.com/gabors-data-analysis/da-coding-rstats/edit/main/lecture04-data-munging/complete_codes) includes one code with solutions for
    - [`data_munging.R`](https://github.com/gabors-data-analysis/da-coding-rstats/edit/main/lecture04-data-munging/complete_codes/data_munging_fin.R) solution for: [`data_munging.R`](https://github.com/gabors-data-analysis/da-coding-rstats/blob/main/lecture04-data-munging/raw_codes/data_munging.R)