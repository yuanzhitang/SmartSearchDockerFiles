import os
import locale

locale.setlocale(locale.LC_ALL, 'en_US')

print("The following files are visible under your usercode on the MCP")
sum = 0
# Iterate over MCP files the Python way
for root, dirs, files in os.walk('M:\\'):
    for f in files:
        fqn = os.path.join(root, f)
        filesize = os.path.getsize(fqn)
        sum = sum + filesize

        print((format(fqn, "s")) + ' size is ' +
              locale.format_string("%d", filesize, grouping=True))

print('Total size = ' + locale.format_string("%d", sum, grouping=True))
