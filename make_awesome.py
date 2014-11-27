#!/bin/env python

from fontTools.ttLib import TTFont, TTLibError
import codecs
import os
import sys

js_template_header = """
.pragma library

var map = {
"""

js_template_footer = """
};
"""

javascriptOut = codecs.open(sys.argv[2], encoding='utf-8', mode='w')

javascriptOut.write(js_template_header)

ttf = TTFont(sys.argv[1], fontNumber=0)
for code,name in list( ttf['cmap'].getcmap(3,1).cmap.items() ):
    if not name.startswith("_"):
        javascriptOut.write(u"\t'%s' : '%s',\n" % (name, unichr(code)))

javascriptOut.write(js_template_footer)
javascriptOut.close()
