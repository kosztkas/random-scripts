#!/usr/bin/python
import argparse
import csv
import json

import pyjq

from getprice import getPrice


def main():
    from sys import argv, stderr
    #create an argument parser
    parser = argparse.ArgumentParser(description='Generate Alibaba cloud isntance price based on simple configuration details')
    parser.add_argument('-x', '--exclude', action='store_true', help='Exclude burstable instances')
    parser.add_argument('-v', '--verbose', action='store_true', help='Go through the detail questions')
    parser.add_argument('-c', '--cpu', type=str, action='store', dest='cpu0', help="Number of CPU's for the instance")
    parser.add_argument('-m', '--memory', type=str, action='store', dest='mem0', help="Instance memory in GB")
    parser.add_argument('-d', '--disk', type=int, action='store', dest='disk0', help="Instance data disk 1 in GB")
    args = parser.parse_args()

    #create an empty dictionary for the results
    data = {}
    cpu = mem = disk = 0

    if args.verbose:
        #input number of CPU's
        cpu = raw_input('Enter number of CPUs:\n')
        #input amount of memory in GB
        mem = raw_input('Enter memory in GB:\n')
        #input amount of 1 disk
        disk = raw_input('Enter data disk 1 size:\n')
    else:
        cpu = args.cpu0
        mem = args.mem0
        disk = args.disk0

    #read csv, and split the line on ","
    csv_file = csv.reader(open('instances.csv', "rb"), delimiter= ",")


    #loop through csv list
    for row in csv_file:
        #if current rows 2nd value is equal to input, print that row
        if cpu == row[1] and mem == row[2]: # and not (args.exclude and row[0].startswith( 'ecs.t5' )): # if need to exclude the burstable t5 instances
            data[str(row[0])]= 0

    for key in data:
        value = getPrice(key,disk)
        price = pyjq.first('.PriceInfo.Price.TradePrice', value)
        data[key]=price
        #print(price)

    print ('\nInstance :           Price/M (USD)')
    for key,val in data.items():
        print key, " : ", val

if __name__ == '__main__':
    main()
