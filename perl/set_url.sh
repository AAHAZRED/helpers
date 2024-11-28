#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Spec::Functions;


use lib catdir($FindBin::Bin, 'lib');
use GH_Data qw(github_data get_user_data);

my ($UName, $Repo) = get_user_data();
my $PAT = (github_data($UName))[1];
my $URL = "https://$UName:$PAT\@github.com/$UName/$Repo";
my $Cmd = "git remote set-url origin $URL";
print("Running: $Cmd\n");
system($Cmd) == 0 or die("Failed running  $Cmd");



