#!/usr/bin/perl
# code forked from Todd Larason's <jtl@molehill.org> $XFree86: xc/programs/xterm/vttests/256colors2.pl

for ($fgbg = 38; $fgbg <= 48; $fgbg +=10) {
    print "System colors:\n";
    for ($color = 0; $color < 8; $color++) {
        print "\x1b[${fgbg};5;${color}m::";
    }
    print "\x1b[0m\n";
    for ($color = 8; $color < 16; $color++) {
        print "\x1b[${fgbg};5;${color}m::";
    }
    print "\x1b[0m\n\n";
    print "\x1b[1mBold\x1b[0m system colors:\n";
    for ($color = 0; $color < 8; $color++) {
        print "\x1b[${fgbg};5;${color};1m::";
    }
    print "\x1b[0m\n";
    for ($color = 8; $color < 16; $color++) {
        print "\x1b[${fgbg};5;${color};1m::";
    }
    print "\x1b[0m\n\n";
}
