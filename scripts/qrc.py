#! /usr/bin/env python3

# Generate a Qt Resource file from the contents of a list of directories
# qrc.py <dir1> <dir2> ...

import os
import os.path


def create_qrc(dirname, prefix=None):
    basename = os.path.basename(dirname)

    file_list = []

    for root, dirs, files in os.walk(dirname):
        file_list += [os.path.relpath(os.path.join(root, filename), dirname)
                      for filename in files]

    file_list.sort()

    contents = '<!DOCTYPE RCC>\n<RCC version="1.0">\n\n'

    if prefix:
        contents += '<qresource prefix="/{}">\n'.format(prefix)
    else:
        contents += '<qresource>\n'

    for filename in file_list:
        if (filename.endswith('.js') or filename.endswith('.qml') or
                filename.endswith('.otf') or filename.endswith('.ttf') or
                filename.endswith('.png') or filename.endswith('.jpg') or
                filename.endswith('.jpeg') or filename.endswith('.svg') or
                filename == 'qmldir'):
            contents += '\t<file>' + filename + '</file>\n'

    contents += '</qresource>\n\n</RCC>\n'

    with open(os.path.join(dirname, basename + '.qrc'), 'w') as f:
        f.write(contents)


if __name__ == '__main__':
    create_qrc('demo')
    create_qrc('src/core', 'Material')
    create_qrc('src/controls', 'Material')
    create_qrc('src/components', 'Material')
    create_qrc('src/extras', 'Material/Extras')
    create_qrc('src/listitems', 'Material/ListItems')
    create_qrc('src/popups', 'Material')
    create_qrc('src/styles', 'QtQuick/Controls/Styles/Material')
    create_qrc('src/window', 'Material')
    create_qrc('fonts', 'Material/Fonts')
