##################################################
# ECON 418-518 Exam 3
# Roderick Featherstone
# The University of Arizona
# rsfeathers@arizona.edu 
# 08 December 2024
###################################################


#####################
# Preliminaries
#####################

# Clear environment, console, and plot pane
rm(list = ls())
cat("\014")
graphics.off()

# Install pacman
if (!require(pacman)) install.packages("pacman")

# Load packages
pacman::p_load(data.table, plm, ggplot2, gridExtra)

#Set working directory
setwd("/Users/roddy/Desktop/CODING/DATA_FILES")

#Get the workiing directory
getwd()

# Load the data set into a data table
data <- data.table(read.csv("ECON_418-518_Exam_3_Data.csv"))

#Visualize data
data

#################################
# Difference-in-Differences Model
#################################

# Create indicator columns in the data.table format
data[, `:=`(
  Nov = ifelse(time_period == "Nov", 1, 0),
  NJ = ifelse(state == 1, 1, 0)
)]

#Show results
data

# Mean total employment in New Jersey (state = 1)
mean_NJ <- data[state == 1, mean(total_emp)]

# Mean total employment in Pennsylvania (state = 0)
mean_PA <- data[state == 0, mean(total_emp)]

#Show results
mean_NJ
mean_PA

# Compute mean total employment for each group
mean_NJ_pre <- data[NJ == 1 & Nov == 0, mean(total_emp)]
mean_NJ_post <- data[NJ == 1 & Nov == 1, mean(total_emp)]
mean_PA_post <- data[NJ == 0 & Nov == 1, mean(total_emp)]
mean_PA_pre <- data[NJ == 0 & Nov == 0, mean(total_emp)]

#Show results
mean_NJ_pre 
mean_NJ_post 
mean_PA_pre 
mean_PA_post


# Compute the differences within each state

# Change in New Jersey
diff_NJ <- mean_NJ_post - mean_NJ_pre

# Change in Pennsylvania
diff_PA <- mean_PA_post - mean_PA_pre

#Show results
diff_NJ
diff_PA

# Compute the Difference-in-Differences (DiD) estimate
DiD_estimate <- diff_NJ - diff_PA

#Show results
DiD_estimate

#Provide a visual representation
ggplot() +
  
  # Actual NJ and PA lines
  geom_line(data = data_for_plot, aes(x = time, y = mean_emp, group = state, color = state),
            linewidth = 1.2) +
  geom_point(data = data_for_plot, aes(x = time, y = mean_emp, color = state), size = 3) +
  
  # Counterfactual line for NJ (dashed)
  geom_line(data = counterfactual_line, aes(x = time, y = mean_emp),
            linetype = "dashed", color = "red", linewidth = 1.2) +
  
  # Vertical line to indicate the intervention point between Pre and Post
  geom_vline(xintercept = 0.5, linetype = "solid", color = "black") +
  
  # Customize x-axis labels
  scale_x_continuous(breaks = c(0, 1),
                     labels = c("Pre Intervention", "Post Intervention")) +
  
  labs(title = "Difference-in-Differences Illustration",
       x = "Time",
       y = "Average Employment") +
  
  theme_minimal() +
  theme(
    text = element_text(size = 14),
    plot.title = element_text(hjust = 0.5)
  )

# Estimate the DiD model using lm()
DiD_model <- lm(total_emp ~ NJ + Nov + I(NJ*Nov), data = data)

# Summarize the results
summary(DiD_model)

#Construct Confidence Interval 95% of the whole model 
conf_int_95 <- confint(DiD_model, level = 0.95)

#View confidence Intervals
conf_int_95

#Get the confidence interval for just the interaction term 
conf_int_95_IT <- conf_int_95[4, ]

#Show the confidence interval for the interaction term
conf_int_95_IT

# Estimate the DiD model with restaurant fixed effects using lm()
DiD_model_fixed <- lm(total_emp ~ NJ + Nov + I(NJ*Nov) + factor(restaurant_id), data = data)

# Summarize the results
summary(DiD_model_fixed)
