package Eixo::Base;

use 5.008001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Eixo::Base ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '1.02';


# Preloaded methods go here.

1;
__END__
=head1 Eixo::Base

Eixo::Base - Another Perl extension for Classes and Objects

=head1 SYNOPSIS

  use parent qw(Eixo::Base::Clase);

  has(
      id => undef,
      size => undef,
  );


=head1 DESCRIPTION


=head1 SEE ALSO

=head1 AUTHOR

Francisco Maseda, E<lt>frmadem@gmail.com@E<gt>

Javier Gomez, E<lt>jgomez@gmail.com@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Francisco Maseda

Copyright (C) 2014 by Javier Gomez

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

L<lt>http://www.apache.org/licenses/LICENSE-2.0@L<gt>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut
