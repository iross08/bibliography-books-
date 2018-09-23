#!/bin/bash
# SCRIPT:  plagiarismFinder.sh
# PURPOSE: to find the plaggiarism

cat cv.txt | sed 's/[.!?।]  */&\n/g' > sentence1.txt  

#part A
totalText=$(cat sentence1.txt)

#lynx -dump https://www.googleapis.com/books/v1/volumes?q=$totalText |  jq -r "[.items[].volumeInfo.title,.items[].volumeInfo.authors,.items[].volumeInfo.publisher]" >>book1.txt

loopNumber=1

#part B: only titles of the books
while read -r text           
do  
    echo -e "$loopNumber initiated"
    echo -e $text
    
    search=""
    for word in $text
    do
        search="$search%20$word"
    done
        
        lynx -dump https://www.googleapis.com/books/v1/volumes?q=$search > data.json
        
        python json_to_csv.py items data.json books-$loopNumber.csv
        
        loopNumber=$((loopNumber+1))
        
        rm -rf data.json
        
#  head -n 10 c.txt >> plagiarismURLX.txt
#
#  while read -r host           
#  do 
#  
#    if [ -z $(echo {host##*/}) ] ; then
#      echo "${host##*/}"
#    else
#      parallel --gnu --pipe --block 200M grep -vwE "$host" plagiarismURL.txt > plagiarismURL11.txt
#    fi
#
#  done <"plagiarismURLX.txt"
  
  #cat plagiarismURL11.txt |sort | uniq -u>> plagiarismURL1.txt
#  cat plagiarismURL11.txt |sort | uniq -u >> refreshedURL.txt
  #cat plagiarismURL.txt |sort | uniq -u >> refreshedURL.txt
done <"sentence1.txt" 

string=$(cat all-header.csv)
grep -rLZ "$string" books-*.csv | while IFS= read -rd '' x; do rm "$x"; done | grep books-*.csv

cat books-*.csv > a1.csv 
#sort a.csv | uniq | sort > a1.csv 

R -f master-book-list.R
        
rm -rf data.json a.csv a1.csv books-*.csv 

#while read -r text           
#do  
#    echo -e $text
    
#    search=""
#    for word in $text
#    do
#        search="$search%20$word"
#    done
        
#        lynx -dump https://www.googleapis.com/books/v1/volumes?q=$search | jq -r "[.items[].volumeInfo.title,.items[].volumeInfo.authors,.items[].volumeInfo.publisher]" >>book3.txt
        
        
#  head -n 10 c.txt >> plagiarismURLX.txt
#
#  while read -r host           
#  do 
#  
#    if [ -z $(echo {host##*/}) ] ; then
#      echo "${host##*/}"
#    else
#      parallel --gnu --pipe --block 200M grep -vwE "$host" plagiarismURL.txt > plagiarismURL11.txt
#    fi
#
#  done <"plagiarismURLX.txt"
  
  #cat plagiarismURL11.txt |sort | uniq -u>> plagiarismURL1.txt
#  cat plagiarismURL11.txt |sort | uniq -u >> refreshedURL.txt
  #cat plagiarismURL.txt |sort | uniq -u >> refreshedURL.txt
#done <"sentence1.txt" 

cat book1.txt book2.txt book3.txt > bookReferenced.txt
#part C : details of the books

python csv2latexPdf.py

rm -rf bookInfo.csv

mv referenceBooks.pdf /home/irashadul/Documents/documentationStatistics/

cd /home/irashadul/Documents/documentationStatistics/

#similarity checker
###################################################
#token=1
#while read -r url           
#do  
#    #rm -rf text2.txt
#    lynx -dump "$url">> text2.txt
#    
#    while read -r texts           
#    do  
#	#if [ ! -z "$(parallel –pipe grep -f "$texts" text2.txt)" ]
#	#if [ ! -z "$(parallel grep -Fx "$texts" text2.txt)" ]
#	if [ ! -z "$(parallel --gnu --pipe --block 200M grep -f "$texts" text2.txt)" ]
#	then
#	  echo $url>> op.txt
#	  echo "$token ) $url matched with the texts"
#	  let token++  
#	else
#	  echo ""
#	  #echo "matching conflict occurs"
#	fi
#	
#	#echo "cross referencing line no $token please wait"
#    done< "sentence.txt"
#    
#done <"plagiarismURL1.txt"

#cat op.txt | sort | uniq -u >> refreshedURL.txt


#printing only original links
#============================
#  while read -r hosts           
#  do 
#  
#    if [ -z $(echo {hosts##*/}) ]
#    then
#      echo ""
#    else  
#      echo $hosts > refreshedURL.txt
#    fi
#
#  done <"op.txt"


rm -rf text11.txt sentence1.txt aa1.txt b1.txt c1.txt output1.txt text2.txt plagiarismURL11.txt plagiarismURL1.txt text2.txt preFinal.txt plagiarismURLX.txt book1.txt book2.txt book3.txt   


