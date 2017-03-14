#!/usr/bin/perl

use warnings;
use strict;

use File::Slurp qw/read_file write_file/;

my $evdev_xml_file = "/usr/share/X11/xkb/rules/evdev.xml";
my $symbols_dir = "/usr/share/X11/xkb/symbols";
my $symbol_filename = "hp_15-ab273ca";
my $symbol_filepath = "$symbols_dir/$symbol_filename";

my $evdev_xml = read_file($evdev_xml_file);

my $layout = <<"LAYOUT";
<layout>
	<configItem>
		<name>$symbol_filename</name>
		<shortDescription>hp</shortDescription>
		<description>$symbol_filename</description>
		<languageList>
			<iso639Id>fra</iso639Id>
		</languageList>
	</configItem>
</layout>
LAYOUT

my $symbol_file=<<'SYMB';
xkb_symbols {
    key <TLDE>	{ [        grave, asciitilde, backslash, bar          ] };
    key <AE01>	{ [            1, exclam, plusminus                   ] };
    key <AE02>	{ [            2, at, at, quotedbl                    ] };
    key <AE03>	{ [            3, numbersign, sterling, slash         ] };
    key <AE04>	{ [            4, dollar, cent                        ] };
    key <AE05>	{ [            5, percent, currency                   ] };
    key <AE06>	{ [            6, asciicircum, notsign, question      ] };
    key <AE07>	{ [            7, ampersand, bar                      ] };
    key <AE08>	{ [            8, asterisk, twosuperior               ] };
    key <AE09>	{ [            9, parenleft, threesuperior            ] };
    key <AE10>	{ [            0, parenright, onequarter              ] };
    key <AE11>	{ [        minus, underscore, onehalf                 ] };
    key <AE12>	{ [        equal, plus, threequarters                 ] };

    key <AD01>	{ [            q, Q                                   ] };
    key <AD02>	{ [            w, W                                   ] };
    key <AD03>	{ [            e, E                                   ] };
    key <AD04>	{ [            r, R                                   ] };
    key <AD05>	{ [            t, T                                   ] };
    key <AD06>	{ [            y, Y                                   ] };
    key <AD07>	{ [            u, U                                   ] };
    key <AD08>	{ [            i, I                                   ] };
    key <AD09>	{ [            o, O, section                          ] };
    key <AD10>	{ [            p, P, paragraph                        ] };
    key <AD11>	{ [  bracketleft, braceleft, asciicircum, asciicircum ] };
    key <AD12>	{ [ bracketright, braceright, cedilla, diaeresis      ] };

    key <AC01>	{ [            a, A                                   ] };
    key <AC02>	{ [            s, S                                   ] };
    key <AC03>	{ [            d, D                                   ] };
    key <AC04>	{ [            f, F                                   ] };
    key <AC05>	{ [            g, G                                   ] };
    key <AC06>	{ [            h, H                                   ] };
    key <AC07>	{ [            j, J                                   ] };
    key <AC08>	{ [            k, K                                   ] };
    key <AC09>	{ [            l, L                                   ] };
    key <AC10>	{ [    semicolon, colon, asciitilde                   ] };
    key <AC11>	{ [   apostrophe, quotedbl, braceleft, grave          ] };
    key <BKSL>	{ [    backslash, bar, less, greater                  ] };

    key <LSGT>	{ [    backslash, bar, guillemotleft, guillemotright  ] };
    key <AB01>	{ [            z, Z                                   ] };
    key <AB02>	{ [            x, X                                   ] };
    key <AB03>	{ [            c, C                                   ] };
    key <AB04>	{ [            v, V                                   ] };
    key <AB05>	{ [            b, B                                   ] };
    key <AB06>	{ [            n, N                                   ] };
    key <AB07>	{ [            m, M, mu                               ] };
    key <AB08>	{ [        comma, less, underscore, apostrophe        ] };
    key <AB09>	{ [       period, greater, period, period             ] };
    key <AB10>	{ [        slash, question, comma, Eacute             ] };

    key <SPCE>	{ [        space, space, nobreakspace                 ] };

    include "level3(ralt_switch)"
};
SYMB

my $end_tag = "</layoutList>";

my $search = $end_tag;
my $replace = $layout . $end_tag;

$evdev_xml =~ s/$search/$replace/;

write_file($symbol_filepath, $symbol_file);
write_file($evdev_xml_file, $evdev_xml);
