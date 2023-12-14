## MATH525 Workshop 6

# new.wd <- "path to your working directory folder, set this as appropriate"     

setwd(new.wd)      # change the wd

getwd()            # check the new wd          


eval(call(load('banR.R')))

rm(ls)

# to run the following analysis we will use the following packages (loaded by running the line above)

# library(RCurl)
# library(devtools)
# library(quantmod)




 
######## Download data (from Yahoo) for several assets and plot CAPM 

?getSymbols
?getSymbols.yahoo



################################
# Suggestions for the Coursework
################################


# for the Coursework you will need UK symbols from the DLE list of companies and also the UK market index.
# data about market indices have several missing values and therefore we shall find some alternative data to use
# there are some investment funds called ETF's that have data very close to the index calculation, and they don't have missing values
# we will use these ETF data as index data. For the index FTSE100 one of the best ETF has symbol HUKX.L. I recommend you use these data
# I will explain the full details for the use of ETF data next week.


# the symbols of your two companies, say AAA and BBB, should be in the following vector. I suggest at very least 10 symbols 

#uk.symbols <- c('HUKX.L','AAA','BBB', ....)

# e.g.

#uk.symbols <- c('FRAS.L','BME.L','CARD.L', 'NXT.L', 'MKS.L', 'DNML.L', 'SBRY.L', 'DC.L', 'JD.L', 'SMWH.L', 'KGF.L', 'HFD.L', 'AO.L', 'TED.L','DFS.L','SHOE.L','HFD.L')          

  #BME

uk.symbols_BME <- c('BME.L',"FRAS.L", "CARD.L", "NXT.L", "JD.L", "MKS.L", "DNLM.L", "SMWH.L", "KGF.L", "PETS.L", "HFD.L", "GAMA.L", "LGEN.L")

# download Yahoo data

tmp.uk_BME <- new.env()
getSymbols.yahoo(uk.symbols_BME, env = tmp.uk_BME, from = '2016-01-02')

# check if download successful

ls(tmp.uk_BME)     # should return the symbols of downloaded data 

# after you download the data, save these on disk for later usage


save(tmp.uk_BME, file = 'ukstocks_BME.R')

# later you can use these data again by re-loading data with

load(file = 'ukstocks_BME.R')     # data are in the environment tmp.uk

ls(tmp.uk_BME)     # should return again the symbols of loaded data 


# capm analysis

capm.uk_BME = capm.fit(x=tmp.uk_BME, mkt='BME.L')



names(capm.uk_BME)


capm.uk_BME$capm



#Frasers



uk.symbols_FRAS <- c( 'FRAS.L',"BME.L", "CARD.L", "NXT.L", "JD.L", "MKS.L", "DNLM.L", "SMWH.L", "KGF.L", "PETS.L", "HFD.L", "GAMA.L", "LGEN.L")

# download Yahoo data

tmp.uk_FRAS <- new.env()
getSymbols.yahoo(uk.symbols_FRAS, env = tmp.uk_FRAS, from = '2016-01-02')

# check if download successful

ls(tmp.uk_FRAS)     # should return the symbols of downloaded data 

# after you download the data, save these on disk for later usage


save(tmp.uk_FRAS, file = 'ukstocks_FRAS.R')

# later you can use these data again by re-loading data with

load(file = 'ukstocks_FRAS.R')     # data are in the environment tmp.uk

ls(tmp.uk_FRAS)     # should return again the symbols of loaded data 


capm.uk_FRAS = capm.fit(x=tmp.uk_FRAS, mkt='FRAS.L')
names(capm.uk_FRAS)
capm.uk_FRAS$capm


























































######## ex. 7.1


www <- "web.archive.org/web/20160711084707/http://staff.elena.aut.ac.nz:80/Paul-Cowpertwait/ts/global.dat"

global.url <- getURL(gsub("[\r\n]", "", www))
Global <- scan(textConnection(global.url))
Global.ts <- ts(Global, start = c(1856, 1), end = c(2005, 12), frequency = 12)
Global.annual <- aggregate(Global.ts, FUN = mean)

par(mfrow = c(2, 1))
plot(Global.ts, ylab = expression(paste("Temperature in ", degree * C)), sub = "Monthly series")
plot(Global.annual, ylab = expression(paste("Temperature in ", degree * C)), sub = "Mean annual series")
par(mfrow = c(1, 1))

temps.1970 <- window(Global.ts, start = 1970)

plot(temps.1970, ylab = expression(paste("Temperature in ", degree * C)), sub = "From 1970")

times.1970 <- time(temps.1970)

arima.1970 <- arima(temps.1970, order = c(2, 0, 0), xreg = times.1970)


# pred.

new.times <- seq(from = 2006, to = 2012, by = 1/12)
new.temps.arima <- predict(arima.1970, n.ahead = length(new.times), newxreg = new.times, se.fit = TRUE)
ts.plot(cbind(temps.1970, new.temps.arima$pred,
              new.temps.arima$pred - 2 * new.temps.arima$se,
              new.temps.arima$pred + 2 * new.temps.arima$se),
        col = c("black", rep("red", 3)), ylab = expression(paste("Temperature in", degree * C))) 

abline(v = 2006)

acf(residuals(arima.1970))

pacf(residuals(arima.1970))
