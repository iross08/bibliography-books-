#!/bin/bash
# SCRIPT:  plagiarismFinder.sh
# PURPOSE: to find the plagiarism

cat artsandsciencefellows.txt | sed 's/[.!?।]  */&\n/g' > sentence1.txt  

#part A
totalText=$(cat sentence1.txt)
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
done <"sentence1.txt" 

string=$(cat all-header.csv)
grep -rLZ "$string" books-*.csv | while IFS= read -rd '' x; do rm "$x"; done | grep books-*.csv
cat books-*.csv > a1.csv 

R -f master-book-list.R

rm -rf data.json a.csv a1.csv books-*.csv 

python csv2latexPdf.py

rm -rf bookInfo.csv
rm -rf text11.txt sentence1.txt aa1.txt b1.txt c1.txt output1.txt text2.txt plagiarismURL11.txt plagiarismURL1.txt text2.txt preFinal.txt plagiarismURLX.txt book1.txt book2.txt book3.txt sentence.txt 
echo -e "How Very Traditional - Sum With Multiplication Shows The Best - Understand You Beast V13 @copyright PROMOTIONAL THELA SHAMLAO"
