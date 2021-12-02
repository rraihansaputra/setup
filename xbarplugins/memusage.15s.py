#!/usr/bin/env python
# <bitbar.title>Memory usage</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Gautam krishna R</bitbar.author>
# <bitbar.author.github>gautamkrishnar</bitbar.author.github>
# <bitbar.desc>Shows the current system memmory usage.</bitbar.desc>
# <bitbar.dependencies>python</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/matryer/bitbar-plugins/blob/master/System/memusage.5s.py</bitbar.abouturl>
import subprocess
import re

# Get process info
ps = subprocess.Popen(['ps', '-caxm', '-orss,comm'], stdout=subprocess.PIPE).communicate()[0]
vm = subprocess.Popen(['vm_stat'], stdout=subprocess.PIPE).communicate()[0]
vms = subprocess.Popen(['sysctl', 'vm.swapusage'], stdout=subprocess.PIPE).communicate()[0]
vmc = subprocess.Popen(['sysctl', 'vm.compressor_bytes_used'], stdout=subprocess.PIPE).communicate()[0]

# Iterate processes
processLines = ps.split('\n')
sep = re.compile('[\s]+')
rssTotal = 0 # kB
for row in range(1,len(processLines)):
    rowText = processLines[row].strip()
    rowElements = sep.split(rowText)
    try:
        rss = float(rowElements[0]) * 1024
    except:
        rss = 0 # ignore...
    rssTotal += rss

# Process vm_stat
vmLines = vm.split('\n')
sep = re.compile(':[\s]+')
vmStats = {}
for row in range(1,len(vmLines)-1):
    rowText = vmLines[row].strip()
    rowElements = sep.split(rowText)
    vmStats[(rowElements[0])] = int(rowElements[1].strip('\.')) * 4096

# process sysctl vm.swapusage
vmsValues = vms.split(':')[1].split('  ')[:3]
swapTotal = vmsValues[0].strip()
swapUsed = vmsValues[1]
swapFree = vmsValues[2]

print 'ALL: %d MB' % ( (vmStats["Pages wired down"] + vmStats["Pages active"] + int(vmc.split()[1])) /1024/1024 )
print 'W+A: %d MB' % ( vmStats["Pages wired down"]/1024/1024 + vmStats["Pages active"]/1024/1024 )
print '---'
print 'Swap ' + swapUsed
print 'Wired Memory:\t%d MB' % ( vmStats["Pages wired down"]/1024/1024 )
print 'Active Memory:\t%d MB' % ( vmStats["Pages active"]/1024/1024 )
print 'Compressed: \t %d MB' % ( int(vmc.split()[1])/1024/1024 )
print 'Swapins: \t%d MB'% ( vmStats["Swapins"]/1024/1024 )
print 'Swapouts: \t%d MB'% ( vmStats["Swapouts"]/1024/1024 )
# print 'Inactive Memory:\t%d MB' % ( vmStats["Pages inactive"]/1024/1024 )
# print 'Free Memory:\t\t%d MB' % ( vmStats["Pages free"]/1024/1024 )
print 'Real Mem Total (ps):\t%.3f MB' % ( rssTotal/1024/1024 )
print 'Swap ' + swapTotal
print 'Swap ' + swapFree
