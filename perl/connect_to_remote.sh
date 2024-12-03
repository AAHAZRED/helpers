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



__END__


=pod


=head1 NAME

connect_to_remote.sh - Connect local git repo to remote (arg: github URL).


=head1 SYNOPSIS

  connect_to_remote.sh URL


=head1 DESCRIPTION

You must already have a local git repo. Chdir to it and run C<connect_to_remote.sh URL> where
I<C<URL>> is the URL of a github repo. The local repo will be connected to remote one.


=cut


