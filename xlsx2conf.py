__version__ = "1.0.0"
__version_info__ = (1, 0, 0)
__license__ = "Unlicense"
__author__ = 'Gu Jianzhong <jianzhong.gu@harman.com>'

import openpyxl
from collections import OrderedDict

wb = openpyxl.load_workbook('xbar-config.xlsx',data_only=True,read_only=True)

ws_names = ['inputs','zone0-in','zone-out','output-devices','connects']

jsonDict = OrderedDict()
for name in ws_names:
    ws = wb[name]
    max_col = ws.max_column
    rows = list(ws.rows)
    names = []
    for c in rows[0]:
        if c.value is None: break
        names.append(c.value)
    max_col = len(names)
    #print(u','.join([str(c.value) for c in rows[0][:max_col]]))
    print(names)

    conf = []
    for r in rows[1:]:
        if r[0].value is None: break
        nvs = zip(names, [c.value for c in r][:max_col])
        nvdict = dict((n,v) for n,v in nvs)
        #print(u','.join([str(c.value) for c in r][:max_col]))
        #print(nvdict)
        conf.append(nvdict)
    jsonDict['crossbar-'+name] = conf

wb.close()
import json
with open('auto-xbar.conf', 'w') as f:
    json.dump(jsonDict, f, indent=4)
    f.close()
