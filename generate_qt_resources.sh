#!/bin/bash
#
# Script to generate Qt Resource files for easy inclusion of qml-material into other projects.
# The script generates four resource files:
#   -Material.qrc:      The main qml-material components;
#   -QtQuick.qrc:       The Material Design style required by qml-material's components;
#   -FontAwesome.qrc:   The Font Awesome files
#   -FontRoboto.qrc:    The Roboto font files (note: these are big!)


cd modules

function generate_resource_file() {
    args=($@)                           # Build a bash array from the list of arguments
    output_file=${args[0]}              # First argument
    search_path=${args[1]}              # Second argument
    patterns=(${args[@]:2:${#args}})    # Search patterns are the remaining arguments, place into a new array.

    # echo "output_file: ${output_file}"
    # echo "search_path: ${search_path}"
    # echo "patterns:    ${patterns[*]}"

    # Clear file
     rm -f ${output_file}

    # Resource file header
    echo '<RCC>
    <qresource prefix="/">' >> ${output_file}

    # Loop over the patterns, search for them and construct a line from the found files.
    for pattern in ${patterns[*]}; do
        find ${search_path} -name ${pattern} | sort | sed "s|\(.*\)|        <file>\1</file>|g" >> ${output_file}
        echo '' >> ${output_file}
    done

    # Resource file footer
    echo '    </qresource>
</RCC>' >> ${output_file}
}

#                       Output file       Folder to search         List of patterns to search for
generate_resource_file 'Material.qrc'    'Material/'              'qmldir' '*.qml' '*.js'
# Remove awesome.js from Material.qrc as we include it in FontAwesome.qrc instead
sed "s|.*awesome.js.*||g" -i Material.qrc

generate_resource_file 'QtQuick.qrc'     'QtQuick/'               'qmldir' '*.qml'
generate_resource_file 'FontAwesome.qrc' 'Material/'              'awesome.js' 'FontAwesome.otf'
generate_resource_file 'FontRoboto.qrc'  'Material/fonts/roboto/' '*.ttf'
