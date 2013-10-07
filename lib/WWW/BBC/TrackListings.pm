package WWW::BBC::TrackListings;

# ABSTRACT: Get track listings for BBC radio programmes
# VERSION

use Moose;
use namespace::autoclean;

use Web::Scraper;
use URI;
use FindBin::libs;

use WWW::BBC::Track;

has 'url' => (
    is => 'ro',
    isa => 'Str',
);

has 'tracks' => (
    is => 'rw',
    isa => 'ArrayRef[WWW::BBC::Track]',
    traits => ['Array'],
    handles => {
        all_tracks => 'elements',
    },
    builder => '_build_tracks',
    lazy => 1,
);

sub _build_tracks {
    my ( $self ) = @_;

    my $tracks = scraper {
        process "li.track", "tracks[]" => scraper {
            process ".artist", artist => 'TEXT';
            process ".title", title => 'TEXT';
        };
    };

    my $res = $tracks->scrape( URI->new( $self->url ) );

    my @tracks;
    for my $track ( @{ $res->{tracks} } ) {
        push @tracks, WWW::BBC::Track->new({
            artist => $track->{artist},
            title => $track->{title},
        });
    }

    return \@tracks;
}

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 SYNOPSIS

  my $listings = WWW::BBC::TrackListings->new({ url => 'http://www.bbc.co.uk/programmes/b03c8l9l' });

  for my $track ( $listings->all_tracks ) {
    say $track->artist;
    say $track->title;
  }

=head1 DESCRITPION

Scrape of BBC radio programme pages to generate track listings.

=head1 METHODS

=head2 all_tracks

Returns all L<WWW::BBC::Track> listings of this programme.

=head1 ATTIRUBTES

=head2 url

=cut
