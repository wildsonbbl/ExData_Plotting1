library(data.table)
library(dplyr)

datas <- fread(file = './household_power_consumption.txt')

datas$Date <- as.Date(datas$Date,format = "%d/%m/%Y")

minhasdatas <- as.Date(x = c('2007-02-01','2007-02-02'),format = "%Y-%m-%d")

selecionados <- datas[datas$Date %in% minhasdatas]

selecionados <- selecionados %>%
  mutate(Time = strptime(x = paste(Date,Time),format = '%F %T'))

selecionados[,3:9] <- selecionados %>% 
  select(3:9) %>%
  mutate_each(funs = as.numeric)

png(filename = './plot1.png',width = 480,height = 480,units = 'px')

hist(x = selecionados$Global_active_power,
     col = 'red',main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')
dev.off()

