#! /bin/bash

tempdir=$(mktemp -d /tmp/$REPO_NAME.XXXX)

qmlfiles=$(find modules -type f -name \*qml -print)
jsfiles=$(find modules -type f -name \*js -print)
pyfiles=$(find modules -type f -name \*py -print)

fail=0

echo ">>> Checking QML files using qmllint"

for file in $qmlfiles; do
	qmllint $file || fail=1
done

echo ">>> Checking Python files using pyflakes and pep8"

for file in $pyfiles; do
	pyflakes $file || fail=1
	pep8 $file || fail=1
done

echo ">>> Checking Javascript files using jshint"

srcdir=$(pwd)

cd $tempdir

for file in $jsfiles; do
	mkdir -p $(dirname $file)
	sed "s/\.pragma .*//g; s/\.import .*//g" < $srcdir/$file > $file
	jshint $file || fail=1
done

if [[ $fail == 1 ]]; then
	exit 1
fi
