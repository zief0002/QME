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


