package Eixo::Base::Clase;

use Eixo::Base::Util;
use Clone 'clone';

use Attribute::Handlers;
use strict;
use warnings;

use parent qw(Exporter);

our @EXPORT = qw(has);

sub import{
	my ($class, $parent) = @_;

	$parent = $parent || 'Eixo::Base::Clase';
	
	my $caller = caller;

	{
		no strict 'refs';

		push @{$caller . '::ISA'}, $parent;
	
		*{$caller . '::has'} = \&has;

	};
}



sub has{
	my (%attributes) = @_;

	my $class = (caller(0))[0];

	no strict 'refs';
	
	foreach my $attribute (keys(%attributes)){

		$class->__createSetterGetter($attribute, $attributes{$attribute});		
	}

	*{$class . '::' . '__initialize'} = sub {

		my $c_attributes = clone(\%attributes);

		my ($self) = @_;

		foreach(keys %$c_attributes){
			$self->{$_} = $c_attributes->{$_};
		}
	};  
}

sub __createSetterGetter{
	my ($class, $attribute, $value) = @_;

	no strict 'refs';

	unless(defined(&{$class . '::' . $attribute})){

		*{$class . '::' . $attribute} = sub {

			my ($self, $value)  = @_;

			if(defined($value)){
				
				$self->{$attribute} = $value;
				
				$self;
			}
			else{
				$self->{$attribute};
			}	

		};
	}

}

sub new{
	my ($clase, @args) = @_;

	my $self = bless({}, $clase);

	# 3 initilization forms with defined precedence

	# initialize attributes with default values from 'has' hash
	$self->__initialize if($self->can('__initialize'));

	# if new is called with initialization values (not recommended)
	if(@args % 2 == 0){

		my %args = @args;

		foreach(keys(%args)){

			$self->$_($args{$_}) if($self->can($_));

		}
	}

	# if class has initialize method (recommended)
	$self->initialize(@args) if($self->can('initialize'));

	$self;
}

#
# Methods
#
sub methods{
	my ($self, $class, $nested) = @_;

	$class = $class || ref($self) || $self;

	no strict 'refs';

	my @methods = grep { defined(&{$class . '::' . $_} ) } keys(%{$class . '::'});

	push @methods, $self->methods($_, 1) foreach(@{ $class .'::ISA' } );


	unless($nested){

		my %s;

		$s{$_}++ foreach( map { $_ =~ s/.+\:\://; $_ } @methods);

		return keys(%s);
	}

	@methods;
	
}

#
# ABSTRACT method
#
sub Abstract :ATTR(CODE){
	my ($pkg, $sym, $code, $attr_name, $data) = @_;

	no warnings 'redefine';

	my $n = $pkg . '::' . *{$sym}{NAME};

	*{$sym} = sub {

		die($n . ' is ABSTRACT!!!');
 
	};	

}

#
# logger installing code
#
sub Log :ATTR(CODE){

	my ($pkg, $sym, $code, $attr_name, $data) = @_;

	no warnings 'redefine';

	*{$sym} = sub {

		my ($self, @args) = @_;

		$self->logger([$pkg, *{$sym}{NAME}], \@args);

		$code->($self, @args);
	};

}

sub flog{
	my ($self, $code) = @_;

	unless(ref($code) eq 'CODE'){
		die(ref($self) . '::flog: code ref expected');
	}

	$self->{flog} = $code;
}

sub logger{
	my ($self, @args) = @_;

	return unless($self->{flog});

	$self->{flog}->($self, @args);
}

1;


