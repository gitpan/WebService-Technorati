package WebService::Technorati::SearchTerm;
use strict;
use utf8;

use WebService::Technorati::BaseTechnoratiObject;
use base 'WebService::Technorati::BaseTechnoratiObject';

use fields qw(inboundblogs query querycount querytime rankingstart);

use WebService::Technorati::Blog;

{
    my %_attrs = (
        inboundblogs => undef,
        query => undef,
        querycount => undef,
        querytime => undef,
        rankingstart => undef
    );
    sub _accessible { exists $_attrs{$_[1]} }
}

sub new_from_node {
	my $class = shift;
	my $node = shift;
	my $data = {
		inboundblogs => $node->findvalue('inboundblogs')->string_value(),
        query => $node->findvalue('query')->string_value(),
        querycount => $node->findvalue('querycount')->string_value(),
        querytime => $node->findvalue('querytime')->string_value(),
        rankingstart => $node->findvalue('rankingstart')->string_value(),
	};
	my $self = bless ($data, ref ($class) || $class);
	return $self;
}

1;

