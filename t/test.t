BEGIN { $| = 1; print "1..2\n"; }
END   { print "not ok 1\n" unless $loaded; }

use Digest::FNV;

$loaded = 1;

print "ok 1\n";

print "not " unless Digest::FNV::fnv("abc123") eq 3613024805;
print "ok 2\n";
