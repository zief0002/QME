---
title: 'CTT analysis for test: math'
output:
  html_document:
    toc: yes
  pdf_document:
    toc: yes
  word_document: default
date: "Generated Fri Mar 13 15:58:28 2015"
---



**Number of items:** 10

**Number of examinees:** 30


## Total score information

![plot of chunk totalscores](figure/totalscores-1.png) 

```
##                         Value
## Minimum Score       1.0000000
## Maximum Score       9.0000000
## Mean Score          5.7000000
## Median Score        6.0000000
## Standard Deviation  2.0535923
## IQR                 2.7500000
## Skewness(G1)       -0.2564729
## Kurtosis (G2)      -0.3068652
```

```
## Error in is.data.frame(x): object 'tinfo2' not found
```


## Reliability


```
##                   Estimate  95% LL    95% UL    SEM     
## Coefficient Alpha 0.5729687 0.3025713 0.7678174 1.341974
## Guttman's L2      0.6085092 0.3606162 0.7871412 1.284917
## Guttman's L4      0.5363859 0.2428242 0.7479268 1.398275
## Feldt-Gilmer      0.5910053 0.3320287 0.7776241 1.313328
## Feldt-Brennan     0.5784015 0.3114441 0.7707713 1.33341
```

```
##     item1     item2     item3     item4     item5     item6     item7 
## 0.5393041 0.5760439 0.5317487 0.4985795 0.5718157 0.5510778 0.5012496 
##     item8     item9    item10 
## 0.5936747 0.5734223 0.5144547
```

*Brief notes about reliability assumptions here.*

## Item overview


|       | Difficulty| PBiS| Corrected PBiS| Missing (N)| Missing (p)|
|:------|----------:|----:|--------------:|-----------:|-----------:|
|item1  |       0.23| 0.47|           0.29|           0|        0.00|
|item2  |       0.27| 0.35|           0.14|           0|        0.00|
|item3  |       0.53| 0.52|           0.31|           2|        0.07|
|item4  |       0.63| 0.61|           0.42|           0|        0.00|
|item5  |       0.80| 0.34|           0.15|           1|        0.03|
|item6  |       0.80| 0.42|           0.24|           0|        0.00|
|item7  |       0.47| 0.60|           0.41|           2|        0.07|
|item8  |       0.37| 0.32|           0.08|           1|        0.03|
|item9  |       0.77| 0.35|           0.15|           0|        0.00|
|item10 |       0.83| 0.55|           0.41|           0|        0.00|

```
## stat_bindot: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk item_overview](figure/item_overview-1.png) 




```r
basicdf$difficultybin = findInterval(basicdf$difficulty, (0:10)/10)/10 - 0.05
```

```
## Error in findInterval(basicdf$difficulty, (0:10)/10): object 'basicdf' not found
```

```r
ggplot(basicdf, aes(difficultybin,
                    y = 1,
                    label = item)) + 
  geom_text(position = "stack") + 
  scale_y_continuous("Number of items") +
  scale_x_continuous("Difficulty") +
  coord_cartesian(xlim = c(0, 1)) +
  coord_flip() +
  ggtitle("Item Difficulties")
```

```
## Error in ggplot(basicdf, aes(difficultybin, y = 1, label = item)): object 'basicdf' not found
```



## Item details


```
## [[1]]
## [[1]]$`Dist_diff of Item1`
## 
##         A         D         E 
## 0.3000000 0.4666667 0.2333333 
## 
## [[1]]$`Dist_diff of Item2`
## 
##          A          B          C          D          E 
## 0.46666667 0.26666667 0.10000000 0.06666667 0.10000000 
## 
## [[1]]$`Dist_diff of Item3`
## 
##                     A          B          C          D          E 
## 0.06666667 0.06666667 0.06666667 0.53333333 0.06666667 0.20000000 
## 
## [[1]]$`Dist_diff of Item4`
## 
##         C         D         E 
## 0.1333333 0.6333333 0.2333333 
## 
## [[1]]$`Dist_diff of Item5`
## 
##                     B          C 
## 0.03333333 0.80000000 0.16666667 
## 
## [[1]]$`Dist_diff of Item6`
## 
##   A   B   C 
## 0.1 0.1 0.8 
## 
## [[1]]$`Dist_diff of Item7`
## 
##                     A          B          C          D          E 
## 0.06666667 0.46666667 0.16666667 0.10000000 0.06666667 0.13333333 
## 
## [[1]]$`Dist_diff of Item8`
## 
##                     A          B          C          D          E 
## 0.03333333 0.03333333 0.36666667 0.16666667 0.16666667 0.23333333 
## 
## [[1]]$`Dist_diff of Item9`
## 
##          A          B          C          D          E 
## 0.06666667 0.03333333 0.76666667 0.10000000 0.03333333 
## 
## [[1]]$`Dist_diff of Item10`
## 
##          A          B          C          D 
## 0.83333333 0.10000000 0.03333333 0.03333333 
## 
## 
## [[2]]
## [[2]]$`Dist_disc of Item1`
## [1] -0.20367271 -0.05516619  0.28574430
## 
## [[2]]$`Dist_disc of Item2`
## [1] -0.17730315  0.13949107  0.04073556 -0.06065634  0.09892921
## 
## [[2]]$`Dist_disc of Item3`
## [1]  0.04924854  0.04924854 -0.46786110  0.30780336 -0.02462427 -0.13820336
## 
## [[2]]$`Dist_disc of Item4`
## [1] -0.4028316  0.4197265 -0.1544557
## 
## [[2]]$`Dist_disc of Item5`
## [1] -0.08700222  0.14749744 -0.11640505
## 
## [[2]]$`Dist_disc of Item6`
## [1] -0.27690689 -0.04124145  0.23861126
## 
## [[2]]$`Dist_disc of Item7`
## [1]  0.04039889  0.40651381 -0.21125084 -0.23303648 -0.03534903 -0.16304574
## 
## [[2]]$`Dist_disc of Item8`
## [1]  0.16113948 -0.03222790  0.08403416 -0.07761505  0.20179914 -0.25987926
## 
## [[2]]$`Dist_disc of Item9`
## [1] -0.270004109 -0.187601105  0.145512173  0.127734386  0.006469004
## 
## [[2]]$`Dist_disc of Item10`
## [1]  0.40528700 -0.21749983 -0.39042414 -0.08750886
```


