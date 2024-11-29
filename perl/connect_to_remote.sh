#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Spec::Functions;


use lib catdir($FindBin::Bin, 'lib');
use Run_Helper qw(run_cmd);

@ARGV == 1 or die("Script needs exactly one argument (github URL)");

my $URL = shift;

run_cmd("git remote add origin $URL");
run_cmd("git remote set-url origin");

