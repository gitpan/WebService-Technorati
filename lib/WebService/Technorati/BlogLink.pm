package WebService::Technorati::BlogLink;
use strict;
use utf8;

use fields qw(blog nearestpermalink excerpt linkcreated linkurl);

use WebService::Technorati::Blog;

use WebService::Technorati::BaseTechnoratiObject;
use base 'WebService::Technorati::BaseTechnoratiObject';

{
    my %_attrs = (
        blog => undef,
        nearestpermalink => undef,
        excerpt => undef,
        linkcreated => undef,
        linkurl => undef
    );
    sub _accessible { exists $_attrs{$_[1]} }
}

sub new_from_node {
     my $class = shift;
     my $node = shift;
     my $blog_node = $node->find('weblog')->pop;
     my $data = {
         blog => WebService::Technorati::Blog->new_from_node($blog_node),
         nearestpermalink => $node->findvalue('nearestpermalink')->string_value,
         excerpt => $node->findvalue('excerpt')->string_value(),
         linkcreated => $node->findvalue('linkcreated')->string_value(),
         linkurl => $node->findvalue('linkurl')->string_value()
     };
     my $self = bless ($data, ref ($class) || $class);
     return $self;
}

1;
