#plot5.r
#Author: Jennifer Campbell
#eda week 4, project 2
#address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot

##Question 5:
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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

#Step 4: Aggregate the Emissions data by Year
baltmvbyyear <- aggregate(Emissions ~ year, baltmvdat, FUN = "sum")

#Step 5: Plot the Total Emissions by Year
plotfile <- png("plot5.png", width = 480, height = 480)
barplot(baltmvbyyear$Emissions, names = baltmvbyyear$year, xlab = "Year", 
        ylab = "Total PM2.5 Emissions",
        main = "Baltimore PM2.5 Emissions from Motor Vehicle Sources")
dev.off()

