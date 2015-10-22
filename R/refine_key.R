refine_key = function(key){
  # Find the unique responses
  response = unique(key)
  
  # Create an nresponse x nkey matrix with each column filled by the responses
  temp_key = matrix(response,nrow=length(response),ncol=length(key))
  
  # Coerce each key element into a separate list
  work_key = lapply(key, as.character)
  
  #Create an empty list
  new_key = vector("list", nrow(temp_key))
  
  # Check if each item is correct or incorrect and store that in the appropriate list element
  for(i in 1:nrow(temp_key)){
    new_key[[i]] = as.numeric(temp_key[i , 1] == work_key)
  }
  
  # Bind the results into a data frame and add responses as first column
  new_key = as.data.frame(do.call(rbind, new_key))
  new_key = cbind(response, new_key)
  
  key_data = list(
    key = key,
    new_key = new_key
  )
  return(key_data)
}

# # Test keys
# key = c('A','B','C','D','B','C','A')
# key = c("E","B","C","D","B","C","A" ,"B", "C","A")
# key = c("GB", "ND", "WI", "MN", "ND", "ND", "WI", "GB")
  