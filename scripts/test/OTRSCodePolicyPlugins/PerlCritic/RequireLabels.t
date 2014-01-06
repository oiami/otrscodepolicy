# --
# OTRSCodePolicyPlugins/PerlCritic/RequireLabels.t - code policy self tests
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
use strict;
use warnings;
## nofilter(TidyAll::Plugin::OTRS::Common::CustomizationMarkers);

use vars (qw($Self));
use utf8;

use scripts::test::OTRSCodePolicyPlugins;

my @Tests = (
    {
        Name      => 'next without label',
        Filename  => 'test.pl',
        Plugins   => [qw(TidyAll::Plugin::OTRS::Perl::PerlCritic)],
        Framework => '3.5',
        Source    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
for my $Key ( 1..3 ) {
    next;
}
EOF
        Exception => 1,
    },
    {
        Name      => 'next with label',
        Filename  => 'test.pl',
        Plugins   => [qw(TidyAll::Plugin::OTRS::Perl::PerlCritic)],
        Framework => '3.5',
        Source    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
KEY:
for my $Key ( 1..3 ) {
    next KEY;
}
EOF
        Exception => 0,
        Result    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
KEY:
for my $Key ( 1..3 ) {
    next KEY;
}
EOF
    },
    {
        Name      => 'last without label',
        Filename  => 'test.pl',
        Plugins   => [qw(TidyAll::Plugin::OTRS::Perl::PerlCritic)],
        Framework => '3.5',
        Source    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
for my $Key ( 1..3 ) {
    last;
}
EOF
        Exception => 1,
    },
    {
        Name      => 'last with label',
        Filename  => 'test.pl',
        Plugins   => [qw(TidyAll::Plugin::OTRS::Perl::PerlCritic)],
        Framework => '3.5',
        Source    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
KEY:
for my $Key ( 1..3 ) {
    last KEY;
}
EOF
        Exception => 0,
        Result    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
KEY:
for my $Key ( 1..3 ) {
    last KEY;
}
EOF
    },
    {
        Name      => 'next without label',
        Filename  => 'test.pl',
        Plugins   => [qw(TidyAll::Plugin::OTRS::Perl::PerlCritic)],
        Framework => '3.5',
        Source    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
for my $Key ( 1..3 ) {
    next if (1);
}
EOF
        Exception => 1,
    },
    {
        Name      => 'next with label',
        Filename  => 'test.pl',
        Plugins   => [qw(TidyAll::Plugin::OTRS::Perl::PerlCritic)],
        Framework => '3.5',
        Source    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
KEY:
for my $Key ( 1..3 ) {
    next KEY if (1);
}
EOF
        Exception => 0,
        Result    => <<'EOF',
#!/usr/bin/bash
use strict;
use warnings;
KEY:
for my $Key ( 1..3 ) {
    next KEY if (1);
}
EOF
    },
);

$Self->scripts::test::OTRSCodePolicyPlugins::Run( Tests => \@Tests );

1;
