# -*- perl -*-

# t/006_parseauthorinfoxml.t - checks loading authorinfo api query and results parsing

use Test::More tests => 3;
use XML::XPath;
use WebService::Technorati;
use FindBin qw($Bin);

my $apiKey = 'a_key_that_wont_work_with_a_live_query';
my $username = 'spidaman';
my $t = WebService::Technorati->new(key => $apiKey);
my $cq = $t->getAuthorinfoApiQuery($username);

my $result_xp = XML::XPath->new(filename => "$Bin/testdata/getinfo.xml");
$cq->readResults($result_xp);

my $author = $cq->getSubjectAuthor();
isa_ok($author, 'WebService::Technorati::Author');
my @blogs = $cq->getClaimedBlogs();
is(0, $#blogs);
my $blog = pop(@blogs);
isa_ok($blog, 'WebService::Technorati::Blog');



