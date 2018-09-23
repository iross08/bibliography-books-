#!/usr/bin/env python
import sys
from isbntools.app import *

query = sys.argv[1].replace(' ', '+')
isbn = isbn_from_words(query)

print("The ISBN of the most `spoken-about` book with this title is %s" % isbn)
print("")
print("... and the book is:")
print("")
print(registry.bibformatters['labels'](meta(isbn)))
