use strict;
use warnings;
use utf8;

my @files = glob("main-*.sh");

my $first = 1;
foreach my $f (@files) {
    next unless ($f =~ /\Amain-([-a-z0-9]+)\.sh\z/);
    my $action = $1;
    if ($first) {
        print "ICHIPACK_ACTION=\n";
        print "if [ \"\$1\" = \"$action\" ]; then\n";
        $first = '';
    } else {
        print "elif [ \"\$1\" = \"$action\" ]; then\n";
    }
    print "    ICHIPACK_ACTION=\$1\n";
}
if ($first) {
    print ". \$WORKING_DIR/main.sh\n";
} else {
    print "fi\n";
    print "if [ -n \"\$ICHIPACK_ACTION\" ]; then\n";
    print "    shift\n";
    print "    . \$WORKING_DIR/main-\$ICHIPACK_ACTION.sh\n";
    print "else\n";
    print "    . \$WORKING_DIR/main.sh\n";
    print "fi\n";
}

