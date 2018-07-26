---
title: "Kick-off Meeting"
author: "Janani Ravi | jananiravi@rladies.org"
date: July 25, 2018
output:
  ioslides_presentation:
    css: shiny-slides.css
    logo: ../logos-qrcode/RLadiesEastLansing-sqbig.png
    self_contained: no
    incremental: true
    widescreen: true
---
# Converting xaringan to PDF
```{r echo=FALSE}
    library(webshot) # install.packages("webshot")
    # install_phantomjs()
    file_name <- paste0("file://", normalizePath("20180725-Kickoff-meeting.html"))
    
    webshot(file_name, "20180725-Kickoff-meeting.pdf")
```
# Inserting an image
```{r, out.width = "600px", echo=FALSE}
knitr::include_graphics("../logos-qrcode/rshinylady-stats-map.png")
```

# Unused xaringan
```
output:
	xaringan::moon_reader:
	css: ["default", "rladies", "rladies-fonts"]
logo: ../logos-qrcode/RLadiesEastLansing-sqbig.png
lib_dir: libs
nature:
	highlightStyle: github
highlightLines: true
countIncrementalSlides: false
includes:
	in_header: header.html
```

# using background image
```
background-image: url("https://github.com/rladies-eastlansing/meetup-presentations_east-lansing/blob/master/images/background_rladies-eastlansing.png?raw=true")
background-position: 0% 0%
```
# Xaringan my-theme.css
```
.title-slide {
	background-image: url("https://github.com/rladies-eastlansing/meetup-presentations_east-lansing/blob/master/images/background_rladies-eastlansing.png?raw=true");
	background-size: cover;
```
}
###################################

# Who we are: R-Ladies
**World-wide organization** <br>
that promotes *gender diversity* in the **R community**  <br>
via *meetups*, *mentorship*  <br>
in a *friendly* and *safe* environment!


# How-to-R
## Cooking or coding?

```{r tweet-r-codinglikecooking, out.width = "400px", echo=FALSE}
knitr::include_graphics("../images/tweet-r-codinglikecooking.png")
```

```{r r-codinglikecooking, out.width = "400px", echo=FALSE}
knitr::include_graphics("../images/r-codinglikecooking.png")
```

<i class="fa fa-twitter fa-fw"></i>Credits: @SonyaEisenbeiss , @compbiologist

---
class: center
# How-to-R

.pull-left[
```{r r-gettinghelp, out.width = "500px", echo=FALSE}
knitr::include_graphics("../images/r-gettinghelp.png")
```

```{r r-community-obsession, out.width = "300px", echo=FALSE}
knitr::include_graphics("../images/tweet-r-community-obsession.png")
```
]

.pull-right[
```{r r-datascience-books, out.width = "300px", echo=FALSE}
knitr::include_graphics("../images/r-datascience-books.png")
```
]

<i class="fa fa-twitter fa-fw"></i>Credits: @DynamicWebPaige | @compbiologist

---
class: center
# How-to-R

### How we _most often_ use R
```{r flowchart-datascience, out.width = "350px", echo=FALSE}
knitr::include_graphics("../images/flowchart-datascience.png")
```
--

### R ecosystem

```{r r-ecosystem-arjun, out.width = "350px", echo=FALSE}
knitr::include_graphics("../images/r-ecosystem-arjun.png")
```

<i class="fa fa-twitter fa-fw"></i>Credits: @StatGarrett @compbiologist

---
class: center

```{r rladies-user2017, out.width = "200px", echo=FALSE}
knitr::include_graphics("../rladies-photos/2017-useR.jpg")
```



---
	class: center
# R for DataViz
.pull-left[.left[
	```{r rgraphgallery-logo, out.width = "100px", echo=FALSE}
	knitr::include_graphics("../images/rgraphgallery-logo.png")
	```
	```{r rgraphgallery, out.width = "500px", echo=FALSE}
	knitr::include_graphics("../images/rgraphgallery.png")
	```
	
	]]

.pull-right[.left[
	```{r datatoviz-logo, out.width = "100px", echo=FALSE}
	knitr::include_graphics("../images/datatoviz-logo.png")
	```
	```{r datatoviz-poster, out.width = "500px", echo=FALSE}
	knitr::include_graphics("../images/datatoviz-poster.png")
	```
	]]

---
	class: center
# R for DataViz

```{r datatoviz-violin, out.width = "350px", echo=FALSE}
knitr::include_graphics("../images/datatoviz-violinplot.png")
```
