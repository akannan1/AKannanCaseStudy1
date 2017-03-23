##Downloading GDP

if (!file.exists("data")){
  dir.create("data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL,destfile="C:/Users/user/Desktop/gdp.csv", method='curl')
gdp <- read.csv("C:/Users/user/Desktop/gdp.csv",skip=5,header=FALSE,nrows=200)

##Column Names
colnames(gdp)[1]="CountryCode"
colnames(gdp)[5]="gdp"
gdp$gdp <- as.numeric(gsub(",","",gdp$gdp))

##Download Education File
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileURL,destfile="C:/Users/user/Desktop/gdp.csv", method='curl')
dateDownloaded <- date()
education <- read.csv("C:/Users/user/Desktop/Education.csv",header=TRUE)

##Merge/Sort/Quantile Data
FullData <- merge(gdp,education,by="CountryCode")
FullDataSorted <- FullData[order(FullData$gdp,na.last=NA),]
FullData$quantile <- cut(FullDataSorted$V2,5)
FullDataFinalTable <- table(FullDataSorted$quantile,FullDataSorted$Income.Group)