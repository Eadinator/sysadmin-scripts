#!/usr/bin/perl

use warnings;
use strict;

use Version::Compare qw//;

my $uname = shift;

$uname =~ s/-generic//;

while (my $line = <STDIN>)
{
	chomp($line);

	if ($line =~ /^linux-((signed-)?image|image-extra|headers)-(?<version>\d.*?)(-generic)?$/)
	{
		my $version = $+{version};

		if (Version::Compare::version_compare($uname, $version) == 1)
		{
			print "$line\n";
		}
	}
}
