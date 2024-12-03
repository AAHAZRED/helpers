#!/usr/bin/env perl

use strict;
use warnings;

use Carp;

use FindBin;
use File::Spec::Functions;


use lib catdir($FindBin::Bin, 'lib');
use File::chdir;

use GH_Data qw(get_uname_email_from_url set_creds);
use Run_Helper qw(run_cmd);


@ARGV == 1 or die("Need exactly one argument: URL");

my $URL = shift;
$URL =~ m!/([^/]+?)(?:\.git)$! or croak("$URL: Unrecognized URL");
my $Git_Dir = $1;
my ($UName, $EMail) = get_uname_email_from_url($URL);

run_cmd("git clone $URL");
local $CWD = $Git_Dir;
set_creds($UName, $EMail);



__END__


=pod


=head1 NAME

clone.sh - clones a github repo and configs it (arg: github URL).


=head1 SYNOPSIS

  clone.sh URL

=head1 DESCRIPTION

Clones a github repo I<C<URL>> and configs it.


=cut






