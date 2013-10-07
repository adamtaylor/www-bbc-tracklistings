package WebService::BBC::TrackingListings;

use Moose;
use namespace::autoclean;

use Web::Scraper;
use FindBin::libs;

use WebService::BBC::Track;

has 'url';

has 'tracks' => (
    isa => 'ArrayRef[WebService::BBC::TrackListings::Track]',
    traits => ['Array'],
    handles => {
        add_track => 'push',
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

    for my $track ( @{ $res->{tracks} } ) {
        $self->add_track(
            WebService::BBC::Track->new({
                artist => $track->{artist},
                title => $track->{title},
            })
        );

    }
}

__PACKAGE__->meta->make_immutable;
