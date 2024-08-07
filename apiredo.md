

# Leveraging API-Wrapping Packages in R {#api-wrappers}

```{r include = FALSE}
source("common.R")
ds4p_funyoutube <- read.csv("admin/csv/ds4p_funyoutube.csv", sep = "")
ds4p_urls <- read.csv("./admin/csv/ds4p_urls.csv")
```

In this chapter, we'll explore how to harness the power of API-wrapping packages in R to streamline your data collection process. This content builds on Jenny Bryan's stat545 materials, with significant updates and additions to reflect current best practices.

```{r, echo=FALSE}
try_include_tweet("https://twitter.com/rfunctionaday/status/1381848183928729600")
```

## The Data Acquisition Spectrum

When it comes to obtaining data from the internet, we can categorize methods into four main types:

1. **Direct Download**: Grabbing readily available flat files (CSV, XLS, etc.)
2. **Wrapped API Access**: Using R packages designed for specific APIs
3. **Raw API Interaction**: Crafting custom queries for APIs
4. **Web Scraping**: Extracting data embedded in HTML structures

We'll focus primarily on the second method, but it's crucial to understand the full spectrum of options at your disposal.

## Streamlined Data Retrieval with API Wrappers

API-wrapping packages act as intermediaries between your R environment and web services. They handle the nitty-gritty of API calls, authentication, and data parsing, allowing you to focus on analysis rather than data acquisition logistics.

### Case Study: Ornithological Data with rebird

Let's dive into a practical example using the `rebird` package, which interfaces with the eBird database.

```{r message = FALSE, warning = FALSE}
library(rebird)
library(tidyverse)
```

First, let's fetch recent bird sightings from a specific location:

```{r eval = FALSE}
vancouver_birds <- ebirdregion("CA-BC-GV", back = 7)
vancouver_birds %>%
  select(comName, howMany, obsDt) %>%
  head(10) %>%
  knitr::kable()
```

Now, let's visualize the most commonly sighted species:

```{r eval = FALSE}
vancouver_birds %>%
  count(comName, sort = TRUE) %>%
  top_n(10) %>%
  ggplot(aes(x = reorder(comName, n), y = n)) +
  geom_col() +
  coord_flip() +
  labs(x = "Species", y = "Number of Sightings",
       title = "Top 10 Bird Species Sighted in Vancouver (Last 7 Days)")
```

This example demonstrates how API wrappers like `rebird` can quickly transform raw data into actionable insights.

### Geospatial Exploration with geonames

The `geonames` package offers a gateway to rich geographical data. Here's how to use it effectively:

```{r message = FALSE, warning = FALSE}
library(geonames)
```

Before diving in, ensure you've set up your geonames account and configured R correctly:

```r
options(geonamesUsername = "your_username")
```

Now, let's explore some geographical data:

```{r eval = FALSE}
# Fetch information about the highest points in Canada
canada_peaks <- GNhighest(country = "CA", maxRows = 10)

canada_peaks %>%
  select(name, elevation, latitude, longitude) %>%
  knitr::kable()
```

We can even create a simple map of these peaks:

```{r eval = FALSE}
library(leaflet)

leaflet(canada_peaks) %>%
  addTiles() %>%
  addMarkers(~longitude, ~latitude, popup = ~paste(name, elevation, "m"))
```

## Best Practices for API Interaction

When working with APIs, keep these guidelines in mind:

1. **Rate Limiting**: Respect the API's usage limits to avoid being blocked.
2. **Error Handling**: Implement robust error handling to manage API downtime or unexpected responses.
3. **Data Caching**: For frequent queries, consider caching results to reduce API calls.
4. **Authentication Security**: Never hardcode API keys in your scripts. Use environment variables or secure vaults.

Here's an example of proper API key management:

```r
# In your .Renviron file
EBIRD_API_KEY=your_secret_key

# In your R script
api_key <- Sys.getenv("EBIRD_API_KEY")
```

## Extending Your API Toolkit

While we've focused on `rebird` and `geonames`, numerous other API-wrapping packages exist. Here are a few worth exploring:

- `rtweet`: Access Twitter's API
- `spotifyr`: Interact with Spotify's music data
- `googlesheets4`: Work with Google Sheets
- `wikidataR`: Query Wikidata's knowledge base

Each of these packages opens up new realms of data for your analyses, following similar principles to what we've covered.

## Conclusion

API-wrapping packages in R provide a powerful means to access diverse datasets with minimal friction. By leveraging these tools, you can spend less time on data acquisition and more on meaningful analysis. As you continue your data science journey, experiment with different API wrappers and consider how they can enhance your research and projects.

```{r links, child="admin/md/courselinks.md"}
```