# -*- perl -*-

# t/003_parsesearchxml.t - checks loading search api query and results parsing

use Test::More tests => 3;
use XML::XPath;
use WebService::Technorati;
use FindBin qw($Bin);

my $apiKey = 'a_key_that_wont_work_with_a_live_query';
my $keyword = '"George Bush"';
my $t = WebService::Technorati->new(key => $apiKey);
my $sq = $t->getSearchApiQuery($keyword);

my $result_xp = XML::XPath->new(filename => "$Bin/testdata/search.xml");
$sq->readResults($result_xp);

my $search_term = $sq->getSubjectSearchTerm();
isa_ok($search_term, 'WebService::Technorati::SearchTerm');
my @matches = $sq->getSearchMatches();
is(19, $#matches);
my $match = pop(@matches);
isa_ok($match, 'WebService::Technorati::SearchMatch');



