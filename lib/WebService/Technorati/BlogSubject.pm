package WebService::Technorati::BlogSubject;
use strict;
use utf8;

use fields qw(blog rankingstart);

use WebService::Technorati::Blog;

use WebService::Technorati::BaseTechnoratiObject;
use base 'WebService::Technorati::BaseTechnoratiObject';

{
    my %_attrs = (
        blog => undef,
        rankingstart => undef
    );
    sub _accessible { exists $_attrs{$_[1]} }
}

sub new_from_node {
	my $class = shift;
	my $node = shift;
	my $blog_node = $node->find('weblog')->pop;
	my $data = {
		blog => WebService::Technorati::Blog->new_from_node($blog_node),
	    rankingstart => $node->findvalue('rankingstart')->string_value		
	};
	my $self = bless ($data, ref ($class) || $class);
	return $self;
}

1;