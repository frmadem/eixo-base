package Eixo::Base::Singleton;

use strict;
use Eixo::Base::Clase;

my $SELF;

sub make_singleton{
	my ($clase, %args) = @_;

	no strict 'refs';

        no warnings 'redefine';

	return if(defined(&{$clase . '::SINGLETON'}));

	my $instance = $clase->new(%args);

	*{$clase . '::SINGLETON'} = sub {};

	*{$clase . '::AUTOLOAD'} = sub {

		my ($attribute) = our $AUTOLOAD =~ /\:(\w+)$/; 

		if(my $method = $instance->can('__' . $attribute)){
			
			$instance->$method(@_[1..$#_]);				
	
		}
		else{
			die($AUTOLOAD . ' method not found');
		}

	};
	
	if($instance->can('initialize')){

		$instance->initialize();
	}

	$instance;
}

sub new{
	my ($class, @args) = @_;

        my $self = $SELF || bless({}, $class);

        
        $self->__initialize if($self->can('__initialize'));

	# if new is called with initialization values (not recommended)
        #
        if(@args % 2 == 0){

		my %args = @args;

		foreach my $k (keys(%args)){

                    my $method = '__'.$k;

                    $self->$method($args{$k}) if($self->can($method));
                    #$self->{$k} = $args{$k} ;

		}
	}
        
        $SELF = $self;
}


sub __createSetterGetter{
	my ($class, $attribute, $value) = @_;

	no strict 'refs';

	unless(defined(&{$class . '::__' . $attribute})){

		*{$class . '::__' . $attribute} = sub {

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


1;
