#!/usr/bin/env perl

use strict;
use warnings;

use Carp;

use Run_Helper qw(run_cmd);



@ARGV == 2 or die("Need exactly two arguments: release tag and message");

my $Rel_Tag = shift;
$Rel_Tag =~ /v\d+\.\d+(?:\.\d+)?$/ or croak("$Rel_Tag: invalid version release");
my $Rel_Msg = shift // "version tag for release $Rel_Tag";

run_cmd("git tag -a $Rel_Tag -m \"$Rel_Msg\"");
run_cmd("git push origin $Rel_Tag");


