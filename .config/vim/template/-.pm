#!/usr/bin/perl

use strict;
use warnings;
use utf8;

package Example

sub example {
    print 'example';
}

BEGIN {
}

END {
}

1;

__END__

=head1 NAME

Example - my template

=head1 SYNOPSIS

example.pl < data.csv

=head1 DESCRIPTION

=head2 Section 1

I<italic>, B<bold>, S<non-broken text>, C<codes>,
L<links|name/"sec">, L<http://www.perl.org/>,
E<lt>, E<gt>, F<file>,

rarely used formats
X<index entry>, Z<>

=head2 Section 2

items

=over 4

=item *

=back

=head1 EXAMPLES

=head1 KNOWN ISSUES

=head1 AUTHOR

janus_wel <janus.wel.3@gmail.com> - L<http://d.hatena.ne.jp/janus_wel/>

=head1 LICENSE

The Artistic License

    L<http://www.perl.com/pub/a/language/misc/Artistic.html>
    L<http://dev.perl.org/perl6/rfc/346.html>

=head1 SEE ALSO

http://d.hatena.ne.jp/janus_wel/

=cut

# vim: ts=4 sw=4 sts=0 et
