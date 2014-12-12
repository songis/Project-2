#Reads in the growth curve data as a table
readData<-function(file){
  
  #Prompts user to enter separator
  separator.function<-function(){
    as.character(readline("Please enter the character used to separate values: "))
  }
  
  #Prompts user to confirm/deny header
  header.function<-function(){
    as.character(readline("Is the first row a header? (y/n): "))
  }
  
  #Stores user inputs as separator and header variables
  separator<-separator.function()
  header.variable<-header.function()
  
  #Stores data depending on if there is a header or not
  if(header.variable=="y"){
    data<-read.table(file,header=TRUE,sep=separator)
    return(data)
  } else if(header.variable=="n"){
    data<-read.table(file,header=FALSE,sep=separator)
    return(data)
    #Returns an error if there is a problem with the user input
  } else{
    cat("ERROR: Please try again.")
  }
}

#Plots growth curve data
plotData<-function(file.table){
  
  #Prompts user to enter x-axis label
  xaxis.function<-function(){
    as.character(readline("Please enter the x-axis label: "))
  }
  
  #Prompts user to enter y-axis label
  yaxis.function<-function(){
    as.character(readline("Please enter the y-axis label: "))
  }
  
  #Prompts user to enter plot title
  title.function<-function(){
    as.character(readline("Please enter the title of the plot: "))
  }
  
  #Stores user inputs as variables
  xaxis<-xaxis.function()
  yaxis<-yaxis.function()
  title<-title.function()
  
  #Produces a plot based on data from readData and user inputs
  plot(file.table,xlab=xaxis,ylab=yaxis,main=title)
}

#Produces a logarithmic plot and analyzes the slope of the linear portion of the curve to determine doubling time
analyzeData<-function(file.table){
  
  #Prompts user to enter x-axis label
  xaxis.function<-function(){
    as.character(readline("Please enter the x-axis label: "))
  }
  
  #Prompts user to enter y-axis label
  yaxis.function<-function(){
    as.character(readline("Please enter the y-axis label: "))
  }
  
  #Prompts user to enter plot title
  title.function<-function(){
    as.character(readline("Please enter the title of the plot: "))
  }
  
  #Stores user inputs as variables
  xaxis<-xaxis.function()
  yaxis<-yaxis.function()
  title<-title.function()
  
  #Plots log graph
  plot(file.table[,1],log(file.table[,2]),xlab=xaxis,ylab=yaxis,main=title)
  
  #Prompts user to input start point of linear portion
  start.function<-function(){
    as.numeric(readline("Please enter the point signifying the approximate beginning of the linear portion of the curve: "))
  }
  
  #Prompts user to input end point of linear portion
  end.function<-function(){
    as.numeric(readline("Please enter the point signifying the approximate end of the linear portion of the curve: "))
  } 
  
  #Stores user inputs as variables
  start<-start.function()
  end<-end.function()
  
  #Performs a linear regression to find line of best fit between the user-inputted points
  line<-lm(log(file.table[start:end,2])~file.table[start:end,1])
  
  #Draws line of best fit on log graph
  abline(line)
  
  #Stores the slope and y-intercept calculated in linear regression as variables
  slope<-line$coefficients[2]
  yint<-line$coefficients[1]
  
  #Displays the equation of the line of best fit using linear regression data
  cat("The equation of the line of best fit is: y =",slope,"x +",yint,".")
}

