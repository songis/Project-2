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
    if(ncol(data)==1){
      cat("WARNING: This data format is not compatible with this program.")
    } 
    else{
      return(data)
    }
  } 
  else if(header.variable=="n"){
    data<-read.table(file,header=FALSE,sep=separator)
    if(ncol(data)==1){
      cat("WARNING: This data format is not compatible with this program.")
    } 
    else{
      return(data)
    }
  }  
    #Returns an error if there is a problem with the user input
  else{
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
  
  #Stores user inputs as vectors
  xaxis<-xaxis.function()
  yaxis<-yaxis.function()
  title<-title.function()
  
  #Produces a plot based on data from readData and user inputs, assuming there is only one sample
  if(ncol(file.table)==2){
    plot(file.table,xlab=xaxis,ylab=yaxis,main=title,pch=16)
  } 
  
  #Produces a plot accordingly based on number of samples in data and user inputs
  else if(ncol(file.table)>=2){
    
    #Declares vectors for user-inputted names and colors for use later in the legend
    sample.names<-as.character()
    sample.colors<-as.character()
      
    for(i in 2:ncol(file.table)){
      
      #Prompts user to give the sample a name and stores it
      cat("Sample:",i-1)
      name.function<-function(){
        as.character(readline("Please enter a name for this sample: "))
      } 
      sample.name<-name.function()
        
      #Prompts user to select a color to use for the sample in the plot
      color.function<-function(){
        as.character(readline("What color would you like to use to represent this sample?: "))
      }
      sample.color<-color.function()
      
      #Stores sample names and colors in vectors
      sample.names<-append(sample.names,sample.name)
      sample.colors<-append(sample.colors,sample.color)
    
      #Plots data for sample 1 and plots the rest of the samples' points on it afterward
      if(i==2){
        plot(file.table[,1]~file.table[,i],xlab=xaxis,ylab=yaxis,main=title,col=sample.color,pch=16) 
      } 
      else{
        points(file.table[,1]~file.table[,i],col=sample.color,pch=16)
        if(i==ncol(file.table)){
        }
      }
    }
    
    #Creates a legend based on user-specified location
    cat("Please indicate where to place the legend by clicking the plot at the desired point.")
    location<-locator(1)
    legend(location,legend=(sample.names),col=(sample.colors),pch=16)
  }
}

#Produces a logarithmic plot and analyzes the slope of the linear portion of the curve to determine doubling time
analyzeData<-function(file.table){
  
  if(ncol(file.table)>2){
    cat("ERROR: This function can only be used for a single sample.")
  } 
  else if (ncol(file.table)==2){
    
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
    
    #Displays the equation of the line of best fit using linear regression data and the rate of growth in the exponential phase
    cat("The equation of the line of best fit is: y =",slope,"x +",yint,".")
    cat("\n","The growth rate of the organism during its exponential growth phase is",slope,".")
  }
}

