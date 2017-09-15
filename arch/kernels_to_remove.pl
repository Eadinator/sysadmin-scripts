#!/usr/bin/perl

use warnings;
use strict;

my ($current_major, $current_minor) = (split(/\./, qx/uname -r/))[0, 1];

my $regex = qr{
	^(?<kernel>linux\d{2,})
	[ ]
	(?<major>\d+)\.(?<minor>\d+)
}x;

foreach my $line (qx/pacman -Q/)
{
	if ($line =~ /$regex/)
	{
		my $kernel = $+{kernel};
		my $major = $+{major};
		my $minor = $+{minor};

		if ($major < $current_major || ($major == $current_major && $minor < $current_minor))
		{
			print "$kernel\n";
		}
	}
}
