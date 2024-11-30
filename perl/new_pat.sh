#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Spec::Functions;

use lib catdir($FindBin::Bin, 'lib');

use GH_Data qw(get_gh_url github_data get_usr_data_from_url);
use Run_Helper qw(run_cmd);

@ARGV == 0 or die("This script takes no arguments");

my $URL = get_gh_url();
my ($UName, $Repo) = get_usr_data_from_url($URL);
my $PAT = (github_data($UName))[1];
$Repo .= ".git" unless $Repo =~ /\.git$/;
my $New_URL = "https://${UName}:${PAT}\@github.com/${UName}/$Repo";
run_cmd("git remote set-url origin $New_URL");



__END__


=pod


=head1 NAME

new_pat.pl - Set new personal access token (PAT) in local git repo.


=head1 SYNOPSIS

  new_pat.pl

=head1 DESCRIPTION

Call this script in your local git repo. The new PAT is taken from yout
config. The script performs a C<git remote set-url> call to set the new PAT in
this local repo.


=cut

