#Pull 
library(move)
library(tidyverse)
library(lubridate)

noct <- getMovebankData(study = "Nyctalus lasiopterus noctulo mayor Donana", login = loginTO)
plot(noct)
noct$segment_speed <- unlist(lapply(speed(noct), c, NA))
noct$timeLag <- unlist(lapply(timeLag(noct, units = "secs"), c, NA))
moveList <- lapply(split(noct), function(myInd){
  datechange <- c(0, abs(diff(as.numeric(as.factor(date(myInd@timestamps-(12*60*60)))))))
  myInd$batDay <- cumsum(datechange)+1
  return(myInd)
})
noct <- moveStack(moveList, forceTz="UTC")

