package Digest::FNV;

use 5.006;
use strict;
use warnings;
use Carp;

require Exporter;
require DynaLoader;
use AutoLoader;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Digest::FNV ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

our @EXPORT_OK   = qw(fnv);

our @EXPORT      = qw();

our $VERSION     = "1.00";

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "& not defined" if $constname eq 'constant';
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/ || $!{EINVAL}) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
	    croak "Your vendor has not defined Digest::FNV macro $constname";
	}
    }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
	if ($] >= 5.00561) {
	    *$AUTOLOAD = sub () { $val };
	}
	else {
	    *$AUTOLOAD = sub { $val };
	}
    }
    goto &$AUTOLOAD;
}

bootstrap Digest::FNV $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Digest::FNV - Perl interface to FNV hash

=head1 SYNOPSIS

  use Digest::FNV qw(fnv);

  my $hash = fnv("abc123");

=head1 DESCRIPTION

C<Digest::FNV> is an implementation for the 32-bit version of Fowler/Noll/Vo
hashing algorithm which allows variable length input strings to be quickly hashed into unsigned integer values.
For more information about this hash, please visit L<http://www.isthe.com/chongo/tech/comp/fnv/>.

=head2 NOTE

Support for the 64-bit version is not included in this release.

=head1 ACKNOWLEDGEMENTS

The implementation in C is obtained from the source code released on public
domain by one of the authors - Landon Curt Noll. 

=head1 SEE ALSO

L<Digest::FNV::PurePerl>, L<Digest::Pearson>, L<Digest::DJB>.

=head2 BUGS

Please send your comments to L<tnguyen@cpan.org>.

=cut
