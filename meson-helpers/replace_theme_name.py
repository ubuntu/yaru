#!/usr/bin/env python3

import sys

_, input_f, output_f, project_name = sys.argv

with open(output_f, 'w') as output:
    with open(input_f) as input:
        for s in input:
            output.write(s.replace("THEMENAME", project_name))
