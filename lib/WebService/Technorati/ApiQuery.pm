package WebService::Technorati::ApiQuery;
use strict;
use utf8;

use LWP::UserAgent;
use HTTP::Request;
use XML::XPath;

use WebService::Technorati::Exception;

use constant DEFAULT_API_HOST_URL => 'http://api.technorati.com';
my $api_host_url = '';

sub apiHostUrl {
    my $self = shift;
    my $change = shift;
    if ($change) {
        $api_host_url = $change;
    }
    if ($api_host_url) {
        return $api_host_url;
    }
    return DEFAULT_API_HOST_URL;
}
        
sub fetch_url {
    my $url = shift;
    my $ua = LWP::UserAgent->new;
    my $request = HTTP::Request->new('GET', $url);
    my $response = $ua->request($request);
    if ($response->is_success) {
        return $response->content;
    } else {
        print $response->code,"\n";
        print $response->error_as_HTML;
        die "fetching $url failed, stopping";
    }   
}   

sub build_query_string {
    my $params = shift;
    my @pairs = ();
    while (my($key,$val) = each %{$params}) {
        push(@pairs, "$key=$val");
    }
    return join('&', @pairs);
}

sub execute {
    my $self = shift;
    my $url = shift;
    my $args = shift;
    $url .= '?' . build_query_string($args);
    my $result_xml = fetch_url($url);
    my $result_xp = XML::XPath->new( xml => $result_xml );
    $self->readResults($result_xp);
}

sub readResults {
	WebService::Technorati::MethodNotImplementedException->throw(
        "abstract methond 'readResults()' not implemented");
} 

1;