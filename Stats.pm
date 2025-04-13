package App::MARC::Collection::Stats;

use strict;
use warnings;

use Class::Utils qw(set_params);
use English;
use Getopt::Std;
use MARC::Collection::Stats;
use MARC::File::XML (BinaryEncoding => 'utf8', RecordFormat => 'MARC21');
use Unicode::UTF8 qw(encode_utf8);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Process parameters.
	set_params($self, @params);

	# Object.
	return $self;
}

# Run.
sub run {
	my $self = shift;

	# Process arguments.
	$self->{'_opts'} = {
		'h' => 0,
		'l' => undef,
	};
	if (! getopts('hl', $self->{'_opts'})
		|| $self->{'_opts'}->{'h'}) {

		$self->_usage;
		return 1;
	}
	if (! defined $self->{'_opts'}->{'l'}) {
		if (@ARGV < 1) {
			$self->_usage;
			return 1;
		}
		$self->{'_marc_xml_file'} = shift @ARGV;
	}

	my $exit_code;
	if ($self->{'_opts'}->{'l'}) {
		$exit_code = $self->_list_plugins;
	} else {
		$exit_code = $self->_process_stats;
	}

	return $exit_code;
}

sub _list_plugins {
	my $self = shift;

	my @plugins = MARC::Collection::Stats::plugins;

	print "List of plugins:\n";
	print map { '- '.$_ } join "\n", @plugins;
	print "\n";

	return 0;
}

sub _process_stats {
	my $self = shift;

	my $marc_file = MARC::File::XML->in($self->{'_marc_xml_file'});
	my $ret_hr = {};
	my $num = 0;
	my $previous_record;
	while (1) {
		$num++;
		my $record = eval {
			$marc_file->next;
		};
		if ($EVAL_ERROR) {
			print STDERR "Cannot process '$num' record. ".
				(
					defined $previous_record
					? "Previous record is ".encode_utf8($previous_record->title)."\n"
					: ''
				);
			print STDERR "Error: $EVAL_ERROR\n";
			next;
		}
		if (! defined $record) {
			last;
		}
		$previous_record = $record;

		# Collect statistics.
		# TODO
	}

	# JSON output.
	# TODO

	return 0;
}

sub _usage {
	my $self = shift;

	print STDERR "Usage: $0 [-h] [-l] [--version] marc_xml_file\n";
	print STDERR "\t-h\t\tPrint help.\n";
	print STDERR "\t-l\t\tList of plugins.\n";
	print STDERR "\t--version\tPrint version.\n";
	print STDERR "\tmarc_xml_file\tMARC XML file.\n";

	return;
}

1;
