use Qumulo::RESTClient;

# Set your api host/port/creds
my $host = '192.168.11.155';
my $port = '8000';
my $username = 'admin';
my $password = 'Admin123';

# There is probably a way smoother way to express this in perl
login($host, $port, $username, $password);

create_directory('perl_apitest_49', '/');
create_file('file_from_perl', '/perl_apitest_49/');
