# base levels

    Code
      get_base_levels("locations", .progress = FALSE)
    Output
      # A tibble: 298 x 6
            id name                iso3  iso2  longitude latitude
         <int> <chr>               <chr> <chr>     <dbl>    <dbl>
       1     4 Afghanistan         AFG   AF        67.7      33.9
       2     8 Albania             ALB   AL        20.2      41.2
       3    12 Algeria             DZA   DZ         1.66     28.0
       4    16 American Samoa      ASM   AS      -171.      -14.3
       5    20 Andorra             AND   AD         1.52     42.5
       6    24 Angola              AGO   AO        17.9     -11.2
       7    28 Antigua and Barbuda ATG   AG       -61.8      17.1
       8    31 Azerbaijan          AZE   AZ        47.6      40.1
       9    32 Argentina           ARG   AR       -63.6     -38.4
      10    36 Australia           AUS   AU       134.      -25.3
      # i 288 more rows

---

    Code
      get_base_levels("Indicators", .progress = FALSE)
    Output
      # A tibble: 64 x 33
            id name         shortName description displayName dimAge dimSex dimVariant
         <int> <chr>        <chr>     <chr>       <chr>       <lgl>  <lgl>  <lgl>     
       1     1 Contracepti~ CPAnyP    Percentage~ Any         FALSE  FALSE  TRUE      
       2     2 Contracepti~ CPModP    Percentage~ CP Modern   FALSE  FALSE  TRUE      
       3     3 Contracepti~ CPTrad    Percentage~ CP Traditi~ FALSE  FALSE  TRUE      
       4     4 Unmet need ~ UNMP      Percentage~ Unmet need  FALSE  FALSE  TRUE      
       5     5 Unmet need ~ UNMModP   Percentage~ Unmet need~ FALSE  FALSE  TRUE      
       6     6 Total deman~ DEMTot    Percentage~ Total dema~ FALSE  FALSE  TRUE      
       7     7 Demand for ~ DEMAny    Percentage~ Demand sat~ FALSE  FALSE  TRUE      
       8     8 Demand for ~ DEMMod    Percentage~ Demand sat~ FALSE  FALSE  TRUE      
       9     9 Contracepti~ CPAnyN    Number of ~ Contracept~ FALSE  FALSE  TRUE      
      10    10 Contracepti~ CPModN    Number of ~ Users of m~ FALSE  FALSE  TRUE      
      # i 54 more rows
      # i 25 more variables: dimCategory <lgl>, defaultAgeId <int>,
      #   defaultSexId <int>, defaultVariantId <int>, defaultCategoryId <int>,
      #   variableType <chr>, valueType <chr>, unitScaling <dbl>, precision <int>,
      #   isThousandSeparatorSpace <lgl>, formatString <chr>, unitShortLabel <chr>,
      #   unitLongLabel <chr>, nClassesDefault <int>, downloadFileName <chr>,
      #   sourceId <int>, sourceName <chr>, sourceYear <int>, ...

