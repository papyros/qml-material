#! /usr/bin/env python
import sys
import os.path
import urllib


def download_icon(name, out_dirname):
    group, name = name.split('/')
    url = ('https://raw.githubusercontent.com/google/material-design-icons/master/{}/svg/production/ic_{}_48px.svg'
           .format(group, name))
    filename = os.path.join(out_dirname, group + '_' + name + '.svg')
    urllib.urlretrieve(url, filename)


def load_yaml(fileName):
    from yaml import load
    try:
        from yaml import CLoader as Loader
    except ImportError:
        from yaml import Loader
    stream = open(fileName, "r")
    return load(stream, Loader=Loader)


def download_icons(names, out_dirname):
    resources = {}
    for icon in names:
        download_icon(icon, out_dirname)
        group, name = icon.split('/')
        if group in resources:
            resources[group].append(name)
        else:
            resources[group] = [name]

    text = '<!DOCTYPE RCC><RCC version="1.0">\n\n'

    for group, names in resources.items():
        text += '<qresource prefix="/icons/{}">\n'.format(group)
        for name in names:
            text += '\t<file alias="{name}.svg">{group}_{name}.svg</file>\n'.format(group=group, name=name)
        text += '</qresource>\n\n'

    text += '</RCC>'

    return text


if __name__ == '__main__':
    filename = sys.argv[1]

    config = load_yaml(filename)

    icons = config.get('icons', [])
    out_dirname = config.get('out', 'icons')

    if not os.path.exists(out_dirname):
        os.makedirs(out_dirname)

    qrc = download_icons(icons, out_dirname)

    with open(os.path.join(out_dirname, 'resources.qrc'), 'w') as f:
        f.write(qrc)
