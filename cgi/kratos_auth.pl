#!/usr/bin/perl -w

# This file is part of Product Opener.
#
# Product Opener
# Copyright (C) 2011-2020 Association Open Food Facts
# Contact: contact@openfoodfacts.org
# Address: 21 rue des Iles, 94100 Saint-Maur des Fossés, France
#
# Product Opener is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

use Modern::Perl '2017';
use utf8;

use ProductOpener::Users qw/:all/;

use LWP::UserAgent;

my $myCookie = cookie("ory_kratos_session");
print $myCookie;

if(defined $myCookie){
    my $url = "http://world.openfoodfacts.localhost/cgi/kratos_auth.pl/session/whoami";

    my $ua = LWP::UserAgent->new;

    # set custom HTTP request header fields, must include cookie for /session/whoami
    my $req = HTTP::Request->new(GET => $url);
    $req->header('content-type' => 'application/json');
    $req->header('Cookie' => $myCookie);

    my $resp = $ua->request($req);

    if ($resp->is_success) {
        my $json = $resp->decoded_content;
        print $json;
    }
    else {
        print "HTTP GET error code: ", $resp->code, "n";
        print "HTTP GET error message: ", $resp->message, "n";
    }
}







