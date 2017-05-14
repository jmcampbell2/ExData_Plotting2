#plot2.r
#Author: Jennifer Campbell
#eda week 4, project 2
#address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot

##Question 2:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

####

#Step 0: Download Data
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile='emissions_data',method=dlMethod,mode="wb")
#unzip(zipfile = "emissions_data.zip")

#Step 1: Read in Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Step 2: Subset Data to Baltimore
baltdat <- NEI[NEI$fips == "24510",]

#Step 3: Aggregate the Emissions data by Year
baltbyyear <- aggregate(Emissions ~ year, baltdat, FUN = "sum")

#Step 4: Plot the Total Emissions by Year
plotfile <- png("plot2.png", width = 480, height = 480)
barplot(baltbyyear$Emissions, names = baltbyyear$year, xlab = "Year",
        ylab = "Total PM2.5 Emissions", main = "Baltimore PM2.5 Emissions (All Sources)")
dev.off()

