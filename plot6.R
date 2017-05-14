#plot6.r
#Author: Jennifer Campbell
#eda week 4, project 2
#address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot

##Question 6:
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
#has seen greater changes over time in motor vehicle emissions?

####

#Step 0: Download Data
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile='emissions_data',method=dlMethod,mode="wb")
#unzip(zipfile = "emissions_data.zip")

#Step 1: Read in Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Step 2: Subset Data to Motor Vehicle Sources
mv <- grep("Highway Veh", SCC$Short.Name)
mvsccs <- SCC$SCC[mv]
mvdat <- NEI[NEI$SCC %in% mvsccs,]

#Step 3: Subset Data to Baltimore
baltmvdat <- mvdat[mvdat$fips == "24510",]

#Step 4: Subset Data to Los Angeles County
lacmvdat <- mvdat[mvdat$fips == "06037",]

#Step 5: Aggregate the Emissions data by Year
baltmvbyyear <- aggregate(Emissions ~ year, baltmvdat, FUN = "sum")
lacmvbyyear <- aggregate(Emissions ~ year, lacmvdat, FUN = "sum")

#Step 6: Plot the Total Emissions by Year
plotfile <- png("plot6.png", width = 480, height = 480)
par(mfrow=c(1,2), mar= c(4,2,2,1), oma= c(0,3,2,0))
  
  #Create plot 1 (Baltimore)
  barplot(baltmvbyyear$Emissions, names = baltmvbyyear$year, ylim = c(0,4600), xlab = "Year", 
          ylab = "", main = "Baltimore City")
  
  #Create plot 2 (LA County)
  barplot(lacmvbyyear$Emissions, names = lacmvbyyear$year, ylim = c(0,4600), xlab = "Year", 
          ylab = "", main = "Los Angeles County")

  title(main = "Comparison of Emissions from Motor Vehicle Sources", outer=TRUE)
  title(ylab = "Total PM2.5 Emissions from Motor Vehicle Sources", outer=TRUE, line=1)
  
dev.off()

