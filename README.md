#The codes for analyzing the phenotypic data of 11,880 highlanders \n
00.age.filtering.sh  # Age filtering
01.split.att2phen.rinfo.sh  # make splited files by phenotypes
02.count.sh  # counting data of each phenotype
03.pipeline.exOutliers.sh  # pipeline for exclude outliers based on each group at same altitude
04.count.and.calcuCor.sh  # counting the clean data of each phenotype
05.count.and.calcuCor.splitSex.sh  # counting the clean data of each phenotype spliting male and female
06.count.and.calcuCor.splitEth.sh  # counting the clean data of each phenotype spliting Tibetans and Han Chinese
07.linear.regression.combined.sh  # comparing analysis of all phenotypic data using linear regression
08.linear.regression.splitSex.sh  # comparing analysis of all phenotypic data using linear regression (split sex)
09.linear.regression.splitEth.sh  # comparing analysis of all phenotypic data using linear regression (split ethnicity)
10.exOutliers.byTnT.split.sh  # pipeline for exclude outliers based on each group at same altitude (split ethnicity)
11.diff.analysis.pipeline.sh  # pipleline for difference analysis
12.diff.analysis.pipeline.splitSex.sh  # pipleline for difference analysis (split sex)
