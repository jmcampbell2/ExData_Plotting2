#plot4.r
#Author: Jennifer Campbell
#eda week 4, project 2
#address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot

##Question 4:
#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999-2008?

####

#Step 0: Download Data
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile='emissions_data',method=dlMethod,mode="wb")
#unzip(zipfile = "emissions_data.zip")

#Step 1: Read in Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Step 2: Subset Data to Coal Combustion-Related Sources
coal <- grep("Coal", SCC$Short.Name)
coalsccs <- SCC$SCC[coal]
coaldat <- NEI[NEI$SCC %in% coalsccs,]

#Step 3: Aggregate the Emissions data by Year
coalbyyear <- aggregate(Emissions ~ year, coaldat, FUN = "sum")

#Step 4: Plot the Total Emissions by Year
plotfile <- png("plot4.png", width = 480, height = 480)
barplot(coalbyyear$Emissions, names = coalbyyear$year, xlab = "Year", ylab = "Total PM2.5 Emissions",
        main = "US PM2.5 Emissions from Coal Combustion-Related Sources")
dev.off()

