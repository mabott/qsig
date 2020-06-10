use REST::Client;
use JSON::PP;
use URI::Escape;

use Exporter;

use vars qw(@ISA @EXPORT);

# These are the supported Qumulo API 'calls'
@EXPORT = qw(login create_directory create_file delete_file);

# Ignore SSL Verification
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;

# Use one REST Client for everything
my $client = REST::Client->new();

sub login {
	my $host = shift;
	my $port = shift;
	my $username = shift;
	my $password = shift;
	# establish host/port for future calls, make a login call to the Qumulo
	$client->addHeader('Content-Type', 'application/json');
	$client->setHost("https://$host:$port");
	$client->POST('/v1/session/login', qq( {"username": "$username", "password":"$password"} ));
	# add the bearer token to the headers
	my $json = decode_json ($client->responseContent());
    my $bearer_token = $json->{'bearer_token'};

    $client->addHeader('Authorization', "Bearer $bearer_token");
}

sub create_directory {
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
	# print "$mkdir_json\n";
	$client->POST("/v1/files/$escaped_path/entries/", $mkdir_json);
}

sub create_file {
	my $file_name = shift;
	my $directory_path = shift;
	my $escaped_path = uri_escape("$directory_path");
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
	# print "$createfile_json\n";
	$client->POST("/v1/files/$escaped_path/entries/", $createfile_json);
}

sub delete_file {
    my $full_path = shift;
    my $escaped_path = uri_escape("$full_path");
    $client->DELETE("/v1/files/$escaped_path")
}

1;
