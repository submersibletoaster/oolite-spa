package OoliteSPA::WWW;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use Dancer::Plugin::Auth::RBAC;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/systems/:galaxy' => sub {
    my $systems = database->selectall_arrayref(
        q{ select * from system where galaxy = ? },
        { Slice=>{} } , params->{galaxy}
    );
};

get '/system/:galaxy/:system' => sub {
    my $system = database->selectrow_hashref(
        q{ select * from system where galaxy = ? and system = ?},
        { Slice => {} } , params->{galaxy} , params->{system}
    );
};

true;
