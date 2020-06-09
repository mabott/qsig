use REST::Client;
use JSON::PP;
use URI::Escape;

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;
#The basic use case
my $client = REST::Client->new();

sub QLogin {
	my $host = shift;
	my $port = shift;
	my $username = shift;
	my $password = shift;
	# make a login call to the Qumulo
	$client->addHeader('Content-Type', 'application/json');
	$client->setHost("https://$host:$port");
	$client->POST('/v1/session/login', qq( {"username": "$username", "password":"$password"} ));
}

sub QMkDir {
	my $directory_name = shift;
	my $directory_path = shift;
	my $escaped_path = uri_escape("$directory_path");
my $mkdir_json = <<"END_JSON";
{
    "name": "$directory_name",
    "unix_file_type": "FS_FILE_TYPE_UNKNOWN",
    "major_minor_numbers": {
        "major": 0,
        "minor": 0
    },
    "clobber": true,
    "action": "CREATE_DIRECTORY",
    "symlink_target_type": "FS_FILE_TYPE_UNKNOWN",
    "ref": "$directory_path",
    "old_path": ""
}
END_JSON
	print "$mkdir_json\n";
	$client->POST("/v1/files/$escaped_path/entries/", "$mkdir_json");
}

sub QCreateFile {
	my $file_name = shift;
	my $directory_path = shift;
my $createfile_json = <<"END_JSON";
{
    "name": "$file_name",
    "unix_file_type": "FS_FILE_TYPE_UNKNOWN",
    "major_minor_numbers": {
        "major": 0,
        "minor": 0
    },
    "clobber": true,
    "action": "CREATE_FILE",
    "symlink_target_type": "FS_FILE_TYPE_UNKNOWN",
    "ref": "$directory_path",
    "old_path": ""
}
END_JSON
	print "$createfile_json\n";
	$client->POST('/v1/files')

}

QLogin('192.168.11.155', '8000', 'admin', 'Admin123');

my $json = decode_json ($client->responseContent());
my $bearer_token = $json->{'bearer_token'};

print "$bearer_token";
print "\n";

$client->addHeader('Authorization', "Bearer $bearer_token");
QMkDir('perl_apitest_44', '/');

print $client->responseCode;
print "\n";
print $client->responseHeaders;
print "\n";
print $client->responseContent;
print "\n";

