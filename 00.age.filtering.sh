#!/bin/bash

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens
file=/gpfs/home/heyaoxi/analysis/metabolism_tibetans/10KTBN.phenos.clean.splitHan.csv

cat $file | awk -F ',' '{if($8>=18 && $8<=70 || $8=="Age" || $8=="NoData") print}' >10KTBN.phenos.clean.splitHan.age_filtered.csv
cat $file | awk -F ',' '{if($8<18 || $8>70 || $8=="Age")print}' | awk -F ',' '{if($8!="NoData")print}' >failed.clean.splitHan.age_filtered.csv
