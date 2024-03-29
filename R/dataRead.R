## dataRead ##
dataRead <- function(dataFrame, timing, streams, VoI = NA, type="long", median0 = NA, delta = 3){
  if(missing(timing) == TRUE){
    stop("Input dataframe needs timing variable")
  }
  if(missing(streams) == TRUE){
    stop("Input dataframe needs stream identifier variable")
  }

  if(type=="wide"){
    message("Data is wide")
    #for(i in 1:length(streams)){
    #  if(length(streams[[i]])!=length(streams[[1]])){
    #    stop("Input dataframe needs equal sample count")
    #  }
    #}
    dataFrame <- pivot_longer(dataFrame, cols = streams, names_to = "streams", values_to = "VoI")
    ## Do conversion
    colnames(dataFrame) <- c("timing", "streams", "VoI")
  }

  if(type=="long"){
  names(dataFrame)[names(dataFrame) == timing] <- "timing"
  names(dataFrame)[names(dataFrame) == streams] <- "streams"
  names(dataFrame)[names(dataFrame) == VoI] <- "VoI"
  }


  ifelse(dataFrame$streams == "", stop("Input stream variable has missing values"), NA)
  ifelse(is.numeric(dataFrame$timing), NA, stop("Input time variable is non-numeric"))
  ifelse(is.na(dataFrame$timing), stop("Input time variable has missing values"), NA)
  ifelse(is.numeric(dataFrame$VoI), NA, stop("Input variable of interest is non-numeric"))
  ifelse(is.na(dataFrame$VoI), stop("Input variable of interest has missing values"), NA)

  if(length(dataFrame[[1]])%%length(unique(dataFrame$timing))!=0){
    stop("Input dataframe needs equal sample count")
  }else
  if(length(dataFrame[[1]])%%length(unique(dataFrame$streams))!=0){
    stop("Input dataframe needs equal sample count")
  }
  if(is.na(median0) == TRUE){
    stop("Target median is missing")
  }
  if(is.numeric(median0) != TRUE){
    stop("Inputted target median is non-numeric")
  }
  if(median0 < 0){
    stop("Please input a target median greater than 0")
  }
  if(median0 > 1){
    stop("Please input a target median less than 1")
  }
  if(is.numeric(delta) != TRUE){
    stop("Inputted target delta is non-numeric")
  }

  x <- dataFrame
  return(x)


}

dataRead(x, timing="hour", streams=c("rep1", "rep2", "rep3", "rep4", "rep5", "rep6", "rep7", "rep8", "rep9", "rep10"), type="wide", median0 = .8)
