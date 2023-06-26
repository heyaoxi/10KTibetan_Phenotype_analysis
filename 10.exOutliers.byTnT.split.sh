#!/bin/bash

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/130.comparisonTnT

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
    for i in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/altitude.list`;do

        cat ../120.att2phens/Altitude-Age-Sex-Eth-${phen}.clean.age_filter.rinfo | grep "$i" | awk '{if($4=="TBN")print}' | awk '{x[NR]=$5; s+=$5; n++} END{a=s/n; for (i in x){ss += (x[i]-a)^2} sd = sqrt(ss/n); print "'$i' "s/NR-3*sd, s/NR+3*sd}' >>${phen}.TBN.avg-sd
        cat ../120.att2phens/Altitude-Age-Sex-Eth-${phen}.clean.age_filter.rinfo | grep "$i" | awk '{if($4!="TBN" && $4!="Ethnicity")print}' | awk '{x[NR]=$5; s+=$5; n++} END{a=s/n; for (i in x){ss += (x[i]-a)^2} sd = sqrt(ss/n); print "'$i' "s/NR-3*sd, s/NR+3*sd}' >>${phen}.nonTBN.avg-sd
    done
		
		cat ../120.att2phens/Altitude-Age-Sex-Eth-${phen}.clean.age_filter.rinfo | awk '{if($4=="TBN")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.TBN.rinfo
		cat ../120.att2phens/Altitude-Age-Sex-Eth-${phen}.clean.age_filter.rinfo | awk '{if($4!="TBN" && $4!="Ethnicity")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.nonTBN.rinfo
		
		perl /gpfs/home/heyaoxi/analysis/metabolism_tibetans/add.3sd.pl ${phen}.TBN.avg-sd Altitude-Sex-Eth-${phen}.clean.age_filter.TBN.rinfo Altitude-Sex-Eth-${phen}.TBN.add3sd
		perl /gpfs/home/heyaoxi/analysis/metabolism_tibetans/add.3sd.pl ${phen}.nonTBN.avg-sd Altitude-Sex-Eth-${phen}.clean.age_filter.nonTBN.rinfo  Altitude-Sex-Eth-${phen}.nonTBN.add3sd
		
		cat Altitude-Sex-Eth-${phen}.TBN.add3sd Altitude-Sex-Eth-${phen}.nonTBN.add3sd >Altitude-Sex-Eth-${phen}.TnT.add3sd

    echo "Altitude Age Sex Ethnicity ${phen}" >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.rinfo
    cat Altitude-Sex-Eth-${phen}.TnT.add3sd | awk '{if($5>$6 && $5<$7 || $1=="Altitude")print $1"m", $2, $3, $4, $5}' >>Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.rinfo

    cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.rinfo | awk '{if($3=="Sex" || $3=="Male")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.male.rinfo 
    cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.rinfo | awk '{if($3=="Sex" || $3=="Female")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.female.rinfo

    cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.male.rinfo | awk '{if($4=="Ethnicity" || $4=="TBN")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.male.TBN.rinfo
    cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.male.rinfo | awk '{if($4=="Ethnicity" || $4=="nonTBN")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.male.nonTBN.rinfo
    cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.female.rinfo | awk '{if($4=="Ethnicity" || $4=="TBN")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.female.TBN.rinfo
    cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.female.rinfo | awk '{if($4=="Ethnicity" || $4=="nonTBN")print}' >Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.split.female.nonTBN.rinfo
done
