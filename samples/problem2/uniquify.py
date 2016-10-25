#!/usr/bin/env python
import argparse

# Parse arguments.
parser = argparse.ArgumentParser(description="Remove duplicate lines from `file`, write file to `output`.")
parser.add_argument('--ifname', help="Input filename.")
parser.add_argument('--output', help="Output filename.")
parser.add_argument('--verbose', help="Verbose mode.", action="store_true")

# Do the things.
def main():
    args = parser.parse_args()
    # If we don't have "optional" arguments, spit them back here.
    if not args.ifname and not args.output:
        parser.print_usage()
        exit(1)

    # Store each line as a set. Sets enforce uniqueness.
    lines = set()
    ifname = str(args.ifname)
    # Open the input file.
    with open(ifname, 'r') as ifile:
        if args.verbose:
            print "--opened `{}`, reading file...".format(ifname)
        for line in ifile:
            # Add each line to the set. Uniqueness will be enforced at data-structure level.
            lines.add(line.strip())

    # TODO: Add a sort for output?
    # Write to output file.
    ofname = str(args.output)
    with open(ofname, 'w') as ofile:
        if args.verbose:
            print "--opened `{}`, writing file...".format(ofname)
        for line in lines:
            ofile.write(line + '\n')

if __name__ == '__main__':
    main()

