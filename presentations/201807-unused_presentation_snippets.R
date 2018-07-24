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

# Who we are: R-Ladies
**World-wide organization** <br>
that promotes *gender diversity* in the **R community**  <br>
via *meetups*, *mentorship*  <br>
in a *friendly* and *safe* environment!

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
