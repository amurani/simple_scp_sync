#!/Users/kevinmurani/perl5/perlbrew/perls/perl-5.30.0/bin/perl

use strict;
use warnings;
use feature qw< say >;

use Getopt::Long;
use Cwd qw< realpath >;
use Path::Tiny;
use JSON;

use constant CONFIG_FILE_PATH => "$ENV{HOME}/.simple_scp_sync_config";

GetOptions( "file=s" => \( my $file ) ) or die("syncing cannot run without a file name\n");

my $config_file = path(CONFIG_FILE_PATH);
my $config_content;
eval {
    $config_content = $config_file->slurp;
    1;
} or do {
    my $error = $@;
    say $error;
    die;
};

my $config = decode_json $config_content;

my $abs_file_path  = realpath($file);
my @sync_locations = grep { $abs_file_path =~ $_->{source_root_path} } @$config;

my @scp_commands;
for my $sync_location (@sync_locations) {
    my $user       = $sync_location->{username} || $ENV{USER};
    my $local_file = $abs_file_path;
    $local_file =~ s/$sync_location->{source_root_path}//;

    my $scp_otions = $sync_location->{scp_otions} || "";

    push @scp_commands, map {
        sprintf( "scp %s %s %s@%s:%s%s",
            $scp_otions, $abs_file_path, $user, $_, $sync_location->{target_root_path}, $local_file );
    } @{ $sync_location->{hosts} || [] };
}

do { my $esit_status = system $_ }
    for @scp_commands;
