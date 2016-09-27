#!/usr/bin/env python3

import requests
import codecs
import re

# Don't include the gender icons from FontAwesome
icon_blacklist = [
    "genderless", "transgender.*", "neuter", "mars.*", "venus.*", "mercury.*",
    "intersex"
]

js_template_header = """
.pragma library

var map = {
"""

js_template_footer = """
};
"""

fontFilename = ''


def is_blacklisted(icon_name):
    for blacklisted_icon in icon_blacklist:
        if re.match(blacklisted_icon, icon_name):
            return True

    return False


def get_awesome_icons():
    print('Downloading SCSS file...')

    response = requests.get('http://raw.githubusercontent.com/FortAwesome/' +
                            'Font-Awesome/master/scss/_variables.scss')
    icons = []

    for line in response.text.split('\n'):
        if not line.startswith('$fa-var-'):
            continue

        line_array = line[8:].strip().split(': ')

        name = line_array[0].replace('-', '_')
        code = line_array[1][2:].strip(';').strip('"')

        icons.append((name, code))

    return icons


def save_icons(icons, filename):
    saved_count = 0

    with codecs.open(filename, encoding='utf-8', mode='w') as f:
        f.write(js_template_header)

        for icon_name, code in icons:
            if not is_blacklisted(icon_name):
                saved_count += 1
                f.write("    '{0}': '\\u{1}',\n".format(icon_name, code))

        f.write(js_template_footer)

    print('Wrote {0} of {1} icons to {2}'.format(saved_count,
                                                 len(icons), filename))


def download_font(url, filename):
    print('Downloading font...')

    response = requests.get(url)

    with open(filename, 'wb') as out_file:
        out_file.write(response.content)

    print('Wrote {0}'.format(filename))


if __name__ == '__main__':
    icons = get_awesome_icons()
    save_icons(icons, 'src/core/awesome.js')

    download_font('http://github.com/FortAwesome/Font-Awesome/' +
                  'raw/master/fonts/FontAwesome.otf',
                  'src/core/FontAwesome.otf')
