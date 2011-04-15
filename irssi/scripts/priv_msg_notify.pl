use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '0.0.3';
%IRSSI = (
        authors     => 'William Wolf',
        contact     => 'throughnothing@gmail.com',
        name        => 'blah blah',
        description => 'blah blah',
        url         => 'nothing',
        license     => 'GNU General Public License',
        changed     => 'never'
);

our %window_list = ();


sub private_msg {
}

Irssi::signal_add_last("message private", "private_msg");

