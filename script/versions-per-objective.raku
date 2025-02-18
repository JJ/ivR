#!/usr/bin/env raku

use JSON::Fast;
use Git::File::History;

my $repo= Git::File::History.new( "../IV-" );

my @history = $repo.history-of( "data/versiones.json" );

my %last-versions-of-objective;
my %last-versions-per-user;

for @history -> %commit {
    say %commit;
    my %version-file;
    try {
        %version-file =from-json %commit<state>;
    }

    if $! {
        say "Error in commit %commit<commit>"; next ;
    }

    for %version-file.kv -> $user, $version {
        next unless $version;
        my $version-v = Version.new( $version );
        say $version-v.raku;
        my $objective = $version-v.parts[ 1 ];
        say "Version $version objective $objective";
        if %last-versions-per-user{$user}:exists {
            %last-versions-per-user{$user}[ $objective ] = $version-v.parts[2] if $version-v.parts[2] > %last-versions-per-user{$user}[ $objective ];
        } else {
            %last-versions-per-user{$user}[ $objective ] = $version-v.parts[2];
        }

    }
}
say %last-versions-per-user;