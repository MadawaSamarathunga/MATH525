# make sure the following packages are installed


# plyr
# dplyr
# XBRL
# finreportr
# devtools
# ggplot2
# cowplot
# quantmod
# Rmisc
# grid
# gridExtra
# finstr

## download the files from DLE into a folder (e.g. here it is 'STO7009\\code')
## then set the working directory to this folder

new.wd <- paste0(Sys.getenv('USERPROFILE'), "\\OneDrive - University of Plymouth\\MATH525\\Coursework")      # path to wd

setwd(new.wd)      # change the wd

getwd()            # check the new wd        




# load the software

eval(call(load('banR.R')))




# set some parameters for the session

options(dplyr.print_max = 1000)
options(warn = -1)
options(stringsAsFactors = FALSE)
options(HTTPUserAgent = "name_surname   name_surname@domain.com")




# can check the help files for some packages, e.g.

# help(package=finreportr)
# help(package=finstr)

 



### commands for EDGAR database (USA companies only)


# get company info 

CompanyInfo("AAPL")




# get statements from the database

aapl.1314 <- GetFinStats(symbol='AAPL', years=2013:2015)




# get statements saved previously

load(file = 'apple_1314.R')   




# split statements in 3 objects respectively with: both, bs only and is only statements

aapl.1314.all <- aapl.1314$allfy

aapl.1314.bs <- aapl.1314$bsfy
  
aapl.1314.is <- aapl.1314$isfy




# check statements

check_statement(aapl.1314.bs)

check_statement(aapl.1314.is)




# plots for simplified bs and full is statements

aapl.1314.bss <- simplify.bs(aapl.1314.bs)

plot.bsf(bsf=aapl.1314.bss)

plot.isf(isf=aapl.1314.is, dates=c(1,2))




# horizontal and vertical analyses for bs and is statements

horizonal.analysis(fs=aapl.1314.bs, type='bs', units = 1000000)

vertical.analysis(fs=aapl.1314.bs, type = 'bs', total = NULL)

horizonal.analysis(fs=aapl.1314.is, type='is', units = 1000000)

vertical.analysis(fs=aapl.1314.is, type = 'is', total = NULL)




# some ratios

aapl.1314.ratios <- fin.ratios(fstats=aapl.1314.all, ratios=c(profit.margins, bsf.ratios, isf.ratios))

plot(aapl.1314.ratios[,1:3], main='',type='b')






#################
# CW statements
#################


# create bs and is statements in R for the two companies (e.g. xxxx and yyyy)

xxxx.bs = make.statement(template='xxxx-bs_template.csv', skeleton="bs_skeleton.R", digits = 2) 

xxxx.is = make.statement(template='xxxx-is_template.csv', skeleton="is_skeleton.R", digits = 2) 


yyyy.bs = make.statement(template='yyyy-bs_template.csv', skeleton="bs_skeleton.R", digits = 2) 

yyyy.is = make.statement(template='yyyy-is_template.csv', skeleton="is_skeleton.R", digits = 2) 



# use the necessary commands from above to:

# - check the bs ad is statements
# - produce the bs and is plots 
# - produce horizontal and vertical analysis tables 

# using the statements created from the .csv files  
          

