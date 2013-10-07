package WWW::BBC::Track;

use Moose;
use namespace::autoclean;

# ABSTRACT: An object repesenting a track in a BBC radio programme
# VERSION

has 'artist' => (
    is => 'ro',
    isa => 'Str',
);

has 'title' => (
    is => 'ro',
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 SYNOPSIS

  my $track = WWW::BBC::Track->new({ artist => 'Bonobo', title => 'Black Sands' })

=head1 METHODS

=head2 new

Constructor for objects of this class.

=head1 ATTRIBUTES

=head2 artist

=head2 title

=cut
