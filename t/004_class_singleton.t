
package Foo;

use strict;
use Eixo::Base::Clase 'Eixo::Base::Singleton';

has(

	a=>undef,
	b=>2,
	c=>3

);

sub initialize{

	$_[0]->a(1);

}

__PACKAGE__->make_singleton();

package Main;

use t::test_base;
BEGIN{use_ok("Eixo::Base::Singleton")}

ok(Foo->a == 1, 'Accessors seem right');

Foo->a(3);

ok(Foo->a == 3, 'Changes propagate across the system');

done_testing();
