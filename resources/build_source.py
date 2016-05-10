#!/bin/env python
# -*- coding: utf-8 -*-
from __future__ import (division, print_function, absolute_import, unicode_literals)


SHEET_NAME = "H26.4.5現在の団体"

##################################################
import sys
import xlrd

def usage(cmd):
    print("""

Usage:

  {} 000318342.xls > municipality.tsv
    """[1:].format(cmd))


def get_sheet_obj(xls_file):
    book = xlrd.open_workbook(xls_file)
    sheet = book.sheet_by_name(SHEET_NAME)
    return sheet


def print_cells(cell_data):
    tsv = "\t".join(map(unicode, cell_data))
    print(tsv.encode("utf-8"))

##################################################

if len(sys.argv) != 2:
    usage(sys.argv[0])
    exit(1)

sheet = get_sheet_obj(sys.argv[1])
for row in range(1, sheet.nrows):
    cell_data = []

    for col in range(3):
        cell = sheet.cell(row,col).value
        cell_data += [cell]

    print_cells(cell_data)
