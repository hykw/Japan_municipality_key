#!/bin/env python
# -*- coding: utf-8 -*-
from __future__ import (division, print_function, absolute_import, unicode_literals)

##################################################

SHEET_NAME = "H28.10.10現在の団体"

TSV_PREF = "prefs.tsv"
TSV_CITIES = "cities.tsv"

##################################################

import os
import os.path
import sys
import xlrd


def usage(cmd):
    print("""

Usage:

  {} 000318342.xls
    """[1:].format(cmd))


def delete_resource_files():
    for file in (TSV_PREF, TSV_CITIES):
        if os.path.exists(file):
            os.remove(file)


def get_sheet_obj(xls_file):
    book = xlrd.open_workbook(xls_file)
    sheet = book.sheet_by_name(SHEET_NAME)
    return sheet


def uncheck_sum(code):
    # 010006 -> 01000
    return code[0:5]


def split_cells(sheet, row):
    code = uncheck_sum(sheet.cell(row,0).value.strip())
    pref = sheet.cell(row,1).value.strip()
    city = sheet.cell(row,2).value.strip()

    return [code, pref, city]


def write_pref(code, pref):
    pref_code = code[0:2]
    tsv = "\t".join( (pref, pref_code) ) + "\n"

    with open(TSV_PREF, 'a') as f:
        f.write(tsv.encode("utf-8"))


def write_cities(cities):
    tsv = "\t".join(cities) + "\n"
    with open(TSV_CITIES, 'a') as f:
        f.write(tsv.encode("utf-8"))

##################################################

if len(sys.argv) != 2:
    usage(sys.argv[0])
    exit(1)

delete_resource_files()

before_pref = ""
cities = []
sheet = get_sheet_obj(sys.argv[1])
for row in range(1, sheet.nrows):
    code, pref, city = split_cells(sheet, row)

    if city == "":
        write_pref(code, pref)
    else:
        if before_pref == pref:
            cities += [",".join( (code, pref, city) )]
        else:
            before_pref = pref
            if cities != []:
                write_cities(cities)
                cities = []

            cities += [",".join( (code, pref, city) )]

write_cities(cities)
