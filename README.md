
# cytofan

[![R-CMD-check](https://github.com/yannabraham/cytofan/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yannabraham/cytofan/actions/workflows/R-CMD-check.yaml)
[![CRAN_Release_Badge](http://www.r-pkg.org/badges/version-ago/cytofan)](https://CRAN.R-project.org/package=cytofan)
[![CRAN_Download_Badge](http://cranlogs.r-pkg.org/badges/cytofan)](https://CRAN.R-project.org/package=cytofan)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3557320.svg)](https://doi.org/10.5281/zenodo.3557320)

`cytofan` implements the concept of fan plots ([Britton, E.; Fisher, P.
& J. Whitley (1998) The Inflation Report Projections: Understanding the
Fan
Chart](https://www.bankofengland.co.uk/quarterly-bulletin/1998/q1/the-inflation-report-projections-understanding-the-fan-chart))
for cytometry data in ggplot2.

The `cytofan` package was implemented following up on a
[gist](https://gist.github.com/yannabraham/6f8474ab32e8eec63c2e) written
shortly after the
[fanplot](https://cran.r-project.org/web/packages/fanplot/index.html)
package was released. Compared to
[ggfan](https://cran.r-project.org/web/packages/ggfan/index.html),
`cytofan` uses categorical data as input on the x axis.

## Installation

You can install cytofan from github with:

``` r
# install.packages("devtools")
devtools::install_github("yannabraham/cytofan")
```

## Example

`cytofan` can be used to visualize differences between populations
identifed using [mass
cytometry](http://www.nature.com/nbt/journal/v30/n9/full/nbt.2317.html):

``` r
library(cytofan)
#> Loading required package: ggplot2
library(bodenmiller)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(tidyr)

data("refPhenoMat")
data("refAnnots")

bind_cols(refAnnots,
          as.data.frame(refPhenoMat)) %>%
  filter(Cells %in% c('cd4+','cd8+','igm+','igm-')) %>%
  gather("Channel","value",
         any_of(colnames(refPhenoMat))) %>%
  ggplot(aes(x=Channel,y=value))+
  geom_fan()+
  facet_grid(Cells~.)
```

![](man/figures/README-example-1.png)<!-- -->
