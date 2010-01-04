#!/usr/bin/perl

use strict;
use warnings;

main();

sub main {
    my $codepoint_column = 0;
    my $name_column = 1;
    my $alternate_column = 10;
    my $upper_twobytes = 0xffff;
    while (<>) {
        my @data = split /;/;
        my $codepoint = $data[$codepoint_column];
        exit if hex $codepoint > $upper_twobytes;

        my $name = $data[$name_column];
        $name = $data[$alternate_column] if $name eq '<control>';

        print "'$codepoint':'$name',";
    }
}

BEGIN {
    my $filename = 'unicode#namelist';
    my $varname = 'dict';
    my $header = <<__HEADER__;
" This file is built from UnicodeData.txt
" http://www.unicode.org/Public/UNIDATA/UnicodeData.txt
__HEADER__

    print $header;
    print "let $filename#$varname = {";
}

END {
    print '}';
}

__END__

=head1 SYNOPSIS

=over 4

=item *

POSIX

unicode_namelist.pl < UnicodeData.txt > ~/.vim/autoload/unicode/namelist.vim

=item *

win32

perl unicode_namelist.pl < UnicodeData.txt > %HOME%\vimfiles\autoload\unicode\namelist.vim

=back

=head1 DESCRIPTION

Building the Dictionary for vim that has a series of Unicode code points as
keys and names defined by The Unicode Consortium as values. The result file is
used by the vim autoload file unicode.vim:

    L<http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/unicode.vim>

UnicodeData.txt is distributed at:

    L<http://www.unicode.org/Public/UNIDATA/UnicodeData.txt>

This script supposes to be passed UnicodeData.txt through the stdin (bar, pipe
or |). You can download the UnicodeData.txt to the local machine ( see "Unicode
Terms of Use" http://www.unicode.org/copyright.html ) and then run the
following command:

=head1 AUTHOR

janus_wel <janus.wel.3@gmail.com> - L<http://d.hatena.ne.jp/janus_wel/>

=head1 LICENSE

The Artistic License

    L<http://www.perl.com/pub/a/language/misc/Artistic.html>
    L<http://dev.perl.org/perl6/rfc/346.html>

=head1 SEE ALSO

Unicode Terms of Use

    L<http://www.unicode.org/copyright.html>

Unicode 5.2 Character Code Charts

    L<http://www.unicode.org/charts/>

=cut

vim: ts=4 sw=4 sts=0 et
