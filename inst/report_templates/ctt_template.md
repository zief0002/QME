---
title: 'CTT analysis for test: math'
output:
  html_document:
    toc: yes
  pdf_document:
    toc: yes
  word_document: default
date: "Generated Fri Mar 13 15:41:49 2015"
---



**Number of items:** 10

**Number of examinees:** 30


## Total score information

![plot of chunk totalscores](figure/totalscores-1.png) 


## Reliability


```
##                   Estimate  95% LL    95% UL    SEM     
## Coefficient Alpha 0.5729687 0.3025713 0.7678174 1.341974
## Guttman's L2      0.6085092 0.3606162 0.7871412 1.284917
## Guttman's L4      0.5363859 0.2428242 0.7479268 1.398275
## Feldt-Gilmer      0.5910053 0.3320287 0.7776241 1.313328
## Feldt-Brennan     0.5784015 0.3114441 0.7707713 1.33341
```

*Brief notes about reliability assumptions here.*

## Item overview


```
##        difficulty point_biserial corrected_pbis
## item1   0.2333333      0.4723021     0.28574430
## item2   0.2666667      0.3509287     0.13949107
## item3   0.5333333      0.5228541     0.30780336
## item4   0.6333333      0.6063837     0.41972651
## item5   0.8000000      0.3384387     0.14749744
## item6   0.8000000      0.4209847     0.23861126
## item7   0.4666667      0.6022749     0.40651381
## item8   0.3666667      0.3186084     0.08403416
## item9   0.7666667      0.3473957     0.14551217
## item10  0.8333333      0.5537355     0.40528700
```


```
## Error in as.data.frame(mybasics): object 'mybasics' not found
```

```
## Error in rownames(basicdf): object 'basicdf' not found
```

```
## Error in findInterval(basicdf$difficulty, (0:10)/10): object 'basicdf' not found
```

```
## Error in ggplot(basicdf, aes(difficultybin, y = 1, label = item)): object 'basicdf' not found
```



## Item details



### Item 1
Domain: `XX`


```
## Error in getTerciles(x): object 'scores' not found
```

```
## Error in eval(expr, envir, enclos): could not find function "item_names"
```

```
## Error in eval(expr, envir, enclos): object 'tercsummary' not found
```

```
## Error in eval(expr, envir, enclos): could not find function "%>%"
```

```
## Error in rbind(this, fillzeros %>% anti_join(this, by = c("item", "tercile", : object 'this' not found
```

```
## Error in ggplot(thisfull, aes(x = tercile, y = prop, group = response, : object 'thisfull' not found
```

*(these numbers are made up, the package does not yet easily provide the correlation with corrected total or more sophisticated keys)*

| Choice | Key | Proportion | Cor w/ Corrected Total| 
|---:|----:|----:|----:|
|A|0|0.3|-.2|
|D|0|0.47|.02|
|E|1|0.3|.3|

`XX` missing values out of `XX` examinees (`XX` %).

### Item 2
... and so on



