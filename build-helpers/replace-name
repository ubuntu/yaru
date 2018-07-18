#!/usr/bin/env python3

import sys

print(sys.argv)
_, input_f, output_f, generic_name, project_name = sys.argv

with open(output_f, 'w') as output:
    with open(input_f) as input:
        for s in input:
            output.write(s.replace(generic_name, project_name))
