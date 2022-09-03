#!/usr/bin/python3

import os, sys

prog = os.path.basename(sys.argv[0])
argc = len(sys.argv)
if argc != 3:
    print("\nInvalid argument.\nUsage: ", file=sys.stderr)
    print(f"   {prog} <xsd_file> <xml_file>", file=sys.stderr)
    sys.exit(1)
fn_xsd = sys.argv[1]  #"arconf.xsd"
fn_xml = sys.argv[2]  #"audio_routing_configuration.xml"

import xmlschema
xs = xmlschema.XMLSchema(fn_xsd)
xs.validate(fn_xml)
print("\nSchema validation is OK\n")

"""
1. check outchmap of dispatcher
2. check inchmap of data collector
3. module.type should be unique for same name
4. node in path should be defined in one of device, alsa or module
5. check inputportnum of data collector
6. check outputportnum of dispatcher
"""

mpath = {
    '[stream]':'.//devicesconf/device',
    '[device]':'.//alsaportsconf/port',
    '[module]':'.//moduleslist/module', 
    '[tmodule]':'.//moduleslist/module' 
}

def V(conn, nam, chmap):
    if not conn.get(chmap):
        for p in tree.iterfind('.//pathconf/path'):
            # check current connection belong to connections of a path
            if conn in p.findall('connections/connection'):
                print(f">>> path: {p.get('name')} didn't find {chmap} of [module]:{nam}")
                return

try:
    import xml.etree.cElementTree as e
except ImportError:
    import xml.etree.ElementTree as e

nodfr = []
nodto = []
cntfr = {}
cntto = {}
tree = e.ElementTree(file=fn_xml)
for c in tree.iterfind('.//connections/connection'):
    a,b = (c.attrib['from'], c.attrib['to'])
    nodfr.append(a)
    nodto.append(b)
    m,n = a.split(':')
    if m == '[module]':
        tt = set()
        for t in tree.iterfind(f"{mpath['[module]']}[@name='{n}']"):
            tt.add(t.get('type'))
        l = len(tt)
        if l > 1:
            print(f">>> module type of {a} should be unique")
        elif l == 1 and "MODULE_TYPE_DATA_DISPATCHER" in tt:
            V(c, n, 'outchmap')
            if n not in cntfr.keys(): cntfr[n] = set()
            cntfr[n].add(b)
        else:
            pass
    m,n = b.split(':')
    if m == '[module]':
        tt = set()
        for t in tree.iterfind(f"{mpath['[module]']}[@name='{n}']"):
            tt.add(t.get('type'))
        l = len(tt)
        if l > 1:
            print(f">>> module type of {b} should be unique")
        elif l == 1 and "MODULE_TYPE_DATA_COLLECTOR" in tt:
            V(c, n, 'inchmap')
            if n not in cntto.keys(): cntto[n] = set()
            cntto[n].add(a)
        else:
            pass

for n in set(nodfr).union(nodto):
    a,b = n.split(':')
    x = 'busaddress' if a == '[stream]' else 'name'
    t = f"{mpath[a]}[@{x}='{b}']"
    t = tree.findall(t)
    t or print(f">>> Undefined node: {n}")

def V1(n, c, typ):
    pn = {"dispatcher":"outputportnum", "data collector":"inputportnum"}[typ]
    t = tree.findall(f"{mpath['[module]']}[@name='{n}']")
    if len(t) > 1:
        print(f">>> {typ} module should not be redefined: {n}")
    else:
        l = int(t[0].get(pn))
        if l != c:
            print(f'>>> {pn} of module {n} is {l}, it should be {c}')

for n in cntfr.keys():
    V1(n, len(cntfr[n]), 'dispatcher')

for n in cntto.keys():
    V1(n, len(cntto[n]), 'data collector')

print("\nDone.")