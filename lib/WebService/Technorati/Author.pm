package WebService::Technorati::Author;
use strict;
use utf8;

use fields qw(firstname lastname username thumbnailpicture);

use WebService::Technorati::BaseTechnoratiObject;
use base 'WebService::Technorati::BaseTechnoratiObject';

{
    my %_attrs = (
        firstname => undef,
        lastname => undef,
        username => undef,
        thumbnailpicture => undef
    );
    sub _accessible { exists $_attrs{$_[1]} }
}

sub new_from_node {
	my $class = shift;
	my $node = shift;
	my $data = {
		firstname => $node->findvalue('firstname')->string_value(),
        lastname => $node->findvalue('lastname')->string_value(),
        username => $node->findvalue('username')->string_value(),
        thumbnailpicture => $node->findvalue('thumbnailpicture')->string_value()
	};
	my $self = bless ($data, ref ($class) || $class);
	return $self;
}

1;

