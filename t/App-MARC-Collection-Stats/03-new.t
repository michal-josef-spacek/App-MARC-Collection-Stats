use strict;
use warnings;

use App::MARC::Collection::Stats;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = App::MARC::Collection::Stats->new;
isa_ok($obj, 'App::MARC::Collection::Stats');
