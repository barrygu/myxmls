__version__ = "1.0.0"
__version_info__ = (1, 0, 0)
__license__ = "Unlicense"
__author__ = 'Gu Jianzhong <jianzhong.gu@harman.com>'

import re , sys
try:
    import ujson as json # Speedup if present; no big deal if not
except ImportError:
    import json

#
# this function is copied from json_cleaner.py
# https://gist.github.com/liftoff/ee7b81659673eca23cd9fc0d8b8e68b7
#
def remove_trailing_commas(json_like):
    """
    Removes trailing commas from *json_like* and returns the result.  Example::

        >>> remove_trailing_commas('{"foo":"bar","baz":["blah",],}')
        '{"foo":"bar","baz":["blah"]}'
    """
    trailing_object_commas_re = re.compile(
        r'(,)\s*}(?=([^"\\]*(\\.|"([^"\\]*\\.)*[^"\\]*"))*[^"]*$)')
    trailing_array_commas_re = re.compile(
        r'(,)\s*\](?=([^"\\]*(\\.|"([^"\\]*\\.)*[^"\\]*"))*[^"]*$)')
    # Fix objects {} first
    objects_fixed = trailing_object_commas_re.sub("}", json_like)
    # Now fix arrays/lists [] and return the result
    return trailing_array_commas_re.sub("]", objects_fixed)

#
# this function is copied from dict2xml.py
# https://gist.github.com/reimund/5435343
#
def dict2xml(d, root_node=None):
	wrap          =     False if None == root_node or isinstance(d, list) else True
	root          = 'objects' if None == root_node else root_node
	root_singular = root[:-1] if 's' == root[-1] and None == root_node else root
	xml           = ''
	children      = []

	if isinstance(d, dict):
		for key, value in dict.items(d):
			if isinstance(value, dict):
				children.append(dict2xml(value, key))
			elif isinstance(value, list):
				#children.append(dict2xml(value, key))
				children.append("<"+key+">")
				children.append(dict2xml(value, "key"))
				children.append("</"+key+">")
			else:
				xml = xml + ' ' + key + '="' + str(value) + '"'
	else:
		for value in d:
			children.append(dict2xml(value, root_singular))

	end_tag = '>' if 0 < len(children) else '/>'

	if wrap or isinstance(d, dict):
		xml = '<' + root + xml + end_tag

	if 0 < len(children):
		for child in children:
			xml = xml + child

		if wrap or isinstance(d, dict):
			xml = xml + '</' + root + '>'
		
	return xml

with open('crossbar.conf','r') as f:
    s = f.read()
    f.close()
    conf=json.loads(remove_trailing_commas(s))

xml_string = dict2xml(conf, 'crossbar')

import xml.dom.minidom as minidom
xml = minidom.parseString(xml_string) # or xml.dom.minidom.parse(xml_fname)
pi = xml.createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="xbar-conf.xsl"')
xml.insertBefore(pi, xml.firstChild)
print(xml.toprettyxml(indent="    ", encoding="utf-8"))
