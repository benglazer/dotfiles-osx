#!/bin/bash

# This is a scriptified version of
#   https://gist.github.com/jvenator/9672772a631c117da151
#
# Install PDFtk Server edittion on your Mac.
#
# This workaround install is necessary because PDFtk was pulled from
# homebrew-cask due to issues with it aggressively overwriting file
# permissions that could impact other installed libraries. See [this
# homebrew-cask issue](https://github.com/caskroom/homebrew-cask/issues/7707).
#
# The following steps worked on Mac OS X 10.10.1 with a standard
# [brew](http://brew.sh/) installation for the PDFtk Mac OS X server libary
# version 2.02.


# Download and extract the Mac OS X server install pacakge.

curl -o ~/Downloads/pdftk_download.pkg https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.6-setup.pkg
pkgutil --expand ~/Downloads/pdftk_download.pkg ~/Downloads/pdftk_package

# Now create directories for where it would go with a proper brew install.
# NOTE: I had no prior install of PDFtk via brew-cask when doing this. Not
# sure how having multiple versions installed might affect `brew link` and
# these instructions.

cd ~ && mkdir /usr/local/Cellar/pdftk /usr/local/Cellar/pdftk/2.02 /usr/local/Cellar/pdftk/2.02/bin /usr/local/Cellar/pdftk/2.02/lib /usr/local/Cellar/pdftk/2.02/share /usr/local/Cellar/pdftk/2.02/share/man /usr/local/Cellar/pdftk/2.02/share/man/man1

# Give the `Payload` file the proper gzip file extension and unzip it.

mv ~/Downloads/pdftk_package/pdftk.pkg/Payload ~/Downloads/pdftk_package/pdftk.pkg/payload.gz
gunzip ~/Downloads/pdftk_package/pdftk.pkg/payload.gz

# Use `cpio` to unarchive the resulting file.

cd ~/Downloads/pdftk_package/pdftk.pkg/ && cpio -iv < ~/Downloads/pdftk_package/pdftk.pkg/payload && cd ~

# Move the relevant extracted files to their appropriate locations within the
# `Cellar/pdftk` directory.

cd ~ && mv Downloads/pdftk_package/pdftk.pkg/bin/pdftk /usr/local/Cellar/pdftk/2.02/bin/pdftk && mv Downloads/pdftk_package/pdftk.pkg/lib/* /usr/local/Cellar/pdftk/2.02/lib/ && mv Downloads/pdftk_package/pdftk.pkg/man/pdftk.1 /usr/local/Cellar/pdftk/2.02/share/man/man1/pdftk.1

# Create the appropriate symlinks.

brew doctor
brew link pdftk
