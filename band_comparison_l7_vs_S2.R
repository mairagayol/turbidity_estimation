######### Band Comparison ###############
#Set working directory
setwd("D:/posdoc/865/L7_vs_S2")

#Landsat 7-ETM+ vs Sentinel 2-MSI
#Load libraries
library(raster)
library(dplyr)
library(sp)
library(rgdal)
library(ggplot2)
library(rgeos)
library(maptools)
library(readr)

#Have stacks for images from both satellites for the same date (b1 Landsat 7, b2 Sentinel 2)
#Get the list of file names for the stacks
stack_files <- list.files("D:/posdoc/865/L7_vs_S2/comparar/stack", pattern = ".tif$", full.names = TRUE)

######## Extraction of Pixel Values ########
#Function to extract pixel values from a stack and save them in a CSV file
extract_pixel_values <- function(stack_file) {
  
  #Read the stack
  stack <- stack(stack_file)
  
  #Obtain the date from the file name (assuming the first 6 characters represent the date)
  date <- substr(basename(stack_file), 7, 14) # Adjust this based on the date format in the file name
  
  #Extract pixel values for each band and save them in a data frame
  values <- data.frame(L7 = getValues(stack[[1]]), S2 = getValues(stack[[2]]))
  
  #Output CSV file name
  csv_file_name <- paste0("pixel_values_", date, ".csv")
  
  #Save pixel values to a CSV file
  write.csv(values, csv_file_name, row.names = FALSE)
  
  #Confirmation message
  cat("Pixel values extracted and saved in", csv_file_name, "\n")
}

#Apply the function to each stack
lapply(stack_files, extract_pixel_values)

#Get the list of generated CSV files
csv_files <- list.files("D:/posdoc/865/L7_vs_S2", pattern = ".csv", full.names = TRUE)

#Read and join CSV files into a single data frame
complete_data <- bind_rows(lapply(csv_files, read.csv))

#Remove rows containing NA
clean_data <- na.omit(complete_data)

#Save the NA-free data frame to a CSV file
write.csv(clean_data, "final_file.csv", row.names = FALSE)

############ Scatterplot ############

final_file <- read.csv("D:/posdoc/865/L7_vs_S2/final_file.csv", sep=",")

data = final_file
x_band = data$L7 # Read the band for the X-axis
y_band = data$S2 # Read the band for the Y-axis
bins = 150

ggplot(data, aes(x = x_band, y = y_band)) +
  geom_bin2d(bins = bins) +
  theme_classic() +
  labs(x = "ρw(865) Landsat 7-ETM+", y = "ρw(865) Sentinel 2-MSI") +
  scale_fill_continuous(type = "viridis", limits = c(0, 8000), breaks = c(0, 2000, 4000, 6000, 8000)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dotted") +
  theme(panel.background = element_blank(),
        panel.border = element_rect(fill = NA),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.background = element_blank(),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        plot.margin = unit(c(1, 1, 1, 1), "line"),
        text = element_text(size = 10)) +
  geom_smooth(method = lm, se = FALSE, linetype = "dashed", color = "red", size = 1) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 0.155)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.155)) +
  guides(fill = guide_colourbar(barwidth = 0.5, barheight = 6, title = "Count"))

ggsave(file = "scatterplot_landsat7_vs_sentinel2.eps", width = 100, height = 80, units = "mm")