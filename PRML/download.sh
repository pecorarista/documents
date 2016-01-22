#!/bin/sh
for i in a b c d e f
do
    wget "http://research.microsoft.com/en-us/um/people/cmbishop/PRML/prmlfigs-pdf/Figure14.2${i}.pdf"
    mv "Figure14.2${i}.pdf" "Figure14-2${i}.pdf"
done
wget "http://people.cs.ubc.ca/~murphyk/MLbook/figReport-16-Aug-2012/pdfFigures/regtreeSurfaceB.pdf"
wget "http://people.cs.ubc.ca/~murphyk/MLbook/figReport-16-Aug-2012/pdfFigures/giniDemo.pdf"
