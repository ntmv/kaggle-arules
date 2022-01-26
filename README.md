
## Association Rule Learning: Exploring the 2017 Kaggle Machine Learning and Data Science Survey through a Shiny App

### Assignment B4: Option C

In 2017, Kaggle conducted an industry-wide survey to gain a
comprehensive understanding of the data science and machine learning job
landscape. Over 16,000 data scientists, students and professionals
working in related fields answered the survey. The following Shiny
dashboard interactively visualizes interesting sets of relations between
survey responses to different questions. These sets were mined via
association rule learning.

The updated shiny dashboard can be accessed by following this link:

<https://ntmv.shinyapps.io/aruleskaggle2017_updated/>

The shiny dashboard submitted for Assignment B-3 can be accessed on the
Shiny apps server by following this link:

<https://ntmv.shinyapps.io/shiny_app/>

The app is built incorporating algorithms and visualizations powered by
the `arules` and `arulesViz` libraries.

This updated version of the app largely features changes to the UI, with
the app being migrated to `shinydashboard` for a cleaner user
interaction and a larger visualization, with an information button that
details the purpose and use of the app.

### Overview of the Dataset

The 2017 Kaggle Machine Learning & Data Science Survey can be accessed
on Kaggle (<https://www.kaggle.com/kaggle/kaggle-survey-2017>). A subset
of the `multipleChoiceResponses.csv` dataset, which contains the
respondent’s answers to multiple choice and ranking questions was used.
The code used to clean and subset the original dataset can be found in
the `cleankaggle2017.R` file.

The subset contains the responses to the following questions:

-   `Q1`: Gender

-   `Q2`: Age-group Category

-   `Q3`: Country

-   `Q4`: Highest Formal Education Level

-   `Q5`: Major/area of study

-   `Q6`: Current job title

-   `Q9`: Annual Income

-   `Q12`: Preferred analysis software

-   `Q17`: Preferred programming language

-   `Q18`: Recommended language for an aspiring data scientist

-   `Q20`: Preferred machine learning library

-   `Q22`: Preferred visualization library

-   `Q23`: Proportion of time spent coding daily at work/university

-   `Q25`: Machine learning experience

-   `Q26`: Do you self-identify as a data-scientist

-   `Q32` : Type of data worked with most often

-   `Q37`: Preferred online data science resource (coursera,
    Udemy,..etc.)

-   `Q39`: Opinion on how much better online courses are compared to
    traditional courses

### Overview of Association Rule Learning

Association Rule learning is a text-mining technique that can
conveniently construct sets of items which frequently co-occur together
in a dataset. An example of an association rule for this dataset is as
follows,

`{Q6: Job Title=Product/Project Manager} => {Q4: Education=Master’s degree}`

which indicates that having a job as a product/project manager has a
consequent relationship with having a Masters degree.

# Shiny Dashboard Features

The app uses the APRIORI algorithm which mines for the most frequent
itemsets. The specific features of the app are as follows:

1.  Sliders to set the following parameters: `Support` (how often a rule
    is applicable in a given dataset), `Confidence` (the frequency of
    itemset appearances), `Minimum` and `Maximum` itsemset length.
    Setting the support and confidence to be high generates more
    interesting and reliable rules respectively.

2.  Checkbox option to remove redundant rules. This enables the option
    to remove rules that are a subset of a more general rule with
    similar or higher confidence. More details regarding redundant rules
    can be found in the documentation of the corresponsding function
    `??arules::is.redundant`. This additionally outputs a text message
    specifying the number of rules removed.

3.  An interactive association scatterplot graph which visualizes the
    rules. This is a html widget powered by `visNetwork`. The
    interactive graph allows searching for specific rules, specific
    variables, and quickly obtaining quality metrics for a rule of
    interest by hovering over the rule.

4.  An interactive datatable containing the rules, along with additional
    quality metrics (support, confidence, coverage, lift and count)
    which the table can be sorted by.

5.  A download button for the rules datatable to be downloaded for
    further visualizations and analyses

# Repository Organization

The server and UI code can be found in `app.R`. The code used to clean
and subset the full dataset can be found in `cleankaggle2017.R`. The
subsetted datasetcsv file is named `surveydata.csv`. The `rsconnect`
folder contains the `DCF` file used to deploy the dashboard.

# References

Hahsler M, Chelluboina S, Hornik K, Buchta C (2011). “The arules
R-Package Ecosystem: Analyzing Interesting Patterns from Large
Transaction Datasets.” *Journal of Machine Learning Research*, *12*,
1977-1981. &lt;URL:
<https://jmlr.csail.mit.edu/papers/v12/hahsler11a.html>&gt;.

Hahsler M (2017). “arulesViz: Interactive Visualization of Association
Rules with R.” *R Journal*, *9*(2), 163-175. ISSN 2073-4859, doi:
10.32614/RJ-2017-047 (URL: <https://doi.org/10.32614/RJ-2017-047>),
&lt;URL:
<https://journal.r-project.org/archive/2017/RJ-2017-047/RJ-2017-047.pdf>&gt;.

Tan, P.-N., Steinbach, M.,, Kumar, V. (2005). Introduction to Data
Mining. Addison Wesley. ISBN: 0321321367

Dean Attali’s Shiny Tutorial:
<https://deanattali.com/blog/building-shiny-apps-tutorial/>
