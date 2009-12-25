
use strict;
use warnings;



use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Getopt-Flex',
  NAME      => 'Getopt::Flex',
  AUTHOR    => "Ryan\ P\.\ Kelly\ \<rpkelly\@cpan\.org\>",
  ABSTRACT  => "Option\ parsing\,\ done\ differently",
  VERSION   => '0.70',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'mit') : ()),
  PREREQ_PM    => {
    "File::Find::Rule" => '0',
    "Test::Exception" => '0',
    "Imager" => '0',
    "Moose::Meta::TypeConstraint" => '0',
    "Moose::Util::TypeConstraints" => '0',
    "Carp" => '0',
    "Test::More" => '0',
    "Image::ExifTool" => '0',
    "Test::Warn" => '0',
    "MooseX::StrictConstructor" => '0',
    "Time::Format" => '0',
    "Clone" => '0',
    "Moose" => '0',
  },
  test => {TESTS => 't/*.t'}
);

