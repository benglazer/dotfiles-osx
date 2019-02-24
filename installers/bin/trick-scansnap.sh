#!/bin/bash

# Adapted from http://www.documentsnap.com/abbyy-finereader-and-snow-leopard-file-not-created-with-scansnap/#comment-376
# Uses pdftk installed via https://gist.github.com/jvenator/9672772a631c117da151
# Uses pdfauxinfo from http://msyk.net/macos/pdfauxinfo/

for f in "$@"
do
    /usr/sbin/pdfauxinfo -k "ScanSnap Manager" -i "$f" -o "$f"
    /usr/local/bin/pdftk "$f" update_info /Users/ben/lib/trick-scansnap.txt output /tmp/tmpPDFtkFile.pdf
    mv -f /tmp/tmpPDFtkFile.pdf "$f"

    ### Sample code for processing in FineReader:
    # g="${f##*/}"
    # g="${g%.*}"
    # open -a 'FineReader for ScanSnap.app' "$f"
    # while [ ! -e "${f%.pdf} processed by FineReader.pdf" ]; do
    #     sleep 30
    # done
    # sleep 15
    # mv -f "${f%.pdf} processed by FineReader.pdf" "$f"
done
