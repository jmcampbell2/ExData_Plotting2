#plot3.r
#Author: Jennifer Campbell
#eda week 4, project 2
#address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot

##Question 3:
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
#Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
#plotting system to make a plot answer this question.

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
baltbyyear <- aggregate(Emissions ~ year + type, baltdat, FUN = "sum")


#Step 4: Plot the Total Emissions by Year
plotfile <- png("plot3.png", width = 480, height = 480)
g <- ggplot(baltbyyear, aes(x = year, y = Emissions, ymin=0, ymax=2500)) + geom_bar(stat="identity")
print(g + facet_grid(.~type, margins=TRUE) + labs(x = "Year", y = "Total PM2.5 Emissions", 
                                            title = "Baltimore PM2.5 Emissions By Sources"))
dev.off()

