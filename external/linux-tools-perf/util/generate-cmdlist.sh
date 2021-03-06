#!/bin/sh

PREFIX="$1"

echo "/* Automatically generated by $0 */
struct cmdname_help
{
    char name[16];
    char help[80];
};

static struct cmdname_help common_cmds[] = {"

sed -n -e 's/^perf-\([^ 	]*\)[ 	].* common.*/\1/p' ${PREFIX}/command-list.txt |
sort |
while read cmd
do
     sed -n '
     /^NAME/,/perf-'"$cmd"'/H
     ${
            x
            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
	    p
     }' "${PREFIX}/Documentation/perf-$cmd.txt"
done
echo "};"
