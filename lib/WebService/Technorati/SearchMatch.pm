package WebService::Technorati::SearchMatch;
use strict;
use utf8;
use fields qw(blog created title excerpt);

use WebService::Technorati::Blog;

use WebService::Technorati::BaseTechnoratiObject;
use base 'WebService::Technorati::BaseTechnoratiObject';

{
    my %_attrs = (
        blog => undef,
        created => undef,
        title => undef,
        excerpt => undef
    );
    sub _accessible { exists $_attrs{$_[1]} }
}

sub new_from_node {
    my $class = shift;
    my $node = shift;
    my $blog_node = $node->find('weblog')->pop;
    my $data = {
        blog => WebService::Technorati::Blog->new_from_node($blog_node),
        created => $node->findvalue('created')->string_value,
        excerpt => $node->findvalue('excerpt')->string_value(),
        title => $node->findvalue('title')->string_value(),
    };
    my $self = bless ($data, ref ($class) || $class);
    return $self;
}

1;
