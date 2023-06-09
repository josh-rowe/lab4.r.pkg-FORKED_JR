
#' Get nutrition facts
#' 
#' @param app_id A string
#' @param app_key A string
#' @param q A string
#' @param diet A string
#' @param health A string
#' @param cuisineType A string
#' @param mealType A string
#' @param dishType A string
#' @param type A string
#' @param beta A string
#' 
#' @return A dataframe with recipe link and nutrition facts
#' 
#' @export
#' 



get_nutrition_facts <- function (q, app_id = "9f80d298", app_key = 
                                   "e12319d6fd3db51d5a389c6336431579", 
                                 diet = "balanced", health = "", cuisineType = "", 
                                 mealType = "", dishType = "", type = "public", 
                                 beta = "false", public = "true") {
  
  stopifnot(is.character(q))
  stopifnot(is.character(app_id))
  stopifnot(is.character(app_key))
  stopifnot(is.character(diet))
  stopifnot(is.character(health))
  stopifnot(is.character(cuisineType))
  stopifnot(is.character(mealType))
  stopifnot(is.character(dishType))
  stopifnot(is.character(type))
  stopifnot(is.character(beta))
  stopifnot(is.character(public))
  
  url_start <- "https://api.edamam.com/api/recipes/v2?"
  
  q <- stringr::str_replace_all(q, "[&]", "%26")
  q <- stringr::str_replace_all(q, " ", "%20")
  
  if(health != ""){
    
    health = glue::glue("&health=", health)
    
  }
  
  if(diet != ""){
    
    diet = glue::glue("&diet=", diet)
    
  }
  
  if(cuisineType != ""){
    
    cuisineType = glue::glue("&cuisineType=", cuisineType)
    
  }
  
  if(mealType != ""){
    
    mealType = glue::glue("&mealType=", mealType)
    
  }
  
  if(dishType != ""){
    
    dishType = glue::glue("&dishType=", dishType)
    
  }
  
  type <- glue::glue("type=", type)
  
  q <- glue::glue("&q=", q)
  
  beta <- glue::glue("&beta=", beta)
  
  public <- glue::glue("&public=", public)
  
  app_id <- glue::glue("&app_id=", app_id)
  
  app_key <- glue::glue("&app_key=", app_key)
  
  
  url <- glue::glue(url_start, type, beta, q, app_id, app_key, diet, health,
                    cuisineType, mealType)
  
  # use this code to see if it correctly builds the URL
  # return(url)
  
  rawJSON <- httr::GET(url)

  JSON_list <- jsonlite::fromJSON(rawToChar(rawJSON$content))

  JSON_hits <- JSON_list$hits
  
  JSON_recipe <- JSON_hits$recipe
  
  JSON_nutrients <- JSON_recipe$totalNutrients
  
  return(JSON_nutrients)

}