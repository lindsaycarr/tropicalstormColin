# visualize the discharge data

visualizeDischarge <- function(dateTime,flow,title,sub="")
{
  plot(x=dateTime,y=flow, type="l", col="blue",main=title, sub=sub,
       xlab = "Date and Time", ylab = "Discharge (cfs)",lwd=6)
  
}