package GH_Data;
use strict;
use warnings;

use Carp;
#use FindBin;
use Cwd qw(realpath);
use File::Basename;
use File::Spec::Functions qw(canonpath catdir catfile);
use Exporter 'import';

use Run_Helper qw(run_cmd);
#use Data::Dumper;

use Config::INI::RefVars;

my $INI_file = catfile(realpath(catdir(dirname(__FILE__), ('..') x 2)), 'github.ini');


#
# use Config::INI::RefVars;
# my $h = Config::INI::RefVars->new(...)->parse_ini(src => $my_ini_file)->variables;
#

our @EXPORT_OK = qw(get_gh_url
                    github_data
                    get_usr_data_from_url
                    get_user_data
                    get_uname_email_from_url
                    get_origin_url
                    set_creds);

my $Github_Data = Config::INI::RefVars->new()->parse_ini(src => $INI_file)->variables;

my %Repo_Data;

sub get_gh_url {
  my $url = `git remote get-url origin`;
  if ($? == -1) {
    die("Failed to execute: $!\n");
  }
  elsif ($? & 127) {
    die(sprintf("Child died with signal %d, %s coredump\n",
                ($? & 127), ($? & 128) ? 'with' : 'without'));
  }
  chomp($url);
  return $url;
}

sub github_data {
  @_ == 1 or croak("Wrong number of arguments");
  my $usr = shift // croak("Argument is undef");
  croak("Argument must be a scalar") if ref($usr);
  croak("'$usr' - unknown argument") if !exists($Github_Data->{$usr});
  return @{$Github_Data->{$usr}}{qw(email PAT)};
}


sub get_usr_data_from_url {
  my $url = shift;
  $url =~ m!github.com/(.*?)/(.*)! or croak("Invalid URL");
  return ($1, $2);  # username, REPO.git
}

# from repo
sub get_user_data {
  my $url = `git remote get-url origin`;
  if ($?) {
    die("Failed to execute get-url");
  }
  chomp($url);
  return get_usr_data_from_url($url);
}

sub get_uname_email_from_url {
  my $url = shift;
  my $uname = (get_usr_data_from_url($url))[0];
  croak("$uname: unknown user") unless exists($Github_Data->{$uname});
  return ($uname, $Github_Data->{$uname}{email});
}

sub get_origin_url {
  my $usr = shift;
  my ($email, $pat) = github_data($usr);
#  $url =~ m!github.com/(.*?)/(.*)!;
}

sub set_creds {
  my ($uname, $email) = @_;
  if (!defined($email)) {
    croak("'$uname' - unknown argument") if !exists($Github_Data->{$uname});
    $email = $Github_Data->{$uname}
  }
  run_cmd("git config credential.helper store");
  run_cmd("git config user.email $email");
  run_cmd("git config user.name $uname");
}


1;



