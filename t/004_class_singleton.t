
package Foo;

use strict;
use Eixo::Base::Clase 'Eixo::Base::Singleton';

has(

	a=>1,
	b=>2,
	c=>3

);

__PACKAGE__->make_singleton();

package Main;

use t::test_base;
BEGIN{use_ok("Eixo::Base::Singleton")}

ok(Foo->a == 1, 'Accessors seem right');

Foo->a(3);

ok(Foo->a == 3, 'Changes propagate across the system');

done_testing();
