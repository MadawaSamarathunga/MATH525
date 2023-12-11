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



# split statements in 3 objects respectively with: both, bs only and is only statements

aapl.1314.all <- aapl.1314$allfy

aapl.1314.bs <- aapl.1314$bsfy
  
aapl.1314.is <- aapl.1314$isfy




# check statements bnm

check_statement(bnm_bs)

check_statement(bnm_is)

#check statements frasers

check_statement(frasers_bs)

check_statement(frasers_is)


# plots for simplified bs and full is statements bnm

bnm_bss <- simplify.bs(bnm_bs)

plot.bsf(bsf=bnm_bss)

plot.isf(isf=bnm_is, dates=c(1,2))

# plots for simplified bs and full is statements frasers

frasers_bss <- simplify.bs(frasers_bs)

plot.bsf(bsf=frasers_bss)

plot.isf(isf=frasers_is, dates=c(1,2))


# horizontal and vertical analyses for bs and is statements bns

horizonal.analysis(fs=bnm_bs, type='bs', units = 1000000)

vertical.analysis(fs=bnm_bs, type = 'bs', total = NULL)

horizonal.analysis(fs=bnm_is, type='is', units = 1000000)

vertical.analysis(fs=bnm_is, type = 'is', total = NULL)

# horizontal and vertical analyses for bs and is statements frasers

horizonal.analysis(fs=frasers_bs, type='bs', units = 1000000)

vertical.analysis(fs=frasers_bs, type = 'bs', total = NULL)

horizonal.analysis(fs=frasers_is, type='is', units = 1000000)

vertical.analysis(fs=frasers_is, type = 'is', total = NULL)




# some ratios

aapl.1314.ratios <- fin.ratios(fstats=aapl.1314.all, ratios=c(profit.margins, bsf.ratios, isf.ratios))

plot(aapl.1314.ratios[,1:3], main='',type='b')






#################
# CW statements
#################


# create bs and is statements in R for the two companies (e.g. xxxx and yyyy)

bnm_bs = make.statement(template='bnm_bs.csv', skeleton="bs_skeleton.R", digits = 2) 

bnm_is = make.statement(template='bnm_is.csv', skeleton="is_skeleton.R", digits = 2) 


frasers_bs = make.statement(template='frasers_bs.csv', skeleton="bs_skeleton.R", digits = 2) 

frasers_is = make.statement(template='frasers_is.csv', skeleton="is_skeleton.R", digits = 2) 



# use the necessary commands from above to:

# - check the bs ad is statements
# - produce the bs and is plots 
# - produce horizontal and vertical analysis tables 

# using the statements created from the .csv files  
          

