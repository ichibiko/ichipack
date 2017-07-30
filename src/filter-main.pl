use strict;
use warnings;
use utf8;

while (<STDIN>) {
    last if (/\A\s*exec\s+/);
}

while (<STDIN>) {
    print;
}

