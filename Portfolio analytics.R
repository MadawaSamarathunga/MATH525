# MATH525 workshop 7 - Portfolio analytics


# setup

new.wd <- 'path to your working directory'

setwd(new.wd)      # change the wd

getwd()            # check the new wd          

install.packages('PortfolioAnalytics')
# Load the new package
library(PortfolioAnalytics)

#load our business analytics R library
eval(call(load('banR.R')))


              
              
########
# UK
              
             
#uk.symbols <- c("FRAS.L", "BME.L", "CARD.L", "NXT.L", "JD.L", "MKS.L", "DNLM.L", "SMWH.L", "KGF.L", "PETS.L", "HFD.L", "GAMA.L", "LGEN.L")
              

#tmp.uk <- new.env()
#getSymbols.yahoo(uk.symbols, env = tmp.uk, from = '2016-01-02')
#attach(tmp.uk)


# save(tmp.uk, file = 'ukstocks.R')       # once downloaded, save the data to use again later

# load(file = 'ukstocks.R')               # tmp.uk


set.seed(0)
#BME
capm.uk_BME <- capm.fit(x = tmp.uk_BME, mkt = 'BME.L')


portf.uk_BME <- portfolio.fit(x=capm.uk_BME, target = 'min.stdv', rp.method = 'simplex')

names(portf.uk_BME)

portf.uk_BME[4:5]

chart.Weights(portf.uk_BME$opt, plot.type = 'barplot' )

plot(portf.uk_BME$c.rets, main = 'Cumulative returns B&M')


# Compute annualized returns

round(table.AnnualizedReturns(R = portf.uk_BME$rets/100, scale=252),3)

#Frasers
capm.uk_FRAS <- capm.fit(x = tmp.uk_FRAS, mkt = 'FRAS.L')

portf.uk_FRAS <- portfolio.fit(x=capm.uk_FRAS, target = 'min.stdv', rp.method = 'simplex')

names(portf.uk_FRAS)

portf.uk_FRAS[4:5]

chart.Weights(portf.uk_FRAS$opt, plot.type = 'barplot')

plot(portf.uk_FRAS$c.rets, main = 'Cumulative returns Frasers')


# Compute annualized returns

round(table.AnnualizedReturns(R = portf.uk_FRAS$rets/100, scale=252),3)





