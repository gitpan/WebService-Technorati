package WebService::Technorati::SearchApiQuery;
use strict;
use utf8;

use WebService::Technorati::ApiQuery;
use WebService::Technorati::SearchTerm;
use WebService::Technorati::SearchMatch;
use WebService::Technorati::Exception;
use base 'WebService::Technorati::ApiQuery';

use constant API_URI => '/cosmos';

sub new {
    my ($class, %params) = @_;
    if (! exists $params{'key'}) {
    	WebService::Technorati::InstantiationException->throw(
    	  "WebService::Technorati::SearchApiQuery must be " .
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
    my $searchTerm = WebService::Technorati::SearchTerm->new_from_node($node);
    
    $nodeset = $result_xp->find('/tapi/document/item');
    my @matches = ();
    for my $node ($nodeset->get_nodelist) {
        my $match = WebService::Technorati::SearchMatch->new_from_node($node);
        push(@matches, $match);
    }
    $self->{'subject'} = $searchTerm;
    $self->{'matches'} = \@matches;

}

sub getSubjectSearchTerm {
    my $self = shift;
    return $self->{'subject'};
}

sub getSearchMatches {
    my $self = shift;
    return (wantarray) ? @{$self->{'matches'}} : $self->{'matches'};
}

1;
