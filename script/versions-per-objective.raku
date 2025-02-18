#!/usr/bin/env raku

use JSON::Fast;
use Git::File::History;

my $repo= Git::File::History.new( "../IV-" );

my @history = $repo.history-of( "data/versiones.json" );

my %last-versions-of-objective;
my %last-versions-per-user;

for @history -> %commit {
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
        my $objective = $version-v.parts[ 1 ];
        next unless $version-v.parts[2];
        if %last-versions-per-user{$user}:exists {
            %last-versions-per-user{$user}[ $objective ] = $version-v.parts[2] if $version-v.parts[2] > %last-versions-per-user{$user}[ $objective ];
        } else {
            %last-versions-per-user{$user}[ $objective ] = $version-v.parts[2];
        }
    }

}

my $user-idx = 0;
say "user, objective, version";
for %last-versions-per-user.kv -> $user, @versions {
    for @versions.kv -> $objective, $version {
        next unless $version;
        say "$user-idx, $objective, $version";
    }
    $user-idx++;
}
