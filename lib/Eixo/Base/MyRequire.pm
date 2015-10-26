package Eixo::Base::MyRequire;

use strict;
use parent qw(Exporter);

our @EXPORT = qw(my_require);

my %MY_INC;

sub my_require{
	my ($module) = @_;

	return if($MY_INC{$module});
	
	$MY_INC{$module} = 1;

	require "$module.pm";
}

1;
