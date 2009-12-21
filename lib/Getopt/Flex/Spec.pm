package Getopt::Flex::Spec;
our $VERSION = '0.22';

# ABSTRACT: Getopt::Flex's way of handling an option spec

use Moose;
use Getopt::Flex::Spec::Argument;
use MooseX::StrictConstructor;

#the raw specification            
has 'spec' => (
    is => 'ro',
    isa => 'HashRef[HashRef[Str|CodeRef|ScalarRef|ArrayRef|HashRef]]',
    required => 1,
);

#maps the various argument aliases onto their argument object
has '_argmap' => (
    is => 'rw',
    isa => 'HashRef[Getopt::Flex::Spec::Argument]',
    default => sub { {} },
    init_arg => undef,
);
                
                
sub BUILD {
    my ($self) = @_;
    
    my $spec = $self->spec();
    
    my $argmap = $self->_argmap();
    
    #create each argument in turn
    foreach my $switch_spec (keys %{$spec}) {
        $spec->{$switch_spec}->{'switchspec'} = $switch_spec;
        
        my $argument = Getopt::Flex::Spec::Argument->new($spec->{$switch_spec});
        
        my @aliases = @{$argument->aliases()};
        
        #map each argument onto its aliases
        foreach my $alias (@aliases) {
            #no duplicate aliases (or primary names) allowed
            if(defined($argmap->{$alias})) {
                my $sp = $argmap->{$alias}->switchspec();
                Carp::confess "alias $alias given by spec $switch_spec already exists and belongs to spec $sp\n";
            }
            $argmap->{$alias} = $argument;
        }
    }
    $self->_argmap($argmap);
}


sub check_switch {
    my ($self, $switch) = @_;
    return defined($self->_argmap()->{$switch});
}


sub set_switch {
    my ($self, $switch, $val) = @_;
    
    Carp::confess "No such switch $switch\n" if !$self->check_switch($switch);
    
    return $self->_argmap()->{$switch}->set_value($val);
}


sub switch_requires_val {
    my ($self, $switch) = @_;
    
    Carp::confess "No such switch $switch\n" if !$self->check_switch($switch);
    
    return $self->_argmap()->{$switch}->requires_val();
}


sub get_switch_error {
    my ($self, $switch) = @_;
    
    Carp::confess "No such switch $switch\n" if !$self->check_switch($switch);
    
    return $self->_argmap()->{$switch}->error();
}


no Moose;

1;

__END__
=pod

=head1 NAME

Getopt::Flex::Spec - Getopt::Flex's way of handling an option spec

=head1 VERSION

version 0.22

=head1 DESCRIPTION

This class is only meant to be used by Getopt::Flex
and should not be used directly.

=head1 NAME

Getopt::Flex::Spec - Specification class for Getopt::Flex

=head1 METHODS

=head2 check_switch

Check whether or a not a switch belongs to this specification

=head2 set_switch

Set a switch to the supplied value

=head2 switch_requires_val

Check whether or not a switch requires a value

=head2 get_switch_error

Given a switch return any associated error message.

=for Pod::Coverage   BUILD

=head1 AUTHOR

  Ryan P. Kelly <rpkelly@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Ryan P. Kelly.

This is free software, licensed under:

  The MIT (X11) License

=cut

