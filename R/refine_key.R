refine_key = function(row_key, test_with_id){
  ## Create data frame key structure from vector or single-row data frame

  ## If data frame, convert to vector first
  if(is.data.frame(row_key)) {
    # drop unused factor levels
    row_key = droplevels(row_key)
    
    row_key = vapply(row_key, as.character, "A")
    
  }
    
  # Find the unique responses
  response = unique(row_key)
  
  # Create an nresponse x nkey matrix with each column filled by the responses
  temp_key = matrix(response,nrow=length(response),ncol=length(row_key))
  
  # Coerce each key element into a separate list
  work_key = lapply(row_key, as.character)
  
  #Create an empty list
  new_key = vector("list", nrow(temp_key))
  
  # Check if each item is correct or incorrect and store that in the appropriate list element
  for(i in 1:nrow(temp_key)){
    new_key[[i]] = as.numeric(temp_key[i , 1] == work_key)
  }
  
  # Bind the results into a data frame and add responses as first column
  new_key = as.data.frame(do.call(rbind, new_key))
  
  # Rename columns of key to match original test.
  # Proposed check_keynames function will handle more complex cases
  names(new_key) = names(test_with_id)[-1] 
  
  new_key = cbind(response, new_key)

  return(new_key)
}

# # Test keys
# key = c("E","B","C","D","B","C","A" ,"B", "C","A")
# refine_key(math_key)
# key = c("GB", "ND", "WI", "MN", "ND", "ND", "WI", "GB")

create_key_fn = function(test_with_id) {
  x = test_with_id[,-1]
  unique_vals = unique(as.numeric(as.matrix(x)))
  created_key = as.data.frame(sapply(c("response", names(x)), 
                                     function(x) unique_vals, 
                                     USE.NAMES = TRUE, 
                                     simplify = FALSE))
  
}
