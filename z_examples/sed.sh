#! /bin/bash
# delete blank line and <!--* -->
#<!-- and --> must in same line!
/^[ \t]*$/d
/^[ \t]*<!--.*-->$/d
