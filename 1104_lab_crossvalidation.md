# Lab: Cross Validation in Action {#lab11}




## Don’t Judge the Ship After It Sinks {.unnumbered}

We’ve been hired by Lloyd’s of London to help quantify risk in maritime travel. After the Titanic disaster in 1912 and the [claims that followed]((https://www.lloyds.com/titanic)), Lloyd’s wants models that can predict survival outcomes using passenger information.


In this lab, you will build classification models for Titanic survival and learn why apparent accuracy can be misleading. You’ll then evaluate performance more honestly using data splitting and cross validation.

## Learning goals {.unnumbered}

- Fit and interpret logistic regression classifiers for binary outcomes in R.
- Compute predicted probabilities, convert them into class predictions, and calculate accuracy.
- Explain why apparent (in-sample) accuracy is optimistic.
- Evaluate models using held-out data and implement k-fold cross validation.







## Getting started and warming up {.unnumbered}

### Packages {.unnumbered}

We will use tidyverse for data manipulation and titanic for data. You will also load readxl to import the Titanic3 file (provided in your project).


``` r
library(tidyverse)
library(titanic)
library(readxl)
```

<!-- 
### Housekeeping

#### Git configuration / password caching

Configure your Git user name and email. If you cannot remember the instructions, refer to an earlier lab. Also remember that you can cache your password for a limited amount of time.

#### Project name

Update the name of your project to match the lab's title.

-->

## Warm up {.unnumbered}

Before we introduce the data, let's warm up with some simple exercises.

### YAML {.unnumbered}

Open the R Markdown (Rmd) file in your project, change the author name to your name, and knit the document.

### Commiting and pushing changes {.unnumbered}

- Go to the **Git** pane in your RStudio.
- View the **Diff** and confirm that you are happy with the changes.
- Add a commit message like "Update team name" in the **Commit message** box and hit **Commit**.
- Click on **Push**. This will prompt a dialogue box where you first need to enter your user name, and then your password.

## The data {.unnumbered}

We will work with:

- `titanic_train` and `titanic_test` from the `titanic` package (a convenient train/test split often used in Kaggle contexts).

- `titanic3` loaded from data/titanic3.xls, which includes additional fields. Originally from [here](https://www.kaggle.com/datasets/vinicius150987/titanic3)




``` r

titanic3 <- read_excel("data/titanic3.xls", 
    col_types = c("numeric", "numeric", "text", 
        "text", "numeric", "numeric", "numeric", 
        "text", "numeric", "text", "text", 
        "text", "text", "text")) 
  

data("titanic_train")
data("titanic_test")
```


Before modeling, we will do two small cleanups: standardize column names to lowercase for titanic_test and titantic_train as well as create an ordinal level variable for passenger class.


``` r
# Rename columns to lowercase
names(titanic3) <- names(titanic3) %>% tolower()
names(titanic_train) <- names(titanic_train) %>% tolower()
names(titanic_test) <- names(titanic_test) %>% tolower()

# Convert pclass to factor

titanic_train <- titanic_train %>%
  mutate(pclass_ord = factor(pclass, ordered = TRUE, levels = c(3, 2, 1)))

titanic_test <- titanic_test %>%
  mutate(pclass_ord = factor(pclass, ordered = TRUE, levels = c(3, 2, 1)))

titanic3 <- titanic3 %>%
  mutate(pclass_ord = factor(pclass, ordered = TRUE, levels = c(3, 2, 1)))
```



## Exercises {.unnumbered}

### Apparent accuracy {.unnumbered}

Before we talk about cross validation, we need to see the problem it is designed to fix.

Suppose we fit a model and then immediately ask: “How well does this model predict the data?”
If we use the same data to fit the model and to evaluate it, we are letting the model see the answers ahead of time.

Let’s do that on purpose.

1. Fit a logistic regression predicting survival from passenger sex and class as a numeric variable.

Save the model as `m_apparent`.


``` r
m_apparent <- glm(
  survived ~ sex + pclass_ord,
  data = titanic3,
  family = binomial
)



summary(m_apparent)

#  understand the variables with .L, .Q, and .C and ^4 are, respectively, the coefficients for the ordered factor coded with linear, quadratic, cubic, and quartic contrasts.

# not really helpful for the lab to make the class ordinal

```


``` r
m_apparent <- glm(
  survived ~ sex + pclass,
  data = titanic3,
  family = binomial
)



summary(m_apparent)
#> 
#> Call:
#> glm(formula = survived ~ sex + pclass, family = binomial, data = titanic3)
#> 
#> Coefficients:
#>             Estimate Std. Error z value Pr(>|z|)
#> (Intercept)    2.963      0.235    12.6   <2e-16
#> sexmale       -2.515      0.147   -17.1   <2e-16
#> pclass        -0.860      0.085   -10.1   <2e-16
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 1741.0  on 1308  degrees of freedom
#> Residual deviance: 1257.2  on 1306  degrees of freedom
#> AIC: 1263
#> 
#> Number of Fisher Scoring iterations: 4
```


This model has access to every passenger and the final outcome. It is not being asked to predict the future. It is being asked to summarize the past.

Now we can use the model to generate predicted survival probabilities for every passenger.



``` r
p_apparent <- predict(m_apparent, type = "response")

```

Each probability represents the expected survival chance for that passenger, according to the model. You can think about it like the chance of survival if you put that passenger on a large number of identical Titanic voyages. Out of 100 identical voyages, how many times would that passenger survive?

To turn probabilities into decisions (we're working for an insurance agency after all), we need a decision rule. To keep things simple, we will use a cutoff of 0.5: if the predicted probability is greater than 0.5, we predict survival (1); otherwise, we predict non-survival (0). 


``` r
yhat_apparent <- ifelse(p_apparent > 0.5, 1, 0)
```


Now, we can compute the model’s accuracy. Here we are defining accuracy as the proportion of correct predictions (both survivors and non-survivors) out of all passengers.


``` r

acc_apparent <- mean(yhat_apparent == titanic3$survived, na.rm = TRUE)

acc_apparent
#> [1] 0.78
```

At this point, the model looks fairly good. In fact, the number looks reassuring. But it answers the wrong question. The model is being evaluated on passengers it already “knows.” This is like asking, after the Titanic sank, whether you can explain who survived. Of course you can... Based on these data we correctly predict 78% of the passengers. 

Cross validation exists because this number tells us very little about how well the model would perform before the disaster. Real predictions are made before the ship hits the iceberg.


## Holding passengers back {.unnumbered}

To get a more honest answer, we need to pretend that some passengers are unknown.

We’ll do this by splitting the data into two groups:
   - a training set, used to fit the model
   - a test set, used only for evaluation
   
Conveniently, the `titanic` package already provides such a split.


``` r
titanic_test %>% glimpse()
#> Rows: 418
#> Columns: 12
#> $ passengerid <int> 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903…
#> $ pclass      <int> 3, 3, 2, 3, 3, 3, 3, 2, 3, 3, 3, 1, 1, 2, 1, 2, 2, 3, 3, 3…
#> $ name        <chr> "Kelly, Mr. James", "Wilkes, Mrs. James (Ellen Needs)", "M…
#> $ sex         <chr> "male", "female", "male", "male", "female", "male", "femal…
#> $ age         <dbl> 34, 47, 62, 27, 22, 14, 30, 26, 18, 21, NA, 46, 23, 63, 47…
#> $ sibsp       <int> 0, 1, 0, 0, 1, 0, 0, 1, 0, 2, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0…
#> $ parch       <int> 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
#> $ ticket      <chr> "330911", "363272", "240276", "315154", "3101298", "7538",…
#> $ fare        <dbl> 7.8, 7.0, 9.7, 8.7, 12.3, 9.2, 7.6, 29.0, 7.2, 24.1, 7.9, …
#> $ cabin       <chr> "", "", "", "", "", "", "", "", "", "", "", "", "B45", "",…
#> $ embarked    <chr> "Q", "S", "Q", "S", "S", "S", "Q", "S", "C", "S", "S", "S"…
#> $ pclass_ord  <ord> 3, 3, 2, 3, 3, 3, 3, 2, 3, 3, 3, 1, 1, 2, 1, 2, 2, 3, 3, 3…
```


Now we fit the same model as before, but only on the training data.


``` r
m_split <- glm(
  survived ~ sex + pclass,
  data = titanic_train,
  family = binomial
)

summary(m_split)
#> 
#> Call:
#> glm(formula = survived ~ sex + pclass, family = binomial, data = titanic_train)
#> 
#> Coefficients:
#>             Estimate Std. Error z value Pr(>|z|)
#> (Intercept)    3.295      0.297   11.08   <2e-16
#> sexmale       -2.643      0.184  -14.38   <2e-16
#> pclass        -0.961      0.106   -9.06   <2e-16
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 1186.7  on 890  degrees of freedom
#> Residual deviance:  827.2  on 888  degrees of freedom
#> AIC: 833.2
#> 
#> Number of Fisher Scoring iterations: 4


p_split <- predict(m_split, type = "response")


yhat_split <- ifelse(p_split > 0.5, 1, 0)

acc_split <- mean(yhat_split == titanic_train$survived)
acc_split
#> [1] 0.79
```



<details>
  <summary>Click for a solution</summary>

``` r
m_split <- glm(
  survived ~ sex + pclass,
  data = titanic_train,
  family = binomial
)

summary(m_split)
#> 
#> Call:
#> glm(formula = survived ~ sex + pclass, family = binomial, data = titanic_train)
#> 
#> Coefficients:
#>             Estimate Std. Error z value Pr(>|z|)
#> (Intercept)    3.295      0.297   11.08   <2e-16
#> sexmale       -2.643      0.184  -14.38   <2e-16
#> pclass        -0.961      0.106   -9.06   <2e-16
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 1186.7  on 890  degrees of freedom
#> Residual deviance:  827.2  on 888  degrees of freedom
#> AIC: 833.2
#> 
#> Number of Fisher Scoring iterations: 4
```
</details>

### 2.3 Training accuracy {.unnumbered}


``` r
p_train <- predict(___, type = ___)
yhat_train <- ifelse(___ > ___, ___, ___)

acc_train <- mean(___ == ___, na.rm = TRUE)
acc_train
```



<details>
  <summary>Click for a solution</summary>

``` r
p_train <- predict(m_split, type = "response")
yhat_train <- ifelse(p_train > 0.5, 1, 0)

acc_train <- mean(yhat_train == titanic_train$survived, na.rm = TRUE)
acc_train
#> [1] 0.79
```
</details>


### 2.4 Test accuracy {.unnumbered}

We evaluate this model on passengers it has never seen, using `titanic_test`.


``` r
p_test <- predict(___, newdata = ___, type = ___)
yhat_test <- ifelse(___ > ___, ___, ___)

acc_test <- mean(___ == ___, na.rm = TRUE)
acc_test
```



<details>
  <summary>Click for a solution</summary>

``` r
p_test <- predict(m_split, 
                  newdata = titanic_test, 
                  type = "response")
yhat_test <- ifelse(p_test > 0.5, 1, 0)

acc_test <- mean(yhat_test == titanic_test$survived, na.rm = TRUE)
acc_test
#> [1] NaN
```
</details>

### 2.5 Reflection {.unnumbered}

1. Which is larger, `acc_train` or `acc_test`? Why is that the typical pattern?
2. Which estimate is closer to what Lloyd’s actually needs?
3. If `acc_test` happened to be higher than `acc_train`, would that invalidate the logic of holdout testing? Explain.

## Exercise 3: Cross validation across timelines {.unnumbered}

A single split is a single alternate timeline. Maybe your held-out passengers were unusually predictable, maybe unusually hard.

Cross validation reduces dependence on one split by repeating the train/test game across multiple partitions.

### 3.1 Create folds {.unnumbered}

Create `titanic_cv` by:

- filtering to complete cases on `survived`, `sex`, and `pclass`,
- setting a seed,
- adding a `fold` variable with values 1 through 10.


``` r
set.seed(___)

titanic_cv <- titanic3 %>%
  filter(!is.na(___), !is.na(___), !is.na(___)) %>%
  mutate(fold = sample(rep(___, length.out = n())))
```



<details>
  <summary>Click for a hint</summary>
Use `rep(1:10, length.out = n())` so folds are roughly equal-sized.
</details>

<details>
  <summary>Click for a solution</summary>

``` r
set.seed(11)

titanic_cv <- titanic3 %>%
  filter(!is.na(survived), !is.na(sex), !is.na(pclass)) %>%
  mutate(fold = sample(rep(1:10, length.out = n())))
```
</details>

### 3.2 Fit and evaluate 10 models {.unnumbered}

Complete the loop so each fold is used as test exactly once, and store fold accuracies in `cv_results`.


``` r
cv_results <- data.frame(fold = sort(unique(titanic_cv$fold)), accuracy = NA_real_)
for (j in cv_results$fold) {

  train_j <- titanic_cv %>% filter(fold != ___)
  test_j  <- titanic_cv %>% filter(fold == ___)

  m_j <- glm(
    formula = ___,
    data = ___,
    family = ___
  )

  p_j <- predict(m_j, newdata = ___, type = ___)
  yhat_j <- ifelse(___ > ___, ___, ___)

  cv_results$accuracy[cv_results$fold == j] <- mean(___ == ___, na.rm = TRUE)
}
```

### 3.3 Summarize cross validation {.unnumbered}

Compute mean, SD, min, and max of fold accuracy.


``` r
cv_mean <- mean(___)
cv_sd   <- sd(___)
cv_min  <- min(___)
cv_max  <- max(___)

c(cv_mean = cv_mean, cv_sd = cv_sd, cv_min = cv_min, cv_max = cv_max)
```



<details>
  <summary>Click for a solution</summary>

``` r

cv_results <- data.frame(fold = sort(unique(titanic_cv$fold)), accuracy = NA_real_)

cv_mean <- mean(cv_results$accuracy)
cv_sd   <- sd(cv_results$accuracy)
cv_min  <- min(cv_results$accuracy)
cv_max  <- max(cv_results$accuracy)

c(cv_mean = cv_mean, cv_sd = cv_sd, cv_min = cv_min, cv_max = cv_max)
#> cv_mean   cv_sd  cv_min  cv_max 
#>      NA      NA      NA      NA
```
</details>

### 3.4 Reflection {.unnumbered}


1. Why is `cv_mean` usually lower than `acc_apparent`?
2. What does `cv_sd` tell you that `cv_mean` does not?
3. If Lloyd’s demanded a single performance estimate, would you report `acc_test` (Exercise 2) or `cv_mean` (Exercise 3)? Defend your choice.


## Exercise 4: When the cutoff is a policy decision {.unnumbered}

A probability cutoff is not a law of nature. It is a decision.

Lloyd’s might treat “predict survival” as a proxy for “low risk,” but different cutoffs change what counts as low risk. In this exercise you will examine how accuracy changes as the cutoff changes.

### 4.1 Evaluate multiple cutoffs on the test set {.unnumbered}

Using p_test from an earlier step, compute test accuracy for the following cutoffs: 0.3, 0.5, 0.7.

Create a data frame called cutoff_results with columns cutoff and accuracy.


``` r
cutoffs <- c(0.3, 0.5, 0.7)

cutoff_results <- data.frame(
  cutoff = cutoffs,
  accuracy = NA_real_
)

for (i in seq_along(cutoffs)) {

  c0 <- cutoffs[i]

  yhat_c <- ifelse(___ > ___, ___, ___)
  cutoff_results$accuracy[i] <- mean(___ == ___, na.rm = TRUE)

}

cutoff_results
```



<details>
  <summary>Click for a solution</summary>

``` r
cutoffs <- c(0.3, 0.5, 0.7)

cutoff_results <- data.frame(
  cutoff = cutoffs,
  accuracy = NA_real_
)

for (i in seq_along(cutoffs)) {

  c0 <- cutoffs[i]

  yhat_c <- ifelse(p_test > c0, 1, 0)
  cutoff_results$accuracy[i] <- mean(yhat_c == titanic_test$survived, na.rm = TRUE)

}

cutoff_results
#>   cutoff accuracy
#> 1    0.3      NaN
#> 2    0.5      NaN
#> 3    0.7      NaN
```
</details>

### 4.2 Reflection {.unnumbered}

1. Which cutoff maximized accuracy here?
2. Why might accuracy be a poor criterion for selecting a cutoff in underwriting?
3. Name one alternative metric you would want if false positives and false negatives had different costs.


## Stretch tasks (optional) {.unnumbered}

These are optional, but they bring the lab closer to how real modeling work looks.

### 5.1 Add one more predictor and re-run CV {.unnumbered}

Pick one additional predictor from `titanic3` that you think should matter (for example, `age` or `fare`).

- Fit `survived ~ sex + pclass + <your variable>`.
- Run 10-fold CV again.
- Compare `cv_mean` and `cv_sd` to the baseline model.

**Important:** decide how you will handle missing values for your added predictor (listwise deletion is allowed here; we will treat missingness more carefully in the follow-up lab).

### 5.2 Competing models {.unnumbered}

Fit and compare at least two models using CV:

- Model A: `sex + pclass`
- Model B: `sex + pclass + <two more predictors>`

Report which model has higher `cv_mean`. If the difference is small, argue which one you would recommend to Lloyd’s, considering simplicity vs performance.

### 5.3 Stability thought experiment {.unnumbered}

Repeat 10-fold CV but change the seed (try three different seeds). Does `cv_mean` change much? Does `cv_sd` change much?

Write 3 to 5 sentences interpreting what you see.

## Super Stretch goals {.unnumbered}

### Lloyd’s Actually Has to Use This Model {.unnumbered}

In the previous lab, we evaluated a simple Titanic model using holdout testing and k-fold cross validation. That lab began with a deliberately constrained model (`sex` and `pclass`) so you could focus on **evaluation** without getting lost in feature engineering.

Now we do the part Lloyd’s actually cares about: building a model that uses more information, and doing so in a way that does not quietly sabotage evaluation.

This lab is about the uncomfortable truth that modeling choices are evaluation choices:

- If you add predictors with missing data, you change the population your model is trained and tested on.
- If you impute missing values using the full dataset, you leak information across folds.
- If you select a cutoff to maximize accuracy, you are making a policy decision without naming it.

You will build richer models, compare them using cross validation, and then stress-test the evaluation pipeline itself.

## Learning goals {.unnumbered}

- Compare multiple candidate models using k-fold cross validation.
- Handle missing data with listwise deletion and simple imputation.
- Avoid information leakage by imputing *within folds*.
- Evaluate classifiers beyond accuracy (confusion matrices, sensitivity/specificity).
- Reason about performance vs stability when recommending a model.


## Exercises {.unnumbered}

## Exercise 6: Candidate models {.unnumbered}

Lloyd’s will not price risk using only sex and class. Your job is to propose reasonable candidate models and compare them using the same evaluation method.

### 6.1 Choose candidate predictors {.unnumbered}

Pick **two** additional predictors from the data set. (This can include a constructed variable that you create from existing variables.)


``` r
names(titanic3)
#>  [1] "pclass"     "survived"   "name"       "sex"        "age"       
#>  [6] "sibsp"      "parch"      "ticket"     "fare"       "cabin"     
#> [11] "embarked"   "boat"       "body"       "home.dest"  "pclass_ord"
```


Why do you think each predictor you selected should matter for survival?

<

``` r
titanic3 %>% mutate(title = str_extract(name, "(?<=, )[^.]+")) %>% count(title) %>% arrange(desc(n))
#> # A tibble: 18 × 2
#>    title            n
#>    <chr>        <int>
#>  1 Mr             757
#>  2 Miss           260
#>  3 Mrs            197
#>  4 Master          61
#>  5 Dr               8
#>  6 Rev              8
#>  7 Col              4
#>  8 Major            2
#>  9 Mlle             2
#> 10 Ms               2
#> 11 Capt             1
#> 12 Don              1
#> 13 Dona             1
#> 14 Jonkheer         1
#> 15 Lady             1
#> 16 Mme              1
#> 17 Sir              1
#> 18 the Countess     1
```

### 6.2 Define candidate formulas {.unnumbered}

Create two model formulas:

- Baseline: `survived ~ sex + pclass`
- Expanded: `survived ~ sex + pclass + <two predictors you chose>`

Store them as `f_base` and `f_expanded`.


``` r
f_base <- survived ~ ___ + ___
f_expanded <- survived ~ ___ + ___ + ___ + ___
```



<details>
  <summary>Click for a solution example</summary>

</details>



## Exercise 7: Cross validation comparison (listwise deletion) {.unnumbered}

We will start with the simplest missing-data strategy: **drop rows with missing values** in any variable used by the model.

This is not always the best approach, but it is transparent.

### 2.1 Create a CV dataset for both models {.unnumbered}

Create `cv_df` that keeps only rows with non-missing values for all variables needed in `f_expanded`.


``` r
cv_df <- titanic3 %>%
  filter(!is.na(survived)) %>%
  filter(!is.na(___)) %>%
  filter(!is.na(___)) %>%
  filter(!is.na(___)) %>%
  filter(!is.na(___))
```



<details>
  <summary>Click for a solution example</summary>

``` r
cv_df <- titanic3 %>%
  filter(!is.na(survived)) %>%
  filter(!is.na(sex)) %>%
  filter(!is.na(pclass)) %>%
  filter(!is.na(age)) %>%
  filter(!is.na(fare))
```
</details>

### 7.2 Create folds {.unnumbered}

Assign each row to one of 10 folds.


``` r
set.seed(___)

cv_df <- cv_df %>%
  mutate(fold = sample(rep(___, length.out = n())))
```



<details>
  <summary>Click for a solution</summary>

``` r
set.seed(21)

cv_df <- cv_df %>%
  mutate(fold = sample(rep(1:10, length.out = n())))
```
</details>

### 2.3 Write a function to compute CV accuracy {.unnumbered}

Complete the function below so it returns a data frame with fold accuracies for a given formula.


``` r
cv_glm_accuracy <- function(df, formula, cutoff = 0.5) {

  out <- data.frame(fold = sort(unique(df$fold)), accuracy = NA_real_)

  for (j in out$fold) {

    train_j <- df %>% filter(fold != ___)
    test_j  <- df %>% filter(fold == ___)

    m_j <- glm(
      formula = ___,
      data = ___,
      family = ___
    )

    p_j <- predict(m_j, newdata = ___, type = ___)
    yhat_j <- ifelse(___ > ___, ___, ___)

    out$accuracy[out$fold == j] <- mean(___ == ___, na.rm = TRUE)
  }

  out
}
#> Error in parse(text = input): <text>:7:39: unexpected input
#> 6: 
#> 7:     train_j <- df %>% filter(fold != __
#>                                          ^
```



<details>
  <summary>Click for a solution</summary>

``` r
cv_glm_accuracy <- function(df, formula, cutoff = 0.5) {

  out <- data.frame(fold = sort(unique(df$fold)), accuracy = NA_real_)

  for (j in out$fold) {

    train_j <- df %>% filter(fold != j)
    test_j  <- df %>% filter(fold == j)

    m_j <- glm(
      formula = formula,
      data = train_j,
      family = binomial
    )

    p_j <- predict(m_j, newdata = test_j, type = "response")
    yhat_j <- ifelse(p_j > cutoff, 1, 0)

    out$accuracy[out$fold == j] <- mean(yhat_j == test_j$survived, na.rm = TRUE)
  }

  out
}
```
</details>

### 7.4 Compare models {.unnumbered}

Use `cv_glm_accuracy()` to compute CV results for both formulas. Compute mean and SD of accuracy for each.


``` r
cv_base <- cv_glm_accuracy(cv_df, formula = ___)
cv_exp  <- cv_glm_accuracy(cv_df, formula = ___)

summary_table <- data.frame(
  model = c("base", "expanded"),
  mean_acc = c(mean(___), mean(___)),
  sd_acc   = c(sd(___), sd(___))
)

summary_table
#> Error in parse(text = input): <text>:1:46: unexpected input
#> 1: cv_base <- cv_glm_accuracy(cv_df, formula = __
#>                                                  ^
```



<details>
  <summary>Click for a solution</summary>

``` r
cv_base <- cv_glm_accuracy(cv_df, formula = f_base)
cv_exp  <- cv_glm_accuracy(cv_df, formula = f_expanded)

summary_table <- data.frame(
  model = c("base", "expanded"),
  mean_acc = c(mean(cv_base$accuracy), mean(cv_exp$accuracy)),
  sd_acc   = c(sd(cv_base$accuracy), sd(cv_exp$accuracy))
)

summary_table
#>      model mean_acc sd_acc
#> 1     base     0.78  0.039
#> 2 expanded     0.78  0.036
```
</details>

### 7.5 Reflection {.unnumbered}

1. Which model has higher mean CV accuracy?
2. Which model has higher variability across folds?
3. If the accuracy improvement is small but the expanded model is more variable, how would you advise Lloyd’s?


## Exercise 8: Missingness is a modeling decision {.unnumbered}

Listwise deletion changes your population: you are now modeling a subset of passengers with complete records on your chosen predictors.

### 8.1 Quantify the missingness impact {.unnumbered}

Compute the number of rows in:

- the original `titanic3` with non-missing `survived`
- `cv_df`

Report the proportion retained.


``` r
n_all <- sum(!is.na(titanic3$survived))
n_kept <- nrow(cv_df)
prop_kept <- n_kept / n_all

c(n_all = n_all, n_kept = n_kept, prop_kept = prop_kept)
#>     n_all    n_kept prop_kept 
#>    1309.0    1045.0       0.8
```

### 8.2 Reflection {.unnumbered}

- What kinds of passengers might be disproportionately removed by listwise deletion when you include `age`?
- Why does this matter for Lloyd’s, even if accuracy improves?


## Exercise 9: Simple imputation without leakage {.unnumbered}

Now you will use a very simple imputation strategy for a numeric predictor:

- Replace missing values with the **training-fold mean** (not the overall mean).

This is the smallest step toward preventing leakage: the test fold should not influence how you fill in missing values.

### 9.1 Implement within-fold mean imputation for one variable {.unnumbered}

Choose one numeric predictor you used (for example, `age`). Complete the loop to:

- compute the mean of that variable in `train_j` (excluding NAs),
- fill missing values in both `train_j` and `test_j` using **that training mean**,
- fit the expanded model and compute fold accuracy.

Store results in `cv_imp`.


``` r
cv_imp <- data.frame(fold = sort(unique(cv_df$fold)), accuracy = NA_real_)

for (j in cv_imp$fold) {

  train_j <- cv_df %>% filter(fold != ___)
  test_j  <- cv_df %>% filter(fold == ___)

  mu <- mean(train_j$___, na.rm = TRUE)

  train_j$___[is.na(train_j$___)] <- ___
  test_j$___[is.na(test_j$___)] <- ___

  m_j <- glm(
    formula = ___,
    data = ___,
    family = ___
  )

  p_j <- predict(m_j, newdata = ___, type = ___)
  yhat_j <- ifelse(___ > ___, ___, ___)

  cv_imp$accuracy[cv_imp$fold == j] <- mean(___ == ___, na.rm = TRUE)
}

c(mean = mean(cv_imp$accuracy), sd = sd(cv_imp$accuracy))
#> Error in parse(text = input): <text>:5:40: unexpected input
#> 4: 
#> 5:   train_j <- cv_df %>% filter(fold != __
#>                                           ^
```



<details>
  <summary>Click for a solution example</summary>

``` r
cv_imp <- data.frame(fold = sort(unique(cv_df$fold)), accuracy = NA_real_)

for (j in cv_imp$fold) {

  train_j <- cv_df %>% filter(fold != j)
  test_j  <- cv_df %>% filter(fold == j)

  mu <- mean(train_j$age, na.rm = TRUE)

  train_j$age[is.na(train_j$age)] <- mu
  test_j$age[is.na(test_j$age)] <- mu

  m_j <- glm(
    formula = f_expanded,
    data = train_j,
    family = binomial
  )

  p_j <- predict(m_j, newdata = test_j, type = "response")
  yhat_j <- ifelse(p_j > 0.5, 1, 0)

  cv_imp$accuracy[cv_imp$fold == j] <- mean(yhat_j == test_j$survived, na.rm = TRUE)
}

c(mean = mean(cv_imp$accuracy), sd = sd(cv_imp$accuracy))
#>  mean    sd 
#> 0.777 0.036
```
</details>

### 9.2 Reflection {.unnumbered}

1. Why is imputing using the overall mean (computed on the full dataset) a form of leakage?
2. Did within-fold imputation change mean CV accuracy compared to listwise deletion? Why might it?



## Exercise 10: Beyond accuracy (confusion matrix) {.unnumbered}

Accuracy treats all mistakes as equally bad. Lloyd’s rarely agrees.

### 10.1 Compute confusion matrix elements on one fold {.unnumbered}

Pick a single fold (for example, fold 1). Using your chosen model and cutoff 0.5:

- compute TP, FP, TN, FN
- compute sensitivity and specificity


``` r
# Choose a fold
j <- 1

train_j <- cv_df %>% filter(fold != j)
test_j  <- cv_df %>% filter(fold == j)

m_j <- glm(formula = f_expanded, data = train_j, family = binomial)
p_j <- predict(m_j, newdata = test_j, type = "response")
yhat_j <- ifelse(p_j > 0.5, 1, 0)
y_j <- test_j$survived

TP <- sum(yhat_j == 1 & y_j == 1, na.rm = TRUE)
FP <- sum(yhat_j == 1 & y_j == 0, na.rm = TRUE)
TN <- sum(yhat_j == 0 & y_j == 0, na.rm = TRUE)
FN <- sum(yhat_j == 0 & y_j == 1, na.rm = TRUE)

sensitivity <- TP / (TP + FN)
specificity <- TN / (TN + FP)

c(TP = TP, FP = FP, TN = TN, FN = FN, sensitivity = sensitivity, specificity = specificity)
#>          TP          FP          TN          FN sensitivity specificity 
#>       24.00       13.00       53.00       15.00        0.62        0.80
```

### 10.2 Reflection {.unnumbered}


- Which error type (FP or FN) would you expect to be more costly for Lloyd’s in a real risk context?
- How would that change how you choose a cutoff?





<!--DS4P Links-->
[course_web]: https://datascience4psych.github.io/DataScience4Psych
[course_git]: https://github.com/DataScience4Psych/DataScience4Psych
[course_repo]: https://github.com/DataScience4Psych
[course_slides]: https://github.com/DataScience4Psych/slides
[course_syllabus]: https://smasongarrison.github.io/syllabi/ 
<!-- https://smasongarrison.github.io/syllabi/data-science.html -->
[syllabi]: https://smasongarrison.github.io/syllabi
[pl_00]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYaEAnJX20Ryy4OSie375rVY
[pl_01]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYao_7t5ycK4KDXNKaY-ECup
[pl_02]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZmr_T3PnuxjVIlj0C0kUNI
[pl_03]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYaHmjzdRvfg0yhOIYQnfjwE
[pl_04]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYYWFcel6_vp8__RUKLxhX4y
[pl_05]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYYMIguiV1F8RagMYibTY4iW
[pl_06]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYYV_KDod3Mk9-RmtFXii9Dv
[pl_07]: https://www.youtube.com/watch?list=PLKrrdtYgOUYZxvEvQ8-PcWrOY_dwY_ETI
[pl_08]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZgOzYB_dmauw55M7jXvsdo
[pl_09]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbaiTmldRY2ddsLrHp3z6yO
[pl_10]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbPw5iYzYEzoOKa7mJKNIhq
[pl_11]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZ-u6LzBbanrNFoeLHKaLL6
[pl_12]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbwRS-9Htmb80_t1NG-021e
[pl_13]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6
[pl_14]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYbWGmSnbLIYwdLOnGm6une6
[pl_15]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYa5MoYrV8EsWQ5jIr5ZYMpM
[pl_all]: https://www.youtube.com/playlist?list=PLKrrdtYgOUYZomNqf-1dtCDW94ySdLv-9


<!--AE Links-->
[ae01a_unvotes]: https://github.com/DataScience4Psych/ae01a_unvotes
[ae01b_covid]: https://github.com/DataScience4Psych/ae01b_covid
[ae02_bechdel]: https://github.com/DataScience4Psych/ae-02-bechdel-rmarkdown
[ae03_starwars]: https://github.com/DataScience4Psych/ae-03-starwars-dataviz
[ae08_imdb]: https://github.com/DataScience4Psych/ae-08-imdb-webscraping

<!-- Lab Links-->

[lab01_hello]: https://github.com/DataScience4Psych/lab-01-hello-r
[lab02]: https://github.com/DataScience4Psych/lab-02-plastic-waste
[lab03]: https://github.com/DataScience4Psych/lab-03-nobel-laureates
[lab04]: https://github.com/DataScience4Psych/lab-04-viz-sp-data
[lab05]: https://github.com/DataScience4Psych/lab-05-wrangle-sp-data
[lab06]: https://github.com/DataScience4Psych/lab_06_sad_plots
[lab07]: https://github.com/DataScience4Psych/lab_07_betterviz
[lab08]: https://github.com/DataScience4Psych/lab-08-uoe-art
[lab09]: https://github.com/DataScience4Psych/lab-09-ethics-algorithmic-bias
[lab10]: https://github.com/DataScience4Psych/lab-10-slr-course-evals
[lab11]: https://github.com/DataScience4Psych/lab-11-mlr-course-evals
[lab12]: https://github.com/DataScience4Psych/lab-12-inference-smoking
[lab13]: https://github.com/DataScience4Psych/lab-13-simulating-mars

<!--Slides-->
[d01_welcome]: https://datascience4psych.github.io/slides/d01_welcome/d01_welcome.html
[d02_toolkit]: https://datascience4psych.github.io/slides/d02_toolkit/d02_toolkit.html
[d03_dataviz]: https://datascience4psych.github.io/slides/d03_dataviz/d03_dataviz.html
[d04_ggplot2]: https://datascience4psych.github.io/slides/d04_ggplot2/d04_ggplot2.html
[d05_viznum]: https://datascience4psych.github.io/slides/d05_viznum/d05_viznum.html
[d06_vizcat]: https://datascience4psych.github.io/slides/d06_vizcat/d06_vizcat.html
[d07_tidy]: https://datascience4psych.github.io/slides/d07_tidy/d07_tidy.html
[d08_grammar]: https://datascience4psych.github.io/slides/d08_grammar/d08_grammar.html
[d09_wrangle]: https://datascience4psych.github.io/slides/d09_wrangle/d09_wrangle.html
[d10_dfs]: https://datascience4psych.github.io/slides/d10_dfs/d10_dfs.html
[d11_types]: https://datascience4psych.github.io/slides/d11_types/d11_types.html
[d12_import]: https://datascience4psych.github.io/slides/d12_import/d12_import.html
[d13_goodviz]: https://datascience4psych.github.io/slides/d13_goodviz/d13_goodviz.html
[d13b_moreggplot]: https://datascience4psych.github.io/slides/d13_goodviz/d13b_moreggplot.html
[d14_confound]: https://datascience4psych.github.io/slides/d14_confound/d14_confound.html
[d15_goodtalk]: https://datascience4psych.github.io/slides/d15_goodtalk/d15_goodtalk.html
[d16_webscraping]: https://datascience4psych.github.io/slides/d16_webscraping/d16_webscraping.html
[d17_functions]: https://datascience4psych.github.io/slides/d17_functions/d17_functions.html
[d18_ethics]: https://datascience4psych.github.io/slides/d18_ethics/d18_ethics.html
[d19_bias]: https://datascience4psych.github.io/slides/d19_bias/d19_bias.html
[d20_language]: https://datascience4psych.github.io/slides/d20_language/d20_language.html
[d21_fitting]: https://datascience4psych.github.io/slides/d21_fitting/d21_fitting.html
[d22_nonlinear]: https://datascience4psych.github.io/slides/d22_nonlinear/d22_nonlinear.html
[d23_multiple]: https://datascience4psych.github.io/slides/d23_multiple/d23_multiple.html
[d24_overfitting]: https://datascience4psych.github.io/slides/d24_overfitting/d24_overfitting.html
[d25_crossvalidation]: https://datascience4psych.github.io/slides/d25_crossvalidation/d25_crossvalidation.html
[d26_quantify]: https://datascience4psych.github.io/slides/d26_quantify/d26_quantify.html
[d27_bootstrap]: https://datascience4psych.github.io/slides/d27_bootstrap/d27_bootstrap.html
[d28_interactive]: https://datascience4psych.github.io/slides/d28_interactive/d28_interactive.html
[d29_machine]: https://datascience4psych.github.io/slides/d29_machinelearning/d29_machine.html
[d30_simulations]: https://datascience4psych.github.io/slides/d30_simulations/d30_simulations.html
[d31_llmintro]: https://datascience4psych.github.io/slides/d31_llmintro/d31_llmintro.html
[d32_llmapplications]: https://datascience4psych.github.io/slides/d32_llmapplications/d32_llmapplications.html

<!--externals-->

[stat545]: https://stat545.com
[r4ds]: https://r4ds.had.co.nz
[cran]: https://cloud.r-project.org
