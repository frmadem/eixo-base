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

use Config;
use Data::Dumper;

my $c = Config->new(path =>'/tmp/b');



