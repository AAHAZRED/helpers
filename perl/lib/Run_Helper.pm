package Run_Helper;
use strict;
use warnings;

use Carp;
use Exporter 'import';

our @EXPORT_OK = qw(run_cmd);

sub run_cmd {
  my $cmd = shift;
  print("Running: $cmd\n");
  system($cmd) == 0 or croak("Failed running  $cmd");
}


1;


