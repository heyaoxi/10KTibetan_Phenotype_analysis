#!/bin/sh

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do 
    for att in `cat group.list`;do
		    for sex in male female;do

#### calcu diff P-value by lm and calcu adj-AVG by acova
            cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.grouped.${sex}.rinfo | grep -E "Altitude|$att" >${phen}.${sex}.${att}
						Rscript ${phen}.lm.splitSex.r ${phen}.${sex}.${att} >${phen}.${sex}.${att}.lm.tmp
						
						echo "#${phen} ${att}" >>${phen}.${sex}.all.altitude.lm
						cat ${phen}.${sex}.${att}.lm.tmp | grep EthnicityTBN >>${phen}.${sex}.all.altitude.lm
						cat ${phen}.${sex}.${att}.lm.tmp | tail -1 >>${phen}.${sex}.all.altitude.lm

#### calculate avarage of sd of phenotype
            for eth in TBN nonTBN;do
                echo "#$att" >>${phen}.${sex}.all.altitude.${eth}.value.sd.tmp
                awk '{if($4=="'${eth}'")print}' ${phen}.${sex}.${att} | awk '{x[NR]=$5;s+=$5; n++} END{a=s/n; for (i in x){ss += (x[i]-a)^2} sd = sqrt(ss/n); printf("%.2f", sd)}' >>${phen}.${sex}.all.altitude.${eth}.value.sd.tmp
                cat ${phen}.${sex}.all.altitude.${eth}.value.sd.tmp | tr '\n' ' ' | tr '#' '\n' | sed '/^$/d' | awk '{if($2=="")print"NA";else print $2}' >${phen}.${sex}.all.altitude.${eth}.value.sd

### count sample size
                awk '{if($4=="'${eth}'")print}' ${phen}.${sex}.${att} | wc -l >>${phen}.${sex}.all.altitude.${eth}.counts
            done
        done
    done
done

#######################################################

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do 
    for sex in male female;do
		    cat ${phen}.${sex}.all.altitude.lm | tr '\n' ' ' | tr '#' '\n' | grep -v '^$' | awk '{if($3=="")print $1, $2, "NA NA NA NA NA NA NA";else print $0}' >${phen}.${sex}.all.altitude.lm2
		    paste ${phen}.${sex}.all.altitude.lm2 ${phen}.${sex}.all.altitude.nonTBN.value.sd ${phen}.${sex}.all.altitude.TBN.value.sd ${phen}.${sex}.all.altitude.nonTBN.counts ${phen}.${sex}.all.altitude.TBN.counts | sed -r 's/\s+/,/g' >${phen}.${sex}.all.altitude.rls.csv

############################ multiple test
        echo "altitude Raw.p" >${phen}.${sex}.all.altitude.rawp
				awk -F ',' '{print $2, $7}' ${phen}.${sex}.all.altitude.rls.csv >>${phen}.${sex}.all.altitude.rawp
				Rscript multiple.test.r ${phen}.${sex}.all.altitude.rawp ${phen}.${sex}.all.altitude.adjp.tmp
				cat ${phen}.${sex}.all.altitude.adjp.tmp | grep -v altitude | sort -nk1 | awk '{print $3}' >${phen}.${sex}.all.altitude.adjp
				paste ${phen}.${sex}.all.altitude.rls.csv ${phen}.${sex}.all.altitude.adjp | sed 's/\t/,/g' >${phen}.${sex}.all.altitude.rls.adj.csv
				echo "${phen},${phen},${phen},${phen},${phen},${phen},${phen},${phen},${phen}" >${phen}.${sex}.all.altitude.rls.adj.csv.tmp
				cat ${phen}.${sex}.all.altitude.rls.adj.csv | awk -F ',' '{print $4,$7,$14,$9,$11,$13,$8,$10,$12}' | sed 's/ /,/g' >>${phen}.${sex}.all.altitude.rls.adj.csv.tmp
     done
done

rm *lm.tmp *0
