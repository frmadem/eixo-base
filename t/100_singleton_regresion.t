package Config;

use Eixo::Base::Clase qw(Eixo::Base::Singleton);

has(
    path => '/tmp/a'
);

sub initialize{
    print($_[0]->{path});
}


__PACKAGE__->make_singleton();

1;


package Main;

use t::test_base;
use Config;
use Data::Dumper;

my $c = Config->new(path =>'/tmp/b');

ok( 
    $c->path eq '/tmp/b',

    "Podemos inicializar o singleton"
);

done_testing();
