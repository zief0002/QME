QME
===
Quantitative Methods in Education R package


Here are some ideas for our package. 

- Reliabilities
- Generalizability Theory
- IRT(?)
- Replicate Thorndike



Mostly we are learning. We are learning about function writing and R programming. We are learning about Github. We are learning about documentation. We are learning about coding style. And most of all, we are learning about how to do this as a collaborative group.


Installing the QME package
======

In theory the following should work

```r
library(devtools)
install_github("QME", "zief0002")
```


Using the QME package
======

The main function for use is called `odin_zeus()`. This requires the following argument,

- `test`: A data frame of raw or keyed responses. The responses can either be numeric or character (i.e., letters). The data frame should be formatted in the wide format, so that each row represents a student, and each column represents an item. 

An example of non-keyed response data is shown below.

```
	> head(math)
	
	  id item1 item2 item3 item4 item5 item6 item7 item8 item9 item10
	1  1     A     A     B     C     C     C     B     C     A      C
	2  2     E     B     C     D     B     C     A     D     C      A
	3  3     D     A     C     E     B     C     C     B     C      A
	4  4     D     E     E     D     B     C     E     B     C      A
	5  5     A     B     B     C     B     C     E     E     B      B
	6  6     A     B     C     D     B     B     A     B     D      A
```

The function assumes that there is an ID column, or respondent names, in the first column. If there is no ID column, use the argument `id = FALSE`.

If the response data has not been keyed, the `key=` argument is also needed. This argument requirers a dataframe of the keyed responses (in a single row) or as a vector.

```
	> math_key
	
	  item1 item2 item3 item4 item5 item6 item7 item8 item9 item10
	1     E     B     C     D     B     C     A     B     C      A
```

To run the function without a DIF analysis we also need to set the arguments `group=` and `focal_name=` to `NULL`.

```
	> oz = odin_zeus(math, key = math_key, group = NULL, focal_name = NULL)
	> pretty_output(oz)
	
	-------------------------------                          
	Number of Items:     10.00
	Number of Examinees: 30.00
	Minimum Score:        1.00
	Maximum Score:        9.00
	Mean Score:           5.70
	Median Score:         6.00
	Standard Deviation:   2.05
	IQR:                  2.75
	Skewness (G1):       -0.26
	Kurtosis (G2):       -0.31
	-------------------------------
```

We can also compute Coefficient Alpha using

```
	> oz$c_alpha
	
	[1] 0.5729687
```


If you want to do a DIF analysis, the `group=`  and `focal_name=` arguments are also required. The `group=` argument is a numeric or character vector indicating group membership for each student. (*Note: Currently this has to be a vector and not a column in the data frame of responses.*) The `focal_name=` argument is the name of the focal group, and must be one of the values included in the vector of group membership.

```r
> group = c("Male", "Female", "Male", "Female", "Female", "Female", "Female", "Male", "Male", "Male")
> oz = odin_zeus(math, key = math_key, group = group, focal_name = "Male")
```

The function performs detection of Differential Item Functioning using (1) the Mantel-Haenszel method, and (2) using Logistic regression methods.

```
	> oz$dif_out$mh

	Detection of Differential Item Functioning using Mantel-Haenszel method 
	with continuity correction and without item purification
	
	Results based on asymptotic inference 
	 
	Mantel-Haenszel Chi-square statistic: 
	 
	       Stat.  P-value    
	id        Inf 0.0000  ***
	item1  0.0000 1.0000     
	item2  0.0000 1.0000     
	item3     Inf 0.0000  ***
	item4  0.0000 1.0000     
	item5     Inf 0.0000  ***
	item6  0.5000 0.4795     
	item7  0.0000 1.0000     
	item8  0.5000 0.4795     
	item9  0.0000 1.0000     
	item10    Inf 0.0000  ***
	
	Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1  
	
	Detection threshold: 3.8415 (significance level: 0.05)
	
	Items detected as DIF items: 
	       
	 id    
	 item3 
	 item5 
	 item10
	
	 
	Effect size (ETS Delta scale): 
	 
	Effect size code: 
	 'A': negligible effect 
	 'B': moderate effect 
	 'C': large effect 
	 
	       alphaMH deltaMH  
	id     NaN     NaN     ?
	item1    0     Inf     C
	item2    0     Inf     C
	item3  NaN     NaN     ?
	item4    0     Inf     C
	item5  NaN     NaN     ?
	item6    0     Inf     C
	item7    0     Inf     C
	item8    0     Inf     C
	item9    0     Inf     C
	item10 NaN     NaN     ?
	
	Effect size codes: 0 'A' 1.0 'B' 1.5 'C' 
	 (for absolute values of 'deltaMH') 
	 
	Output was not captured! 
```

To obtain the logistic regression output, 

```
	> oz$dif_out$logistic
	
	Detection of both types of Differential Item Functioning
	using Logistic regression method, without item purification
	and with LRT DIF statistic
	
	Logistic regression DIF statistic: 
	 
	       Stat.  P-value 
	id     0.0000 1.0000  
	item1  0.6052 0.7389  
	item2  1.4405 0.4866  
	item3  0.4558 0.7962  
	item4  1.6704 0.4338  
	item5  2.9275 0.2314  
	item6  3.7649 0.1522  
	item7  1.8196 0.4026  
	item8  0.1928 0.9081  
	item9  2.5875 0.2742  
	item10 1.5509 0.4605  
	
	Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1  
	
	Detection threshold: 5.9915 (significance level: 0.05)
	
	Items detected as DIF items: No DIF item detected 
	 
	Effect size (Nagelkerke's R^2): 
	 
	Effect size code: 
	 'A': negligible effect 
	 'B': moderate effect 
	 'C': large effect 
	 
	       R^2    ZT JG
	id        NaN ?  ? 
	item1  0.0370 A  B 
	item2  0.0684 A  B 
	item3  0.0208 A  A 
	item4  0.0813 A  C 
	item5  0.1544 B  C 
	item6  0.2359 B  C 
	item7  0.0655 A  B 
	item8  0.0094 A  A 
	item9  0.1148 A  C 
	item10 0.0914 A  C 
	
	Effect size codes: 
	 Zumbo & Thomas (ZT): 0 'A' 0.13 'B' 0.26 'C' 1 
	 Jodoign & Gierl (JG): 0 'A' 0.035 'B' 0.07 'C' 1 
	
	 Output was not captured!
```


For Contributors
===

This section is meant as a helpful resource for our contributors. It lays out the "hows" and "whats" for keeping the package in tip-top shape.

- __Functions:__ Any new functions that you write need to be added to the `R` folder. If they are in-progress, add them into the `future` folder. This way, our package will install without errors. After adding a function to the `R` folder, you need to also add a documentation file for the function into the `man` folder. Documentation files have the extension `.Rd` and are written in a LaTeX-like style. You can read about---and see an example---of a documentation file for functions in the document [Writing R Extensions](http://cran.r-project.org/doc/manuals/r-devel/R-exts.html#Documenting-functions). The last thing you will need to do is add the name of the function into the `NAMESPACE` file. In summary,

	1. Write function and place in `R` directory.
	2. Write documentation file for function and place in the `man` directory.
	3. Add function to `NAMESPACE` file.

- __Datasets:__ Any new datasets that you write need to be added to the `data` folder. These should have the extension `.rda`. After adding a dataset to the `data` folder, you need to also add a documentation file for the dataset into the `man` folder. Documentation files have the extension `.Rd` and are written in a LaTeX-like style. You can read about---and see an example---of a documentation file for datasets in the document [Writing R Extensions](http://cran.r-project.org/doc/manuals/r-devel/R-exts.html#Documenting-data-sets). Datasets are _not_ added to the `NAMESPACE` file. In summary,

	1. Place the `.rda` data in the  `data` directory.
	2. Write documentation file for dataset and place in the `man` directory.

Coding Style
---
We will eventually adopt a more consistent coding style. In the meantime, here is Hadley Wickham's online [Style Guide](https://github.com/hadley/devtools/wiki/Style).


Using the GitHub GUI on your Computer
===
The GitHub GUI allows you to push (upload) and pull (download) changes to the QME package via a point-and-click system. 

One way to think about how GitHub works is that there is a copy of the QME library on the web (at github.com) and another copy (in a folder) on your computer. Now, imagine that you just wrote a function and stored that syntax in the `R` folder on your computer. The copy on the web is now not synchronized...it does not include the function you just wrote. In order to bring the web version up-to-date, you need to _push_ your changes to the web. Let's say that you successfully push your changes to GitHub on the web. Now, the other users local copies (on their computers) are not synchronized with whjat is on the web. To update things on your own computer, you need to _pull_ the code from the web to your own computer.

Pulling New Contributions
---
To sync your computer, you need to synchronize your local repository. In the GitHub GUI, open your local repository. On the Mac, for example, you will see two options on the left-hand side of the screen..._This Computer_ and _GITHUB.COM_. Choose _My Repositories_ below _This Computer_. Next, click on the `QME` repository. Click the `Sync Branch` button. You can also do this through the menu system (on a Mac it is `Repository > Synchronize`). 

Pushing New Contributions
---
To push any changes you made locally to the web, you need to do two things. The first is to _commit_ the changes. This requires you to write a short description of the change so others can follow what you did, or what changes you made. You can make commits by opening your local repository on the GitHub GUI and clicking on the `QME` repository. Then, you should see something telling you that you have _Uncommitted Changes_. Enter a short description in the `Commit Summary` box (lengthier descriptions can be added in the `Extended Description` box. Then, click the `Commit` button.

After you successfully make a commit, then you need to synchronize the commits by clicking the `Sync` button.




