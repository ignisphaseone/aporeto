#!/bin/bash

# If we don't have any args, or if we have help args, print the help message.
if [ -z $1 ] || [ "$1" == '-h' ] || [ "$1" == '--help' ]; then
    echo 'usage: bash_example.sh --create-file=<filename> [--no-prompt] [--verbose]'
    exit 1
fi

# Check every argument. If any of them match what we're looking for, set a flag.
for var in "$@"; do
    case $var in
        --verbose)
            VERBOSE=true
            ;;
        --no-prompt)
            NOPROMPT=1
            ;;
        --create-file=*)
            # If you find something that starts with `--create-file=`, then use bash string splitting to split it
            # based on the =.
            IFS='='; arrIN=($var); unset IFS;
            # If you split and get an empty string, reprint usage.
            if [ -z "${arrIN[1]}" ]; then
                echo 'usage: bash_example.sh --create-file=<filename> [--no-prompt] [--verbose]'
                exit 1
            fi
            # If you split and get a string of any sort (aka here), go time.
            OFILENAME="${arrIN[1]}"
            ;;
    esac
done
if [ -z $OFILENAME ]; then
    echo 'usage: bash_example.sh --create-file=<filename> [--no-prompt] [--verbose]'
    exit 1
fi

# File name check. Does it exist?
if [ -f $OFILENAME ]; then
    # Verbose check.
    if [ $VERBOSE ]; then
        echo 'File already exists'
    fi
    # Prompt loop. Only break on break (y) or exit (n).
    while true; do
        if [ "$NOPROMPT" = 1 ]; then
            break;
        fi
        read -p "File exists. Overwrite (y/n) ? " choice
        case $choice in
            y)
                rm $OFILENAME
                if [ $VERBOSE ]; then
                    echo "File removed"
                fi
                break
                ;;
            n)
                exit 1
                ;;
        esac
    done
fi

# Do the thing!
cat << STATES >$OFILENAME
Alabama
Alaska
Arizona
Arkansas
California
Colorado
Connecticut
Delaware
Florida
Georgia
Hawaii
Idaho
Illinois
Indiana
Iowa
Kansas
Kentucky
Louisiana
Maine
Maryland
Massachusetts
Michigan
Minnesota
Mississippi
Missouri
Montana
Nebraska
Nevada
New Hampshire
New Jersey
New Mexico
New York
North Carolina
North Dakota
Ohio
Oklahoma
Oregon
Pennsylvania
Rhode Island
South Carolina
South Dakota
Tennessee
Texas
Utah
Vermont
Virginia
Washington
West Virginia
Wisconsin
Wyoming
STATES
# If verbose, report status of thing.
if [ $VERBOSE ]; then
    echo 'File created'
fi
