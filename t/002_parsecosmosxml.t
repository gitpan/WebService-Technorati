# -*- perl -*-

# t/002_parsecosmosxml.t - checks loading cosmos api query and results parsing

use Test::More tests => 3;
use XML::XPath;
use WebService::Technorati;
use FindBin qw($Bin);

my $apiKey = 'a_key_that_wont_work_with_a_live_query';
my $url = 'http://www.arachna.com/roller/page/spidaman';
my $t = WebService::Technorati->new(key => $apiKey);
my $cq = $t->getCosmosApiQuery($url);

my $result_xp = XML::XPath->new(filename => "$Bin/testdata/cosmos.xml");
$cq->readResults($result_xp);

my $blog = $cq->getSubjectBlog();
isa_ok($blog, 'WebService::Technorati::BlogSubject');
my @links = $cq->getInboundLinks();
is(19, $#links);
my $link = pop(@links);
isa_ok($link, 'WebService::Technorati::BlogLink');



