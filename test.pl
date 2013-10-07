#!perl

use strict;
use warnings;

use feature 'say';

use URI;
use Web::Scraper;

binmode(STDOUT, ":utf8");

my $tracks = scraper {
    process "li.track", "tracks[]" => scraper {
        process ".artist", artist => 'TEXT';
        process ".title", title => 'TEXT';
    };
};

my $res = $tracks->scrape( URI->new("http://www.bbc.co.uk/programmes/b03c8l9l") );

for my $track ( @{ $res->{tracks} } ) {
    say $track->{artist} . " - " . $track->{title};
}
