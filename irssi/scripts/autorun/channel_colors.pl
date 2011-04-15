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

my %channel_colors;
my @colors = qw/2 3 4 5 6 7 9 10 11 12 13/;
our $colors_in_use = 2;

sub change_formats
{
	my $channel = lc shift;
	my $color = $channel_colors{$channel};

	Irssi::command('^format own_msg {ownmsgnick %G$2 {ownnick %G$0}}%g$1');
	Irssi::command('^format pubmsg {pubmsgnick %g$2 {pubnick %g$0}}'
            .chr(3).$color.'$1');
	Irssi::command(
		'^format pubmsg_channel {msgnick %g$0 {msgchannel %g$1}}'.
		chr(3).$color.'$2');
}

sub update_colors {
	my $channel = shift;
	if (!defined($channel_colors{ $channel })){
        $channel_colors{$channel} = $colors_in_use;

        #cycle through the colors
        $colors_in_use = ($colors_in_use + 1) % 14 + 2;
	}
}

sub sig_msg_public
{
	my ($server, $msg, $nick, $address, $target) = @_;
	update_colors($target);
	change_formats($target);
}

sub sig_msg_private
{
	my ($server, $msg, $nick, $address) = @_;
	update_colors($address);
	change_formats($address);
}

sub channel_colors_list{
	while(my ($key,$value) = each(%channel_colors)){
		print "$key: $value";
	}
}

sub sig_ignore
{
	Irssi::signal_stop();
}

Irssi::signal_add('message public', 'sig_msg_public');
Irssi::signal_add('message private', 'sig_msg_private');
Irssi::signal_add('message join', 'sig_ignore');
Irssi::signal_add('message quit', 'sig_ignore');
Irssi::signal_add('message nick', 'sig_ignore');
Irssi::signal_add('message part', 'sig_ignore');
Irssi::command_bind("channel_colors_list","channel_colors_list");
