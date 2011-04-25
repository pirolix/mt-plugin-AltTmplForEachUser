package MT::Plugin::OMV::AltTmplForEachUser;

use strict;
use File::Spec;

use vars qw( $MYNAME $VERSION );
$MYNAME = (split /::/, __PACKAGE__)[-1];
$VERSION = '0.01';

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new({
    name => $MYNAME,
    id => lc $MYNAME,
    key => lc $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    doc_link => 'http://www.magicvox.net/archive/2010/11031440/',
    description => <<PERLHEREDOC,
<__trans phrase="Switch the altenative templates folder (alt-tmpl) for each users.">
PERLHEREDOC
    registry => {
        callbacks => {
            'MT::App::CMS::pre_run' => \&pre_run,
        },
    },
});
MT->add_plugin ($plugin);

sub instance { $plugin; }

### Callbacks - MT::App::CMS::pre_run
sub pre_run {
    my ($cb, $app) = @_;

    my $username = $app && $app->user && $app->user->name
        or return; # do nothing
    my $alt_tmpl = $app->config ('AltTemplatePath')
        or return; # do nothing

    $alt_tmpl = File::Spec->catdir ($alt_tmpl, $username);
    $app->config ('AltTemplatePath', $alt_tmpl) if -d $alt_tmpl;
}

1;