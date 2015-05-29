CATEGORIES=(action av communication device file image maps notification social toggle alert content editor hardware navigation)

for CATEGORY in $CATEGORIES; do
	rm -r modules/Material/icons/$CATEGORY/
	mkdir modules/Material/icons/$CATEGORY

	ICONS=$(ls ../material-design-icons/$CATEGORY/svg/production/*48px*)
	
	for FILE in $ICONS; do
		ICON=$(basename $FILE)
		NEW_NAME=$(echo $ICON | sed -E 's/ic_(.*)_48px.svg/\1.svg/')
		cp $FILE modules/Material/icons/$CATEGORY/$NEW_NAME
	done

	ICONS=$(ls ../material-design-icons/$CATEGORY/svg/production/*24px*)
	
	for FILE in $ICONS; do
		ICON=$(basename $FILE)
		NEW_NAME=$(echo $ICON | sed -E 's/ic_(.*)_24px.svg/\1.svg/')
		NEW_FILE=modules/Material/icons/$CATEGORY/$NEW_NAME
		if [[ ! -f $NEW_FILE ]]; then
			cp $FILE $NEW_FILE
		fi
	done
done