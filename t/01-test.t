use strict;
use warnings;

use t::lib::Test;
t::lib::Test::start();
my $url = 'http://localhost:3000/';


require Test::More;
import Test::More;
require Test::WWW::Mechanize;
my $m = Test::WWW::Mechanize->new();

plan(tests => 2);
diag($url);
$m->get_ok($url);
$m->content_like(qr{<h1>Mobile Examples Backend</h1>});

