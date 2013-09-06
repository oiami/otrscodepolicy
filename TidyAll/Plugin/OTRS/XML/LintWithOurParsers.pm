# --
# TidyAll/Plugin/OTRS/XML/LintWithOurParsers.pm - code quality plugin
# Copyright (C) 2001-2013 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package TidyAll::Plugin::OTRS::XML::LintWithOurParsers;

use strict;
use warnings;

use base qw(TidyAll::Plugin::OTRS::Base);

use XML::Parser;

sub validate_source {
    my ( $Self, $Code ) = @_;

    return if $Self->IsPluginDisabled( Code => $Code );

    my $Parser = XML::Parser->new();
    if ( !eval { $Parser->parse($Code) } ) {
        die __PACKAGE__ . "\nXML::Parser produced errors: $@\n";
    }

    # XML::Parser::Lite may not be installed, only check if present.
    if ( eval 'require XML::Parser::Lite' ) {    ## no critic
        my $ParserLite = XML::Parser::Lite->new();
        eval { $ParserLite->parse($Code) };
        if ($@) {
            die __PACKAGE__ . "\nXML::Parser::Lite produced errors: $@\n";
        }
    }
}

1;