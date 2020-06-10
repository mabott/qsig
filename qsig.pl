use Qumulo::RESTClient;

# Set your api host/port/creds
my $host = '192.168.11.155';
my $port = '8000';
my $username = 'admin';
my $password = 'Admin123';

my $test_path = '/';
my $test_directory = 'perl_apitest_00';
my $test_file = 'file_from_perl';

login($host, $port, $username, $password);

create_directory($test_directory, $test_path);
create_file($test_file, $test_path . $test_directory);

delete_file($test_path . $test_directory . '/' . $test_file);
delete_directory($test_path . $test_directory);
