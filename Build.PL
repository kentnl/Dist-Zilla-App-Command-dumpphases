
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => "0.88"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Dump a textual representation of each phase's parts.",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>",
    "Alan Young <harleypig\@gmail.com>"
  ],
  "dist_name" => "Dist-Zilla-App-Command-dumpphases",
  "dist_version" => "0.1.1",
  "license" => "perl",
  "module_name" => "Dist::Zilla::App::Command::dumpphases",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::App" => 0,
    "Moose::Autobox" => 0,
    "Scalar::Util" => 0,
    "Term::ANSIColor" => 0,
    "Try::Tiny" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
