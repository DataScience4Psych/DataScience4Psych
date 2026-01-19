# Working with OpenAI's API

This module introduces the basics of interacting with OpenAI's API from R. We'll explore how to make API calls, handle responses, and integrate AI capabilities into data science workflows.




## Getting Started

First, we need to load the required packages:



### API Authentication

To use OpenAI's API, you'll need an API key. Like we learned with other APIs, it's important to keep this secure:

```
# Store API key securely (NEVER commit to Git!)
openai_api_key <- readLines("path/to/api_key.txt")
```



### Making API Requests

The core workflow involves:

- Constructing the API request
- Sending it to OpenAI's endpoint
- Processing the response

Next, we define a function to generate text using OpenAI's API. The function takes a prompt as input and returns the generated text.

Here's a basic function for text generation:



``` r
generate_text <- function(prompt) {
  response <- POST(
    # curl https://api.openai.com/v1/chat/completions
    url = "https://api.openai.com/v1/chat/completions",
    # -H "Authorization: Bearer $OPENAI_API_KEY"
    add_headers(Authorization = paste("Bearer", openai_api_key)),
    # -H "Content-Type: application/json"
    content_type_json(),
    # -d '{
    #   "model": "gpt-3.5-turbo",
    #   "messages": [{"role": "user", "content": "What is a banana?"}]
    # }'
    encode = "json",
    body = list(
      model = "gpt-3.5-turbo",
      messages = list(list(role = "user", content = prompt))
    )
  )

  str_content <- content(response, "text", encoding = "UTF-8")
  parsed <- fromJSON(str_content)

  # return(parsed$choices[[1]]$text)
  return(parsed)
}
```


## Example Usage and Handling the Response

Now that we’ve defined our generate_text() function, let’s test it by sending a request to OpenAI’s API and working with the response.

### Step 1: Send a Request


``` r
prompt <- "Summarize the key steps in a data science workflow:"
generated_text <- generate_text(prompt)
```

### Step 2: Examine the Raw API Response


When we call the `generate_text(prompt)` function, OpenAI's API returns a structured response in JSON format, which R reads as a list. This response contains multiple components, but the most important part is the generated text.

Let's print the raw response to see its structure. 

``` r
print(generated_text)
#> $id
#> [1] "chatcmpl-CzmaIwOgLEKyxtgMPJ6b9yiv59RFV"
#> 
#> $object
#> [1] "chat.completion"
#> 
#> $created
#> [1] 1768840802
#> 
#> $model
#> [1] "gpt-3.5-turbo-0125"
#> 
#> $choices
#>   index message.role
#> 1     0    assistant
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    message.content
#> 1 1. Define the problem and objectives: Clearly outline the question or problem you are trying to solve, and determine the goals and objectives of the data analysis.\n\n2. Data collection: Gather relevant data from various sources, including databases, APIs, and external datasets.\n\n3. Data cleaning and preprocessing: Prepare the data for analysis by handling missing values, removing duplicates, and transforming the data into a usable format.\n\n4. Exploratory data analysis: Explore the data to identify patterns, trends, and relationships that can provide insights for the problem at hand.\n\n5. Feature engineering: Create new variables or transform existing ones to improve the performance of the model.\n\n6. Model selection and building: Choose an appropriate machine learning algorithm based on the problem and data, and train the model using the prepared data.\n\n7. Model evaluation: Evaluate the performance of the model using relevant metrics and techniques, such as cross-validation or train-test split.\n\n8. Model optimization: Fine-tune the model parameters or employ techniques like hyperparameter tuning to improve the model's accuracy and performance.\n\n9. Interpretation and communication of results: Interpret the model's predictions and communicate findings to stakeholders using visualizations and reports.\n\n10. Deployment and monitoring: Implement the model into production and continuously monitor its performance to ensure it remains effective and accurate.
#>   message.refusal message.annotations logprobs finish_reason
#> 1              NA                NULL       NA          stop
#> 
#> $usage
#> $usage$prompt_tokens
#> [1] 19
#> 
#> $usage$completion_tokens
#> [1] 261
#> 
#> $usage$total_tokens
#> [1] 280
#> 
#> $usage$prompt_tokens_details
#> $usage$prompt_tokens_details$cached_tokens
#> [1] 0
#> 
#> $usage$prompt_tokens_details$audio_tokens
#> [1] 0
#> 
#> 
#> $usage$completion_tokens_details
#> $usage$completion_tokens_details$reasoning_tokens
#> [1] 0
#> 
#> $usage$completion_tokens_details$audio_tokens
#> [1] 0
#> 
#> $usage$completion_tokens_details$accepted_prediction_tokens
#> [1] 0
#> 
#> $usage$completion_tokens_details$rejected_prediction_tokens
#> [1] 0
#> 
#> 
#> 
#> $service_tier
#> [1] "default"
#> 
#> $system_fingerprint
#> NULL
```

As you can see, the response is a nested list containing various metadata (e.g., request ID, model name, creation time), the AI-generated response (inside `$choices[[1]]$message$content`), token usage information (inside $usage$total_tokens), and more.

### Step 3: Extract the AI-Generated Text

Since the response contains both metadata and content, we need to extract only the generated text. The key part of the response is stored in:


``` r
ai_response <- generated_text$choices$message$content
```

Now, let's print the AI-generated text:


``` r
print(ai_response)
#> [1] "1. Define the problem and objectives: Clearly outline the question or problem you are trying to solve, and determine the goals and objectives of the data analysis.\n\n2. Data collection: Gather relevant data from various sources, including databases, APIs, and external datasets.\n\n3. Data cleaning and preprocessing: Prepare the data for analysis by handling missing values, removing duplicates, and transforming the data into a usable format.\n\n4. Exploratory data analysis: Explore the data to identify patterns, trends, and relationships that can provide insights for the problem at hand.\n\n5. Feature engineering: Create new variables or transform existing ones to improve the performance of the model.\n\n6. Model selection and building: Choose an appropriate machine learning algorithm based on the problem and data, and train the model using the prepared data.\n\n7. Model evaluation: Evaluate the performance of the model using relevant metrics and techniques, such as cross-validation or train-test split.\n\n8. Model optimization: Fine-tune the model parameters or employ techniques like hyperparameter tuning to improve the model's accuracy and performance.\n\n9. Interpretation and communication of results: Interpret the model's predictions and communicate findings to stakeholders using visualizations and reports.\n\n10. Deployment and monitoring: Implement the model into production and continuously monitor its performance to ensure it remains effective and accurate."
```

Ok, so that wasn't really readable. Let's try to format it a bit better:



``` r
cat(ai_response)
```

1. Define the problem and objectives: Clearly outline the question or problem you are trying to solve, and determine the goals and objectives of the data analysis.

2. Data collection: Gather relevant data from various sources, including databases, APIs, and external datasets.

3. Data cleaning and preprocessing: Prepare the data for analysis by handling missing values, removing duplicates, and transforming the data into a usable format.

4. Exploratory data analysis: Explore the data to identify patterns, trends, and relationships that can provide insights for the problem at hand.

5. Feature engineering: Create new variables or transform existing ones to improve the performance of the model.

6. Model selection and building: Choose an appropriate machine learning algorithm based on the problem and data, and train the model using the prepared data.

7. Model evaluation: Evaluate the performance of the model using relevant metrics and techniques, such as cross-validation or train-test split.

8. Model optimization: Fine-tune the model parameters or employ techniques like hyperparameter tuning to improve the model's accuracy and performance.

9. Interpretation and communication of results: Interpret the model's predictions and communicate findings to stakeholders using visualizations and reports.

10. Deployment and monitoring: Implement the model into production and continuously monitor its performance to ensure it remains effective and accurate.

### Step 4: Understanding Token Usage

Since OpenAI charges based on token usage, it's useful to monitor how many tokens are used per request. The API response includes:

- usage$prompt_tokens → Tokens in the input prompt
- usage$completion_tokens → Tokens generated by the model
- usage$total_tokens → The total token count for billing

To check token usage:


``` r
print(generated_text$usage$total_tokens) # Total tokens used
#> [1] 280
print(generated_text$usage$completion_tokens) # Tokens used for output
#> [1] 261
print(generated_text$usage$prompt_tokens) # Tokens used for input
#> [1] 19
```


## Error Handling

Like we've seen with other APIs, it's important to handle errors gracefully. As with any API call, errors can occur due to network issues, invalid requests, or rate limits. To ensure our script doesn’t crash, we can wrap API calls in `tryCatch()`:


``` r
generate_text_safe <- function(prompt) {
  tryCatch(
    {
      generate_text(prompt)
    },
    error = function(e) {
      warning("API call failed: ", e$message)
      return(NULL)
    }
  )
}
```

Now, we can use `generate_text_safe()` to handle errors. If an error occurs, the function will return `NULL` and print a warning message.

## Processing Multiple Requests

When working with multiple prompts, we can use `purrr::map_chr()` to process them efficiently:



``` r
library(purrr)
prompts <- c(
  "Define p-value",
  "Explain Type I error",
  "What is statistical power?"
)
responses <- list()
responses <- map(prompts, generate_text_safe)
```

This code generates text for each prompt in the `prompts` vector. If an error occurs, the response will be `NULL`. After running this code, we can examine the responses and handle any errors. I've included a table below to display the responses.


```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-67de101c9880bde0887a" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-67de101c9880bde0887a">{"x":{"filter":"none","vertical":false,"data":[["Define p-value","Explain Type I error","What is statistical power?"],["The p-value is a statistical measure that helps determine the strength of the evidence against the null hypothesis. It represents the probability of obtaining results as extreme as the observed results, assuming that the null hypothesis is true. A lower p-value indicates stronger evidence against the null hypothesis, while a higher p-value suggests weaker evidence. Typically, a p-value of 0.05 or less is considered statistically significant.","A Type I error, also known as a false positive, occurs when a significance test incorrectly rejects a null hypothesis that is actually true. In other words, it is the incorrect rejection of a true null hypothesis. This type of error is considered to be a mistake because it indicates that there is a statistically significant effect when there is actually no effect present. \n\nThe probability of making a Type I error is denoted by the significance level of a hypothesis test, usually represented by the Greek letter alpha (α). It is the probability of rejecting a null hypothesis when it is true. \n\nIn statistical hypothesis testing, researchers typically aim to minimize the likelihood of making a Type I error as it can lead to incorrect conclusions and invalid interpretations of data. However, it is important to note that it is not always possible to completely eliminate the risk of making Type I errors, especially when working with sample data and making inferences about a population.","Statistical power is the ability of a study to detect an effect or relationship if it exists. It is the probability that a study will correctly reject the null hypothesis when the null hypothesis is actually false. In other words, statistical power is the likelihood that a study will be able to find a true effect or relationship between variables. A study with high statistical power is more likely to produce accurate and reliable results, while a study with low statistical power is more likely to produce false negative results."],[90,197,109],["gpt-3.5-turbo-0125","gpt-3.5-turbo-0125","gpt-3.5-turbo-0125"],["2026-01-19T16:40:04Z","2026-01-19T16:40:05Z","2026-01-19T16:40:08Z"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>prompt<\/th>\n      <th>ai_response<\/th>\n      <th>tokens_used<\/th>\n      <th>model<\/th>\n      <th>completion_time<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":3,"autoWidth":true,"bInfo":false,"paging":false,"columnDefs":[{"className":"dt-right","targets":2},{"name":"prompt","targets":0},{"name":"ai_response","targets":1},{"name":"tokens_used","targets":2},{"name":"model","targets":3},{"name":"completion_time","targets":4}],"order":[],"orderClasses":false,"lengthMenu":[3,10,25,50,100]}},"evals":[],"jsHooks":[]}</script>
```

As you can see, the table displays the prompts, AI-generated responses, token usage, model name, and completion time for each request. This information can help us monitor the API usage and response quality.


### Rate Limiting

OpenAI has rate limits we need to respect. We can add delays between requests to avoid exceeding these limits. Here's a throttled version of the `generate_text()` function:


``` r
generate_text_throttled <- function(prompt) {
  Sys.sleep(1) # Wait 1 second between requests
  generate_text_safe(prompt)
}
```

This function adds a 1-second delay between requests to avoid exceeding OpenAI's rate limits. You can adjust the delay as needed based on the API's rate limits.

## Conclusion

In this guide, we've covered how to generate text using OpenAI's GPT-3 API in R. We've defined a function to interact with the API, handled responses, extracted generated text, monitored token usage, and processed multiple requests. We've also discussed error handling, rate limiting, and best practices for working with the API. By following these steps, you can effectively use OpenAI's GPT-3 API to generate text in R for various applications. For the curious, yes, these prompts and responses are generated using the OpenAI API every time you render this notebook.
