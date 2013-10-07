package WebService::BBC::Track;

use Moose;
use namespace::autoclean;

has 'artist';
has 'title';

__PACKAGE__->meta->make_immutable;
