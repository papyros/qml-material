#! /bin/bash

cd documentation
rm -r ditaxml html

qdoc material.qdocconf
docmaker.py ditaxml html