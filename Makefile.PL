
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Getopt::Flex',
                       'DISTNAME' => 'Getopt-Flex',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Ryan P. Kelly <rpkelly@cpan.org>',
                       'BUILD_REQUIRES' => {
                                             'Test::More' => '0',
                                             'Test::Warn' => '0',
                                             'Test::Exception' => '0'
                                           },
                       'ABSTRACT' => 'Option parsing, done differently',
                       'EXE_FILES' => [],
                       'VERSION' => '1.03',
                       'PREREQ_PM' => {
                                        'MooseX::StrictConstructor' => '0',
                                        'Clone' => '0',
                                        'Moose::Meta::TypeConstraint' => '0',
                                        'Moose::Util::TypeConstraints' => '0',
                                        'Moose' => '0',
                                        'Carp' => '0'
                                      },
                       'LICENSE' => 'mit'
                     );


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM}; 
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod}; 
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



