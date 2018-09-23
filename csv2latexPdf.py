import csv
import datetime
from reportlab.lib.units import cm, inch
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.platypus import *
from reportlab.lib.styles import getSampleStyleSheet

# Data from CSV
with open('bookInfo.csv', "r") as csvfile:
    data = list(csv.reader(csvfile))

elements = []

# PDF Text
# PDF Text - Styles
styles = getSampleStyleSheet()
styleNormal = styles['Normal']

# PDF Text - Content
line1 = ''

elements.append(Paragraph(line1, styleNormal))

# PDF Table
# PDF Table - Styles
# [(start_column, start_row), (end_column, end_row)]
all_cells = [(0, 0), (-1, -1)]
header = [(0, 0), (-1, 0)]
column0 = [(0, 0), (0, -1)]
column1 = [(1, 0), (1, -1)]
column2 = [(2, 0), (2, -1)]
column3 = [(3, 0), (3, -1)]
column4 = [(4, 0), (4, -1)]
column5 = [(5, 0), (5, -1)]
#column6 = [(6, 0), (6, -1)]
table_style = TableStyle([
    ('VALIGN', all_cells[0], all_cells[1], 'TOP'),
    ('LINEBELOW', header[0], header[1], 1, colors.black),
    ('ALIGN', column0[0], column0[1], 'RIGHT'),
    ('ALIGN', column1[0], column1[1], 'LEFT'),
    ('ALIGN', column2[0], column2[1], 'LEFT'),
    ('ALIGN', column3[0], column3[1], 'LEFT'),
    ('ALIGN', column4[0], column4[1], 'LEFT'),
    ('ALIGN', column5[0], column5[1], 'LEFT'),
    #('ALIGN', column6[0], column6[1], 'LEFT'),
    #('ALIGN', column4[0], column4[1], 'LEFT'),
    #('ALIGN', column5[0], column5[1], 'LEFT'),
    #('ALIGN', column6[0], column6[1], 'LEFT'),
])

# PDF Table - Column Widths
colWidths = [
    2.5 * cm,  # Column 1
    4.1 * cm,  # Column 2
    4.1 * cm,  # Column 3
    4.1 * cm,  # Column 4
    4.1 * cm,  # Column 5
    5.1 * cm,  # Column 6
    #3 * cm,  # Column 7
    #2.1 * cm,  # Column 8
    #2.5 * cm,  # Column 9
    #2 * cm,  # Column 10
]
    
# PDF Table - Strip '[]() and add word wrap to column 5
for index, row in enumerate(data):
    for col, val in enumerate(row):
        if col != 1 or index == 0:
            data[index][col] = val.strip("'[]()")
        else:
            data[index][col] = Paragraph(val, styles['Normal'])

# Add table to elements
t = Table(data, colWidths=colWidths)
t.setStyle(table_style)
elements.append(t)

# Generate PDF
archivo_pdf = SimpleDocTemplate(
    'referenceBooks.pdf',
    pagesize=letter,
    rightMargin=40,
    leftMargin=40,
    topMargin=40,
    bottomMargin=28)
archivo_pdf.build(elements)
print('books generated')
