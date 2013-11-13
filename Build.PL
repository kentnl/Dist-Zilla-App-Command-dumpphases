
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.4200"
  },
  "configure_requires" => {
    "Module::Build" => "0.4200"
  },
  "dist_abstract" => "Dump a textual representation of each phase's parts.",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>",
    "Alan Young <harleypig\@gmail.com>",
    "Oliver Mengu\x{e9} <dolmen\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-App-Command-dumpphases",
  "dist_version" => "0.5.1",
  "license" => "perl",
  "module_name" => "Dist::Zilla::App::Command::dumpphases",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::App" => 0,
    "Dist::Zilla::Util::RoleDB" => 0,
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
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "1.001002"
  }
);


my %fallback_build_requires = (
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.4200",
  "Test::More" => "1.001002"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
