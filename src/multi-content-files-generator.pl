use strict;
use warnings;
use utf8;

use File::Basename qw/dirname/;

sub do_file_writer {
    my ($fpath) = @_;

    while () {
        my $dirname = dirname($fpath);
        if ($dirname ne ".") {
            print "mkdir -p $dirname\n";
        }

        my $CHILD_READER;
        my $PARENT_WRITER;
        pipe($CHILD_READER, $PARENT_WRITER);
        my $pid = fork;
        if ($pid) {
            # 親プロセスの場合
            close $CHILD_READER;
            $fpath = undef;
            while (<STDIN>) {
                if (/^##file\s+(.+)$/) {
                    $fpath = $1;
                    last;
                }
                print $PARENT_WRITER $_;
            }
            close $PARENT_WRITER;
            wait;
            if (!defined($fpath)) {
                last;
            }
        } elsif (defined $pid) {
            # 子プロセスの場合
            close $PARENT_WRITER;
            open(STDIN, '<&=', fileno($CHILD_READER));
            exec("sh", "$ENV{WORKING_DIR}/src/file-writer.sh", "-", $fpath);
        } else {
            # fork失敗の場合
            die;
        }
    }
}

do_file_writer("main.sh");

