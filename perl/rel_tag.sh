#!/usr/bin/env perl

use strict;
use warnings;

use Carp;

use Run_Helper qw(run_cmd);



@ARGV == 2 or die("Need exactly two arguments: release tag and message");

my $New_Tag = shift;
$New_Tag =~ /v\d+\.\d+(?:\.\d+)?$/ or croak("$New_Tag: invalid version release");
my $Rel_Msg = shift // "version tag for release $New_Tag";

run_cmd("git tag -a $New_Tag -m \"$Rel_Msg\"");
run_cmd("git push origin $New_Tag");


__END__


=pod


=head1 NAME

new_tag.sh - Create and push a tag


=head1 SYNOPSIS

  new_tag.sh MY_TAG MY_MESSAGE


=head1 DESCRIPTION

Creates and pushes a new git tag.


=cut

