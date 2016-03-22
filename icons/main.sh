rm LICENSE README.md bower.json index.html package.json
rm -rf sprites
for dir in action communication editor image notification alert content file maps social toggle av device hardware navigation
do
	rm -rf $dir/*x* $dir/dr*
	mv $dir/svg/production/* $dir
	rm -rf $dir/svg
	rename 's/ic_//' $dir/*
	rename 's/_[0-9]{2}px//' $dir/*
	rm  $dir/*px.svg
done
