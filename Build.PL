
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.4007"
  },
  "configure_requires" => {
    "Module::Build" => "0.4007"
  },
  "dist_abstract" => "Dump a textual representation of each phase's parts.",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>",
    "Alan Young <harleypig\@gmail.com>",
    "Oliver Mengu\303\251 <dolmen\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-App-Command-dumpphases",
  "dist_version" => "0.3.1",
  "license" => "perl",
  "module_name" => "Dist::Zilla::App::Command::dumpphases",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::App" => 0,
    "Module::Runtime" => 0,
    "Moo" => 0,
    "Moose::Autobox" => 0,
    "Role::Tiny" => 0,
    "Scalar::Util" => 0,
    "Term::ANSIColor" => 0,
    "Try::Tiny" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "Capture::Tiny" => 0,
    "Test::More" => "0.98",
    "blib" => 0
  }
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  my $tr = delete $module_build_args{test_requires};
  my $br = $module_build_args{build_requires};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
