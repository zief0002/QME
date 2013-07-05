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




