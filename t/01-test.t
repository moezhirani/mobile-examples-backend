use strict;
use warnings;

use t::lib::Test;
t::lib::Test::start();
my $url = 'http://localhost:3000';


require Test::More;
import Test::More;
require Test::Deep;
import Test::Deep;

require JSON;
import JSON qw(from_json);

require Test::WWW::Mechanize;
my $m = Test::WWW::Mechanize->new();

# log: "warning"
# set in environments/development.yml to avoid the extensive
# logging of the server during testing

# shall I use plain HTML backend or only json backend?

plan(tests => 8);
diag($url);
$m->get_ok($url);
$m->content_like(qr{<h1>Mobile Examples Backend</h1>});

$m->get_ok("$url/echo?txt=Foo");
$m->content_like(qr{Echo GET Foo});


$m->get_ok("$url/echo.json?txt=Bar");
cmp_deeply(from_json($m->content),
   {
      'method' => 'GET',
      'txt' => 'Bar',
      'time' => ignore(), 
   }, 'echo json get');

$m->post_ok("$url/echo.json", {txt => 'Foo'});
cmp_deeply(from_json($m->content),
   {
      'method' => 'POST',
      'txt' => 'Foo',
      'time' => ignore(), 
   }, 'echo json post');


#diag(explain(from_json($m->content)));
