#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Spec::Functions;


use lib catdir($FindBin::Bin, 'lib');
use GH_Data qw(set_creds);
use Run_Helper qw(run_cmd);

use GH_Data qw(get_uname_email_from_url set_creds);
use Run_Helper qw(run_cmd);

@ARGV == 1 or die("Need exactly one argument: uname");

my ($uname) = @ARGV;

run_cmd("git init -b main");
set_creds($uname);
print("\nYou may need to run set_pat.sh to be able to push\n");

__END__

