package Eixo::Base::Data;

use strict;
use Eixo::Base::Clase;


sub getData{
	my ($module) = @_;

	no strict 'refs';

	my $f = \*{$module . '::DATA'};

	return undef unless(defined($f));

	my $pos = tell($f);

	my $datos = join('', <$f>);

	seek($f, $pos, 0);

	return $datos;
}

1;
