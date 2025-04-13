use strict;
use warnings;

use App::MARC::Collection::Stats;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($App::MARC::Collection::Stats::VERSION, 0.01, 'Version.');
