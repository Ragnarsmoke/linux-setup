#!/usr/bin/python
import yaml

# Loading configuration from YAML file
with (config.configdir / 'config.yml').open() as f:
    yaml_data = yaml.load(f)

def dict_attrs(obj, path=''):
    if isinstance(obj, dict):
        for k, v in obj.items():
            yield from dict_attrs(v, '{}.{}'.format(path, k) if path else k)
    else:
        yield path, obj

for k, v in dict_attrs(yaml_data):
    if k:
        config.set(k, v)

# Additional configuration
config.set("url.searchengines", {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aur": "https://aur.archlinux.org/packages/?K={}",
    "are": "https://www.archlinux.org/packages/?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "wh": "http://www.wowhead.com/search?q={}"
})
