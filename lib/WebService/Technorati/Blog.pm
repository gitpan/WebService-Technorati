package WebService::Technorati::Blog;
use strict;
use utf8;

use fields qw(url name rssurl atomurl inboundblogs inboundlinks lastupdate lat lon rank);

use WebService::Technorati::BaseTechnoratiObject;
use base 'WebService::Technorati::BaseTechnoratiObject';

{
    my %_attrs = (
        url => undef,
        name => undef,
        rssurl => undef,
        atomurl => undef,
        inboundblogs => undef,
        inboundlinks => undef,
        lastupdate => undef,
        lat => undef,
        lon => undef,
        rank => undef
    );
    sub _accessible { exists $_attrs{$_[1]} }
}

sub new_from_node {
    my $class = shift;
    my $node = shift;
    my $data = {
        url => $node->findvalue('url')->string_value(),
        name => $node->findvalue('name')->string_value(),
        rssurl => $node->findvalue('rssurl')->string_value(),
        atomurl => $node->findvalue('atomurl')->string_value(),
        inboundblogs => $node->findvalue('inboundblogs')->string_value(),
        inboundlinks => $node->findvalue('inboundlinks')->string_value(), 
        lastupdate => $node->findvalue('lastupdate')->string_value(),
        lat => $node->findvalue('lat')->string_value(),
        lon => $node->findvalue('lon')->string_value(),
        rank => $node->findvalue('rank')->string_value()
    };
    my $self = bless ($data, ref ($class) || $class);
    return $self;
}

1;

