QME: Quantitative Methods in Education
===

The `QME` package was created to provide a relatively easy-to-use tool for performing psychometric analyses in R under the Classical Test Theory framework. The package provides practitioners with the functionality to:
- import and score test data (`QMEtest()`)
- compute item- and test-level statistics (`analyze()`)
- perform distractor analysis (`analyze()`)
- quickly generate a comprehensive psychometric report (`report()`)


Installing the QME package
======

```r
library(devtools)
install_github("zief0002/QME") 
```

Scoring
======

The function for scoring and calculating basic psychometrics is called `analyze()`. Using the example data included with `QME`:

```{r}
  an = analyze(test = math, key = math_key)

```

`test` is a data frame of raw or keyed responses. The responses can either be numeric or character (i.e., letters). The data frame should be formatted in the wide format, so that each row represents a student, and each column represents an item. An example of non-keyed response data is shown below.

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

If the response data has not been keyed, the `key =` argument is also needed. This argument can be in two forms, depending on the complexity of the scoring.

A *simple key* is recommended if the items have only one correct answer, scored 1, with all other possible values scored as 0.  A simple key can be provided as a named vector or single-row data frame, where the names are the names of the items and the values are the correct answer (scored 1, and all other responses scored 0). The included `math_key` is of the simple key form. 

```
  > math_key
   item1  item2  item3  item4  item5  item6  item7  item8  item9 item10 
     "E"    "B"    "C"    "D"    "B"    "C"    "A"    "B"    "C"    "A"
```

If the scoring scheme is more complex, such as a test with multiple correct answers, a *full key* can be provided; this must be provided as a data frame where the first column, `response`, contains all the possible responses to any item, and the subsequent columns correspond to each item, with each value in that column representing that item's score for that row's response. See `vignette("scoring")` for more help on setting up the key.  The included `math_full_key` is of the full key form, but results in the same scoring as the simpler `math_key`.

```
  > math_full_key
    response item1 item2 item3 item4 item5 item6 item7 item8 item9 item10
  1        E     1     0     0     0     0     0     0     0     0      0
  2        B     0     1     0     0     1     0     0     1     0      0
  3        C     0     0     1     0     0     1     0     0     1      0
  4        D     0     0     0     1     0     0     0     0     0      0
  5        A     0     0     0     0     0     0     1     0     0      1

```

## Creating a report

This is done with the `report()` function.  This takes an object created by `analyze()` and generates an HTML, Word, or PDF report with comprehensive psychometrics and this is the recommended way of using this package. (Note that a PDF document relies on the computer having working LaTeX software.)

You can view the package's example report, using the `an` object we created above:

```
   > report(an, report_filename = "Math_Report", output_format = "html_document")
```

The first argument is the name of your `analyze` object; `report_filename` is the file name of the report (not including the file extension); `output_format` is one of `"html_document"`, `"word_document"`, or `"pdf_document"`.

## Future directions

We plan to include more support for comparing groups and greater support for survey and ordinal data.  Even further in the future we hope to provide interfaces to Generalizabilty Theory and IRT.