use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('App::MARC::Collection::Stats', 'App::MARC::Collection::Stats is covered.');
