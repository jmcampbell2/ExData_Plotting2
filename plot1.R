#plot1.r
#Author: Jennifer Campbell
#eda week 4, project 2
#address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot

##Question 1:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#sources for each of the years 1999, 2002, 2005, and 2008

####

#Step 0: Download Data
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile='emissions_data',method=dlMethod,mode="wb")
unzip(zipfile = "emissions_data.zip")

#Step 1: Read in Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggregate the Emissions data by Year
byyear <- aggregate(Emissions ~ year, NEI, FUN = "sum")

#Plot the Total Emissions by Year
plotfile <- png("plot1.png", width = 480, height = 480)
barplot(byyear$Emissions, names = byyear$year, xlab = "Year",
          ylab = "Total PM2.5 Emissions",main = "Total US PM2.5 Emissions (All Sources)")
dev.off()

