# Perl5 Qumulo RESTful API Example

`qsig.pl`

Login, create directory, create file, delete file, delete directory.

Running the `qsig.pl` code sample produces the following Qumulo Audit output:

```
2020-06-10T18:08:56.694399Z qumulo-1 qumulo 192.168.11.1,"admin",api,rest_login,ok,,"",""
2020-06-10T18:08:56.71679Z qumulo-1 qumulo 192.168.11.1,"admin",api,fs_create_directory,ok,3200003,"/perl_apitest_00/",""
2020-06-10T18:08:56.732212Z qumulo-1 qumulo 192.168.11.1,"admin",api,fs_read_metadata,ok,3200003,"/perl_apitest_00/",""
2020-06-10T18:08:56.736034Z qumulo-1 qumulo 192.168.11.1,"admin",api,fs_create_file,ok,3070004,"/perl_apitest_00/file_from_perl",""
2020-06-10T18:08:56.749358Z qumulo-1 qumulo 192.168.11.1,"admin",api,fs_delete,ok,3070004,"/perl_apitest_00/file_from_perl",""
2020-06-10T18:08:56.763292Z qumulo-1 qumulo 192.168.11.1,"admin",api,fs_delete,ok,3200003,"/perl_apitest_00/",""
```

## Using Qumulo::RESTClient

To use the Perl5 RESTClient in your Perl script/module:

```Perl
use Qumulo::RESTClient;
```

Then you can call functions directly:

```Perl
login($host, $port, $username, $password);

create_directory($test_directory, $test_path);
create_file($test_file, $test_path . $test_directory);

delete_file($test_path . $test_directory . '/' . $test_file);
delete_directory($test_path . $test_directory);
```
