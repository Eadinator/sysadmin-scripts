#!/usr/bin/perl

use warnings;
use strict;

my $watermark_kernel = "";
my $watermark_kernel_installed = 0;
my $watermark_major = 0;
my $watermark_minor = 0;

my $regex = qr{
	^core
	[ ]
	(?<kernel>linux\d{2,})
	[ ]
	(?<version>
		(?<major>\d+)
		\.
		(?<minor>\d+)
		\S+
	)
	\s
	(?<installed>\[installed\])?
}x;

foreach my $line (qx/pacman -Sl core/)
{
	if ($line =~ /$regex/ && $+{version} !~ /rc/)
	{
		my $major = $+{major};
		my $minor = $+{minor};

		if ($major > $watermark_major || ($major == $watermark_major && $minor > $watermark_minor))
		{
			$watermark_kernel = $+{kernel};
			$watermark_kernel_installed = ($+{installed}) ? 1 : 0;
			$watermark_major = $major;
			$watermark_minor = $minor;
		}
	}
}

print "$watermark_kernel\n" unless ($watermark_kernel_installed);
