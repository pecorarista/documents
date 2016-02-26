#!/bin/sh
for i in "10a" "10b" "12a" "12b"
do
    wget "http://research.microsoft.com/en-us/um/people/cmbishop/prml/prmlfigs-pdf/Figure10.${i}.pdf"
    mv "Figure10.${i}.pdf" "Figure10-${i}.pdf"
done
for i in "6a" "6b" "12a" "12b" "14a" "14b"
do
    wget "http://research.microsoft.com/en-us/um/people/cmbishop/prml/prmlfigs-pdf/Figure4.${i}.pdf"
   mv "Figure4.${i}.pdf" "Figure4-${i}.pdf"
done
for i in "2a" "2b" "2c" "2d" "2e" "2f"
do
    wget "http://research.microsoft.com/en-us/um/people/cmbishop/PRML/prmlfigs-pdf/Figure14.${i}.pdf"
    mv "Figure14.${i}.pdf" "Figure14-${i}.pdf"
done
wget "http://people.cs.ubc.ca/~murphyk/MLbook/figReport-16-Aug-2012/pdfFigures/regtreeSurfaceB.pdf"
wget "http://people.cs.ubc.ca/~murphyk/MLbook/figReport-16-Aug-2012/pdfFigures/giniDemo.pdf"
