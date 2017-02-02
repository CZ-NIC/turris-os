#!/usr/bin/perl
# Copyright (C) 2017 CZ.NIC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

# This script scans all packages available in a provided directory and
# generates list of packages blocking each other, in the format of updater
# configuration.
use strict;
use warnings;
use Cwd qw(cwd);
use FindBin;

# First get list of all the packages we have
chdir $ARGV[0] if $ARGV[0];
open my $found, '-|', 'find', cwd, '-name', '*.ipk' or die "Can't read find: $!\n";
my @found_packages = <$found>;
close $found or die "Error reading from find: $!/$?\n";
chomp @found_packages;

# Assing an owner to each file (or multiple, if there are).
my %file_owners;
for my $package (@found_packages) {
	# An external shell script analyses each package
	open my $pkg_content, '-|', $FindBin::Bin . "/pkg-content.sh", $package or die "Can't get content of package $package: $!\n";
	# The first line of the output is the package name
	my $pkg_name = <$pkg_content>;
	chomp $pkg_name;
	for my $file (<$pkg_content>) {
		chomp $file;
		push @{$file_owners{$file}}, $pkg_name;
	}
	close $pkg_content or die "Error reading package content: $!/$?\n";
}

my %collisions;

for my $owners (values %file_owners) { # We don't care on *which* file the collision happens
	for my $blocked (@$owners) {
		for my $blocker (@$owners) {
			if ($blocked ne $blocker) {
				$collisions{$blocked}->{$blocker} = 1;
			}
		}
	}
}

while (my ($blocked, $blockers) = each %collisions) {
	print "Package '$blocked' { deps = {" . (join ', ', map "Not('$_')", keys %$blockers) . "} }\n";
}
