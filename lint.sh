tempdir=$(mktemp -d /tmp/$REPO_NAME.XXXX)

echo ">>> Checking QML files using qmllint"

# Run QML files through qmllint
find modules -type f -name \*qml -exec qmllint \{\} +

echo ">>> Checking Javascript files using jslint"

jsfiles=$(find modules -type f -name \*js -print)
srcdir=$(pwd)

cd $tempdir

for file in $jsfiles; do
	mkdir -p $(dirname $file)
	sed "s/\.pragma .*//g" < $srcdir/$file > $file
	jslint $file
done