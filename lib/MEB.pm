package MEB;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/echo' => sub {
	return 'Echo GET ' . param('txt');
};

get '/echo.json' => sub {
	return to_json { method => 'GET', txt => param('txt') };
};


true;
