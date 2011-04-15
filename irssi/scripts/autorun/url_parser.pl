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

our @url_list = ();
our $url_list_size = 30;


sub msg_parse {
    my ($server, $msg, $nick, $address) = @_;
    my $url = "";

    $msg =~ /.*((((http[s]?|ftp):\/?\/?)|www\.)[^ <>]*).*/;


    $url =  $1;
    if($url ne ""){
        unshift(@url_list,$url);

        #Make sure the list doesn't get too big
        my $len = @url_list;
        if($len > $url_list_size){
            pop(@url_list)
        }
    }
}

sub process_url{
    my $num = shift;

    $num = defined($num) ? $num : 1;
    $num = $num - 1;

	if ($url_list[$num]){
		print "Loading: $url_list[$num]";
		`firefox --new-tab $url_list[$num]`;
	}else{
		print "No URL found in slot $num";
	}
}

sub list_urls{
	my $i = 1;
	print "Captured Url List:";
	foreach(@url_list){
		my $url = $url_list[$i - 1];
		print "$i: $url";
		$i++;
	}
}


Irssi::signal_add_last("message private", "msg_parse");
Irssi::signal_add_last("message public", "msg_parse");

Irssi::command_bind("url_open","process_url");

Irssi::command_bind("url_list","list_urls");

