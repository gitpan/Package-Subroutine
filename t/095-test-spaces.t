#!/usr/bin/perl -w
#
# Copyright 2007-2009 by Wilson Snyder.  This program is free software;
# you can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License Version 2.0.
#
# modified on May 27 2009 by S. Knapp
use strict;
use Test::More;
use IO::File;
use ExtUtils::Manifest;

my $slurp = sub {
    my $file = shift;
    my $fh = IO::File->new ($file) or die "%Error: $! $file";
    my $wholefile = join('',$fh->getlines());
    $fh->close();
    return $wholefile;
};

my $manifest = ExtUtils::Manifest::maniread();

my %skipfor = ('META.yml' => 1);
plan tests => (1 + (keys %{$manifest}) - (keys %skipfor));
ok(1);

foreach my $filename (keys %{$manifest}) {
    next if exists $skipfor{$filename};
    print "Space test of: $filename\n";
    my $wholefile = $slurp->($filename);
    ok($wholefile && $wholefile !~ /[ \t]+\n/);
}
