#!/usr/bin/python

from sys import argv
import csv

print_both = False
print_ignored = False
if len(argv) < 3:
    print("Error: provide filenames to compare.")
    sys.exit(1)
if len(argv) >= 4:
    if '--all' in argv:
        print_both = True
        print_ignored = True
    if '--ignored' in argv:
        print_ignored = True
    if '--both' in argv:
        print_both = True

file1 = open(argv[1], 'r')
file2 = open(argv[2], 'r')
reader1 = csv.reader(file1, delimiter=",")
reader2 = csv.reader(file2, delimiter=",")
l1 = []
l2 = []
l3 = []
l4 = []
for line in reader1:
    l1.append(line[0].lower())
for line in reader2:
    l2.append(line[0].lower())
for i in range(len(l1)-1, -1, -1):
    temp = l1[i]
    if 'hc' not in temp:
        l1.pop(i)
        if print_ignored:
            l4.append(temp)
    elif temp in l2:
        l1.pop(i)
        l2.remove(temp)
        if print_both:
            l3.append(temp)

for i in range(len(l2)-1,-1,-1):
    temp = l2[i]
    if 'hc-' not in temp:
        l2.pop(i)
        if print_ignored:
            l4.append(temp)

l1.sort()
l2.sort()
l3.sort()
print("Items in " + argv[1] + " not in " + argv[2] + ":")
for item in l1:
    print(item)
print("Items in " + argv[2] + " not in " + argv[1] + ":")
for item in l2:
    print(item)
if print_both:
    print("Items in both:")
    for item in l3:
        print(item)
if print_ignored:
    print("Ignored items:")
    for item in l4:
        print(item)
file1.close()
file2.close()
