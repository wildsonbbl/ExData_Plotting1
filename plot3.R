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

png(filename = './plot3.png',width = 480,height = 480,units = 'px')

with(selecionados,plot(Time,y =  Sub_metering_1,
                       type = 'n',
                       ylab = 'Energy sub metering',xlab = ''))
with(selecionados,points(Time,y =  Sub_metering_1,type = 'l'))
with(selecionados,points(Time,y =  Sub_metering_2,col='red',type = 'l'))
with(selecionados,points(Time,y =  Sub_metering_3,col = 'blue',type = 'l'))

     
legend('topright',
       legend = names(selecionados[,7:9]),
       pch = 0151,col = c('black','red','blue'))

dev.off()
