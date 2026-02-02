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
#> [1] "chatcmpl-D4swjFWQOhRut3kCDkTReE5mCsaIs"
#> 
#> $object
#> [1] "chat.completion"
#> 
#> $created
#> [1] 1770056897
#> 
#> $model
#> [1] "gpt-3.5-turbo-0125"
#> 
#> $choices
#>   index message.role
#> 1     0    assistant
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             message.content
#> 1 1. Define the problem: Clearly define the research question or problem that needs to be solved.\n\n2. Data collection: Gather relevant data from various sources, ensuring it is clean and ready for analysis.\n\n3. Data cleaning and preprocessing: Clean and preprocess the data to remove any inconsistencies or missing values.\n\n4. Data exploration: Explore the data using descriptive statistics and data visualization techniques to understand its characteristics and identify patterns.\n\n5. Feature engineering: Extract and create new features from the existing data to improve the performance of the model.\n\n6. Model selection: Choose the appropriate machine learning algorithm or model that best fits the problem being solved.\n\n7. Model training: Train the selected model using the cleaned and preprocessed data.\n\n8. Model evaluation: Evaluate the performance of the trained model using metrics such as accuracy, precision, recall, and F1-score.\n\n9. Model fine-tuning: Fine-tune the parameters of the model to improve its performance.\n\n10. Deployment: Deploy the trained model for real-world applications and monitor its performance over time.\n\n11. Interpretation and communication of results: Interpret the model's predictions and communicate the results to stakeholders in a clear and understandable way.
#>   message.refusal message.annotations logprobs finish_reason
#> 1              NA                NULL       NA          stop
#> 
#> $usage
#> $usage$prompt_tokens
#> [1] 19
#> 
#> $usage$completion_tokens
#> [1] 236
#> 
#> $usage$total_tokens
#> [1] 255
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
#> [1] "1. Define the problem: Clearly define the research question or problem that needs to be solved.\n\n2. Data collection: Gather relevant data from various sources, ensuring it is clean and ready for analysis.\n\n3. Data cleaning and preprocessing: Clean and preprocess the data to remove any inconsistencies or missing values.\n\n4. Data exploration: Explore the data using descriptive statistics and data visualization techniques to understand its characteristics and identify patterns.\n\n5. Feature engineering: Extract and create new features from the existing data to improve the performance of the model.\n\n6. Model selection: Choose the appropriate machine learning algorithm or model that best fits the problem being solved.\n\n7. Model training: Train the selected model using the cleaned and preprocessed data.\n\n8. Model evaluation: Evaluate the performance of the trained model using metrics such as accuracy, precision, recall, and F1-score.\n\n9. Model fine-tuning: Fine-tune the parameters of the model to improve its performance.\n\n10. Deployment: Deploy the trained model for real-world applications and monitor its performance over time.\n\n11. Interpretation and communication of results: Interpret the model's predictions and communicate the results to stakeholders in a clear and understandable way."
```

Ok, so that wasn't really readable. Let's try to format it a bit better:



``` r
cat(ai_response)
```

1. Define the problem: Clearly define the research question or problem that needs to be solved.

2. Data collection: Gather relevant data from various sources, ensuring it is clean and ready for analysis.

3. Data cleaning and preprocessing: Clean and preprocess the data to remove any inconsistencies or missing values.

4. Data exploration: Explore the data using descriptive statistics and data visualization techniques to understand its characteristics and identify patterns.

5. Feature engineering: Extract and create new features from the existing data to improve the performance of the model.

6. Model selection: Choose the appropriate machine learning algorithm or model that best fits the problem being solved.

7. Model training: Train the selected model using the cleaned and preprocessed data.

8. Model evaluation: Evaluate the performance of the trained model using metrics such as accuracy, precision, recall, and F1-score.

9. Model fine-tuning: Fine-tune the parameters of the model to improve its performance.

10. Deployment: Deploy the trained model for real-world applications and monitor its performance over time.

11. Interpretation and communication of results: Interpret the model's predictions and communicate the results to stakeholders in a clear and understandable way.

### Step 4: Understanding Token Usage

Since OpenAI charges based on token usage, it's useful to monitor how many tokens are used per request. The API response includes:

- usage$prompt_tokens → Tokens in the input prompt
- usage$completion_tokens → Tokens generated by the model
- usage$total_tokens → The total token count for billing

To check token usage:


``` r
print(generated_text$usage$total_tokens) # Total tokens used
#> [1] 255
print(generated_text$usage$completion_tokens) # Tokens used for output
#> [1] 236
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
<div class="datatables html-widget html-fill-item" id="htmlwidget-f56deeb1a8da4a9c974b" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-f56deeb1a8da4a9c974b">{"x":{"filter":"none","vertical":false,"data":[["Define p-value","Explain Type I error","What is statistical power?"],["The p-value is a statistical measure that helps determine the strength of evidence against the null hypothesis in a hypothesis test. It represents the probability of obtaining results as extreme as the observed results, assuming that the null hypothesis is true. A smaller p-value indicates stronger evidence against the null hypothesis, which typically leads to rejecting the null hypothesis in favor of the alternative hypothesis. Typically, a p-value of 0.05 or less is considered statistically significant.","A Type I error, also known as a false positive, occurs when a statistical test incorrectly rejects a true null hypothesis. In other words, it occurs when the test concludes that there is a significant effect or relationship when in reality there is not. \n\nThis error is typically represented by the alpha level, which is the probability of making a Type I error. Commonly used alpha levels are 0.05 or 0.01, meaning that there is a 5% or 1% chance, respectively, of incorrectly rejecting the null hypothesis. \n\nType I errors are an important consideration in statistical hypothesis testing because they can lead to incorrect conclusions and decisions. Researchers must weigh the risks of making a Type I error against the benefits of correctly identifying a true effect.","Statistical power is the probability that a statistical test will correctly reject a false null hypothesis, or in other words, the likelihood that a study will detect an effect when it is present. It is influenced by factors such as sample size, effect size, and level of significance chosen for the study. A higher statistical power indicates a lower chance of committing a Type II error, which is failing to reject a false null hypothesis."],[99,165,96],["gpt-3.5-turbo-0125","gpt-3.5-turbo-0125","gpt-3.5-turbo-0125"],["2026-02-02T18:28:20Z","2026-02-02T18:28:23Z","2026-02-02T18:28:26Z"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th>prompt<\/th>\n      <th>ai_response<\/th>\n      <th>tokens_used<\/th>\n      <th>model<\/th>\n      <th>completion_time<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":3,"autoWidth":true,"bInfo":false,"paging":false,"columnDefs":[{"className":"dt-right","targets":2},{"name":"prompt","targets":0},{"name":"ai_response","targets":1},{"name":"tokens_used","targets":2},{"name":"model","targets":3},{"name":"completion_time","targets":4}],"order":[],"orderClasses":false,"lengthMenu":[3,10,25,50,100]}},"evals":[],"jsHooks":[]}</script>
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
