---
output: html_document
---
###README
This is a program designed to plot microbial growth readings over time and calculate the estimated rate of growth based on data provided by the user.  It consists of three functions: readData reads in the data and stores it as a table, plotData gives a visual representation of the data as a dot plot, and analyzeData plots the data in a logarithmic graph to estimate the rate of growth during the organism's exponential growth phase.  The instructions for using the program will be shown below using two sample datasets: "Sample OD Readings.txt" and "Sample OD Readings.txt 2".

The priority of the program is to provide a quick, user-friendly set of functions that sacrifices some customization options for ease of use.  The functions are straightforward and intuitive, as the user is guided through each step by a set of user input prompts.

Before using the program, please set the working directory to where the program data, this README file, and the sample datasets are stored by either using the RStudio menu or the setwd() function.

Upon setting the working directory, confirm that the R script  ("Project 2.R") and sample datasets are present in the directory and load the R script to gain access to the functions.


```r
source("Project 2.R")
```

The tutorial below demonstrates how to use the program wth two different data sets to show the differences in features between using datasets with a single sample and datasets with more than one sample.

####1. Reading in your data (readData)

The readData function is designed to read in text files (.txt) with the data arranged in columns.  The first column must be units of time, while the subsequent columns must be growth values for a different sample in each column.  Each value in a row can be separated by any particular character, as long as it is consistent.  If you open either sample dataset, you can see an example of this.

When you apply the function to a dataset, you will be prompted to indicate the separator that separates each row value.  Upon typing the separator and pressing enter, you will then be asked if there is a header in the file, to which you can input "y" or "n".

The sample datasets use "|" as the separator and both also contain headers.  When prompted, "|" and "y" are inputted as such, after which the data will successfully be read in as a table.  Note that whenever the program asks for an input, omit the quotation marks.  

Be sure to store each dataset you use in a vector because they will be necessary for running the other two functions.


```r
data1<-readData("Sample OD Readings.txt")
print(data1)
```
```
## Please enter the character used to separate values: |
## Is the first row a header? (y/n): y
```

```
##    Hours Absorbance.1
## 1      0        0.001
## 2      2        0.009
## 3      4        0.019
## 4      6        0.035
## 5      8        0.048
## 6     10        0.095
## 7     12        0.142
## 8     14        0.197
## 9     16        0.253
## 10    18        0.278
## 11    20        0.295
## 12    22        0.314
## 13    24        0.329
## 14    26        0.340
## 15    28        0.347
```

```r
data2<-readData("Sample OD Readings 2.txt")
print(data2)
```
```
## Please enter the character used to separate values: |
## Is the first row a header? (y/n): y
```

```
##    Hours Absorbance.1 Absorbance.2
## 1      0        0.001        0.002
## 2      2        0.009        0.008
## 3      4        0.019        0.015
## 4      6        0.035        0.038
## 5      8        0.048        0.051
## 6     10        0.095        0.082
## 7     12        0.142        0.120
## 8     14        0.197        0.169
## 9     16        0.253        0.198
## 10    18        0.278        0.235
## 11    20        0.295        0.261
## 12    22        0.314        0.284
## 13    24        0.329        0.309
## 14    26        0.340        0.315
## 15    28        0.347        0.322
```

####2. Plotting a graph (plotData)

The plotData function simply plots a dot plot reflecting growth against time for visualization purposes.  Like with the previous function, you will be prompted for a number of inputs.  When all the necessary information has been inputted, the plot will be generated automatically.  If you have multiple samples in your dataset, there will be extra inputs requested for distinguishing between each sample via color, and a legend is automatically displayed at the desired region of the plot (communicated by left-clicking the desired location on the generated plot when the function prompts you).

The output of the readData function must be used as the input for the plotData function.


```r
plotData(data1)
```
```
## Please enter the x-axis label: Hours
## Please enter the y-axis label: OD600 Absorbance
## Please enter the title of the plot: OD600 Absorbance Readings of D. piger
## Plot generated.
```
![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 

```r
plotData(data2)
```
```
## Please enter the x-axis label: Hours
## Please enter the y-axis label: OD600 Absorbance
## Please enter the title of the plot: OD600 Absorbance Readings of D. piger
## Sample 1
## Please enter a name for this sample: DP1-1
## What color would you like to use to represent this sample?: green
## Sample 2
## Please enter a name for this sample: DP1-2
## What color would you like to use to represent this sample?: red
## Please indicate where to place the legend by clicking the plot at the desired point.
## Plot generated.
```
![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 

####3. Analyzing growth data (analyzeData)

The analyzeData function also uses the output of the readData function as the input.  This function generates a logarithmic plot of the growth rate in order to perform a linear regression and estimate the rate of growth at the organism's exponential growth phase.  

In addition to the standard graph labels, the user will also be prompted to input the two points that seem to mark the beginning and end of the straightest section of the logarithmic plot.  The function will then perform a linear regression to draw a line of best fit and output the equation of the line.  The final output will then be an estimate of the growth rate of the organism, which would be equal to the slope of the line of best fit.

This function can only be performed with a dataset of a single sample; datasets with multiple samples will only result in an error.

When inputting the data points marking the beginning and end of the straight section of the plot, the data points are recognized by the order that they were listed in the dataset.  The input is NOT an x or y value on the plot.


```r
analyzeData(data1)
```
```
## Please enter the x-axis label: Hours
## Please enter the y-axis label: OD600 Absorbance (log)
## Please enter the title of the plot: OD600 Absorbance Readings of D. piger
## Please enter the point signifying the approximate beginning of the linear portion of the curve: 2
## Please enter the point signifying the approximate end of the linear portion of the curve: 6
## The equation of the line of best fit is: y = 0.2820033 x + -5.175357 .
## The growth rate of the organism during its exponential growth phase is 0.2820033 .
```
![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 

This concludes the user tutorial.  Have a nice day!
