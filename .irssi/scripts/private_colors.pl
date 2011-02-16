use strict;
use vars qw($VERSION %IRSSI);
use Irssi;

$VERSION = '1.00';
%IRSSI = (
	authors     => 'Khaled Hussein',
	contact     => 'khaled.hussein@gmail.com',
	name        => 'Channel Colors',
	description => 'This script allows you to specify a color for each' .
	'channel that you join. You can specify the colors in a text file.' .
	license     => 'GPL',
);

my %user_colors;
my @colors = qw/2 3 4 5 6 7 9 10 11 12 13/;
my $colors_in_use = 2;

sub change_formats
{
	my $channel = lc shift;
	my $color = $user_colors{$channel};
	Irssi::command('^format own_msg {ownmsgnick %G$2 {ownnick %G$0}}%g$1');
	Irssi::command('^format privmsg {privmsgnick %g$2 {pubnick %g$0}}%N$1');
	Irssi::command('^format privmsg {privmsgnick %g$2 {pubnick %g$0}}'
            .chr(3).$color.'$1');
	Irssi::command(
		'^format privmsg {privmsgnick %g$0 {msgchannel %g$1}}'.
		chr(3).$color.'$2');
}

sub sig_msg_private
{
	my ($server, $msg, $nick, $address, $target) = @_;
    if(!defined($user_colors{$nick})){
        $user_colors{$nick} = $colors_in_use;

        #cycle through the colors
        $colors_in_use = ($colors_in_use + 1) % 14;
        if($colors_in_use < 2){
            $colors_in_use = $colors_in_use + 2;
        }
    }

	change_formats($target);
}

Irssi::signal_add('message private', 'sig_msg_private');
