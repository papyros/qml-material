#!/usr/bin/env python

import urllib2
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

jsFilename = 'awesome.js'
fontFilename = 'fonts/fontawesome/FontAwesome.otf'

print 'Downloading SCSS file...'
scssReq = urllib2.Request('http://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/scss/_variables.scss')
scssIn = urllib2.urlopen(scssReq)
javascriptOut = codecs.open(jsFilename, encoding='utf-8', mode='w')

javascriptOut.write(js_template_header)

lines = [line[8:].strip().split(': ') for line in scssIn if line.startswith('$fa-var-')]

for line in lines:
    name = line[0].replace('-','_')
    code = line[1][2:].strip(';').strip('"')
    javascriptOut.write("    '%s': '\u%s',\n" % (name, code))

javascriptOut.write(js_template_footer)
javascriptOut.close()
print 'wrote %d icons to %s' % (len(lines), jsFilename)

print 'Downloading font'
fontReq = urllib2.Request('http://github.com/FortAwesome/Font-Awesome/raw/master/fonts/FontAwesome.otf')
fontIn = urllib2.urlopen(fontReq)
fontOut = open(fontFilename,'wb')
fontOut.write(fontIn.read())
fontOut.close()

print 'wrote %s' % fontFilename
