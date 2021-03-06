# --
# TidyAll/Plugin/OTRS/Perl/TranslationEncoding.pm - code quality plugin
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package TidyAll::Plugin::OTRS::Perl::TranslationEncoding;

use strict;
use warnings;

use File::Basename;

use base qw(TidyAll::Plugin::OTRS::Perl);

sub validate_source {    ## no critic
    my ( $Self, $Code ) = @_;

    return $Code if $Self->IsPluginDisabled( Code => $Code );
    return $Code if $Self->IsFrameworkVersionLessThan( 4, 0 );

    if ( $Code !~ m{^[ \t]*use\s+utf8;}mx ) {
        die __PACKAGE__ . "\n" . <<EOF;
All language files must be encoded in "utf-8", and include the "use utf8;" Perl pragma.
EOF
    }

    return;
}

1;
