package WebService::Technorati::CosmosApiQuery;
use strict;
use utf8;

use WebService::Technorati::ApiQuery;
use WebService::Technorati::BlogSubject;
use WebService::Technorati::BlogLink;
use WebService::Technorati::Exception;
use base 'WebService::Technorati::ApiQuery';

use constant API_URI => '/cosmos';

sub new {
	my ($class, %params) = @_;
	if (! exists $params{'key'}) {
		WebService::Technorati::InstantiationException->throw(
		  "WebService::Technorati::CosmosApiQuery must be " .
		  "instantiated with at least 'key => theverylongkeystring'"); 
	}
	my $data = {};
	if (! exists $params{'url'}) {
		$data->{'needs_url'}++;
	}
	for my $k (keys %params) {
	     $data->{'args'}{$k} = $params{$k};
	}
	my $self = bless ($data, ref ($class) || $class);
	return $self;
}

sub url {
	my $self = shift;
	my $url = shift;
	if ($url) {
	    $self->{'url'} = $url;
	    delete($self->{'needs_url'});
	}
	return $self->{'url'};
}

sub execute {
    my $self = shift;
    my $apiUrl = $self->apiHostUrl() . API_URI;
        if (exists $self->{'needs_url'}) {
    		WebService::Technorati::StateValidationException->throw(
    		"WebService::Technorati::AuthorinfoApiQuery must have a " .
    		"'url' attribute set prior to query execution");
    }
    $self->SUPER::execute($apiUrl,$self->{'args'});
}

sub readResults {
    my $self = shift;
    my $result_xp = shift;
    my $error = $result_xp->find('/tapi/document/result/error');
    if ($error) {
        WebService::Technorati::DataException->throw($error);
    }
    my $nodeset = $result_xp->find("/tapi/document/result");
    my $node = $nodeset->shift;
    my $blogSubject = WebService::Technorati::BlogSubject->new_from_node($node);
	
    $nodeset = $result_xp->find('/tapi/document/item');
    my @links = ();
	for my $node ($nodeset->get_nodelist) {
        my $blogLink = WebService::Technorati::BlogLink->new_from_node($node);
        push(@links, $blogLink);
    }
    $self->{'subject'} = $blogSubject;
    $self->{'links'} = \@links;

}

sub getSubjectBlog {
    my $self = shift;
    return $self->{'subject'};
}

sub getInboundLinks {
    my $self = shift;
    return (wantarray) ? @{$self->{'links'}} : $self->{'links'};
}

1;
