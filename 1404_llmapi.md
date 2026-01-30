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
#> [1] "chatcmpl-D3otEh0VoNAQq8RITMMINPwPgsxnY"
#> 
#> $object
#> [1] "chat.completion"
#> 
#> $created
#> [1] 1769802976
#> 
#> $model
#> [1] "gpt-3.5-turbo-0125"
#> 
#> $choices
#>   index message.role
#> 1     0    assistant
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            message.content
#> 1 1. Define the problem: Clearly articulate the problem or question you are trying to answer with data analysis.\n\n2. Data collection: Gather relevant data from various sources, such as databases, files, APIs, or web scraping.\n\n3. Data cleaning and preprocessing: Clean the data by handling missing values, removing duplicates, encoding categorical variables, and scaling numerical features.\n\n4. Exploratory data analysis (EDA): Explore the data through statistical summaries, visualizations, and correlation analysis to gain insights and identify patterns.\n\n5. Feature engineering: Create new features or transform existing ones to improve model performance and interpretability.\n\n6. Model selection: Choose an appropriate machine learning algorithm based on the problem type (classification, regression, clustering) and the data characteristics.\n\n7. Model training: Split the data into training and testing sets, and train the selected model on the training data.\n\n8. Model evaluation: Evaluate the model's performance using metrics such as accuracy, precision, recall, F1 score, or confusion matrix.\n\n9. Model tuning: Fine-tune hyperparameters and optimize the model to improve its performance.\n\n10. Deployment: Deploy the model to a production environment or integrate it into existing systems to make predictions on new data.\n\n11. Monitoring and maintenance: Continuously monitor the model's performance, retrain it with new data periodically, and make necessary updates to ensure its effectiveness and accuracy over time.
#>   message.refusal message.annotations logprobs finish_reason
#> 1              NA                NULL       NA          stop
#> 
#> $usage
#> $usage$prompt_tokens
#> [1] 19
#> 
#> $usage$completion_tokens
#> [1] 280
#> 
#> $usage$total_tokens
#> [1] 299
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
#> [1] "1. Define the problem: Clearly articulate the problem or question you are trying to answer with data analysis.\n\n2. Data collection: Gather relevant data from various sources, such as databases, files, APIs, or web scraping.\n\n3. Data cleaning and preprocessing: Clean the data by handling missing values, removing duplicates, encoding categorical variables, and scaling numerical features.\n\n4. Exploratory data analysis (EDA): Explore the data through statistical summaries, visualizations, and correlation analysis to gain insights and identify patterns.\n\n5. Feature engineering: Create new features or transform existing ones to improve model performance and interpretability.\n\n6. Model selection: Choose an appropriate machine learning algorithm based on the problem type (classification, regression, clustering) and the data characteristics.\n\n7. Model training: Split the data into training and testing sets, and train the selected model on the training data.\n\n8. Model evaluation: Evaluate the model's performance using metrics such as accuracy, precision, recall, F1 score, or confusion matrix.\n\n9. Model tuning: Fine-tune hyperparameters and optimize the model to improve its performance.\n\n10. Deployment: Deploy the model to a production environment or integrate it into existing systems to make predictions on new data.\n\n11. Monitoring and maintenance: Continuously monitor the model's performance, retrain it with new data periodically, and make necessary updates to ensure its effectiveness and accuracy over time."
```

Ok, so that wasn't really readable. Let's try to format it a bit better:



``` r
cat(ai_response)
```

1. Define the problem: Clearly articulate the problem or question you are trying to answer with data analysis.

2. Data collection: Gather relevant data from various sources, such as databases, files, APIs, or web scraping.

3. Data cleaning and preprocessing: Clean the data by handling missing values, removing duplicates, encoding categorical variables, and scaling numerical features.

4. Exploratory data analysis (EDA): Explore the data through statistical summaries, visualizations, and correlation analysis to gain insights and identify patterns.

5. Feature engineering: Create new features or transform existing ones to improve model performance and interpretability.

6. Model selection: Choose an appropriate machine learning algorithm based on the problem type (classification, regression, clustering) and the data characteristics.

7. Model training: Split the data into training and testing sets, and train the selected model on the training data.

8. Model evaluation: Evaluate the model's performance using metrics such as accuracy, precision, recall, F1 score, or confusion matrix.

9. Model tuning: Fine-tune hyperparameters and optimize the model to improve its performance.

10. Deployment: Deploy the model to a production environment or integrate it into existing systems to make predictions on new data.

11. Monitoring and maintenance: Continuously monitor the model's performance, retrain it with new data periodically, and make necessary updates to ensure its effectiveness and accuracy over time.

### Step 4: Understanding Token Usage

Since OpenAI charges based on token usage, it's useful to monitor how many tokens are used per request. The API response includes:

- usage$prompt_tokens → Tokens in the input prompt
- usage$completion_tokens → Tokens generated by the model
- usage$total_tokens → The total token count for billing

To check token usage:


``` r
print(generated_text$usage$total_tokens) # Total tokens used
#> [1] 299
print(generated_text$usage$completion_tokens) # Tokens used for output
#> [1] 280
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
<div class="datatables html-widget html-fill-item" id="htmlwidget-ea84b73e60b077e3b71e" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-ea84b73e60b077e3b71e">{"x":{"filter":"none","vertical":false,"data":[["Define p-value","Explain Type I error","What is statistical power?"],["In statistics, the p-value is the probability that the observed data or something more extreme would occur if the null hypothesis is true. It is a measure of the strength of the evidence against the null hypothesis and is used in hypothesis testing to determine whether to accept or reject the null hypothesis. A lower p-value indicates stronger evidence against the null hypothesis. The standard threshold for statistical significance is typically set at p &lt; 0.05.","Type I error, also known as a false positive, occurs when a null hypothesis is rejected when it is actually true. In other words, it is the mistake of concluding that there is a significant effect or relationship when none actually exists.\n\nFor example, in a medical test, a Type I error would occur if a healthy person is mistakenly diagnosed with a disease. This can lead to unnecessary treatments and medical interventions, as well as unnecessary emotional distress for the person receiving the false positive result.\n\nThe likelihood of committing a Type I error is denoted by the significance level of a statistical test, typically set at 0.05 or 0.01. This means that there is a 5% or 1% chance of incorrectly rejecting the null hypothesis when it is actually true. Researchers must be aware of the possibility of Type I errors and take steps to minimize their occurrence, such as conducting additional tests or replicating the study findings.","Statistical power is the probability that a hypothesis test will correctly reject a null hypothesis when it is actually false. In other words, it is the likelihood that the study will detect a true effect if there is one present. High statistical power indicates a low probability of making a Type II error (failing to reject a false null hypothesis), while low statistical power increases the risk of Type II errors. It is typically calculated as 1 minus the probability of a Type II error, or the probability of correctly rejecting a false null hypothesis."],[96,199,118],["gpt-3.5-turbo-0125","gpt-3.5-turbo-0125","gpt-3.5-turbo-0125"],["2026-01-30T19:56:20Z","2026-01-30T19:56:22Z","2026-01-30T19:56:25Z"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>prompt<\/th>\n      <th>ai_response<\/th>\n      <th>tokens_used<\/th>\n      <th>model<\/th>\n      <th>completion_time<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":3,"autoWidth":true,"bInfo":false,"paging":false,"columnDefs":[{"className":"dt-right","targets":2},{"name":"prompt","targets":0},{"name":"ai_response","targets":1},{"name":"tokens_used","targets":2},{"name":"model","targets":3},{"name":"completion_time","targets":4}],"order":[],"orderClasses":false,"lengthMenu":[3,10,25,50,100]}},"evals":[],"jsHooks":[]}</script>
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
