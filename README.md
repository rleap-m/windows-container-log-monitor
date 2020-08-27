# Windows Container Log Monitor Tool

Microsoft provides some [troubleshooting guidance for Windows Containers](https://docs.microsoft.com/en-us/virtualization/windowscontainers/troubleshooting).  In that guidance there is reference to a ```LogMonitor.exe``` tool and a link to its [GitHub repo](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor).  I could not find the compiled executable for download so I compiled it myself (and stashed it here in the repo):

## Build
1. Cloned the LogMonitor [GitHub repo](https://github.com/microsoft/windows-container-tools/tree/master/LogMonitor)
1. Downloaded and installed Visual Studio Community Edition (2019)
1. Chose '.NET desktop development' and 'Desktop development with C++' for Workloads (guesses)
1. Was not able to compile project - turns out I needed build tools that came with VS 2017
1. Under 'Individual Components' --> [X] C++/CLI support for v141 build tools. ![Visual Studio 2017 Build Tools - needed to Compile](./images/vs2017-build-tools.png)
1. Open the (cloned) project (LogMonitor.sln)
1. Changed Build --> Configuration Manager --> Active solution configuration --> Release
1. Build LogMonitor: ![Visual Studio 2017 Build Tools - needed to Compile](./images/log-monitor-build-output.png)

Alternatively, I was able to compile from the command line as follows:

```& 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\MSBuild.exe' .\LogMonitor.sln /p:platform=x64 /p:configuration=Release```

## Release Info
```
        C:\Tools\LogMonitor.exe /?

        LogMonitor Tool Version 1.1.0.0

        Usage: LogMonitor.exe [/?] | [--help] | [[/CONFIG <PATH>][COMMAND [PARAMETERS]]]

        /?|--help   Shows help information
        <PATH>      Specifies the path of the Json configuration file. This is
                    an optional parameter. If not specified, then default Json
                    configuration file path C:\LogMonitor\LogMonitorConfig.json is used
        COMMAND     Specifies the name of the executable to be run
        PARAMETERS  Specifies the parameters to be passed to the COMMAND

        This tool monitors Event log, ETW providers and log files and write the log entries
        to the console. The configuration of input log sources is specified in a Json file.
        file.
```
## Download

- LogMonitor Utility - ```Invoke-WebRequest -Uri https://github.com/rleap-m/windows-container-log-monitor/raw/master/bin/LogMonitor.exe -OutFile LogMonitor.exe```
- Sample Config File - ```Invoke-WebRequest -Uri https://github.com/microsoft/windows-container-tools/raw/master/LogMonitor/src/LogMonitor/sample-config-files/IIS/LogMonitorConfig.json -OutFile LogMonitorConfig.json```


## Usage

- [Log Monitor Release Blog](https://techcommunity.microsoft.com/t5/containers/windows-containers-log-monitor-opensource-release/ba-p/973947)
- [Sample LogMonitorConfig.json](https://github.com/microsoft/windows-container-tools/blob/master/LogMonitor/src/LogMonitor/sample-config-files/IIS/LogMonitorConfig.json)

## Example

A DockerHub repo is available with an image which runs the demo script in this GitHub repo which produces various
log output which is captured by the ```LogMonitor.exe``` tool.

https://hub.docker.com/r/rleapm/windows-container-log-monitor

Notice that the ```docker logs``` command is capturing four different types of output (because of the magic of ```LogMonitor.exe```) in this order (the order in which the script is producing the output):
1. Verbose
1. STDOUT
1. Log file (simple text log file on disk)
1. Event Log Application events

```powershell
PS C:\temp> $id = docker run --rm -d rleapm/windows-container-log-monitor
PS C:\temp> docker logs -f $id
```
```
VERBOSE: This is a sample log message.
[stdout] This is a sample log message.
[2020-08-27T22:00:13][3855BD855979] This is a sample log message.
<Source>EventLog</Source><Time>2020-08-27T22:00:13.000Z</Time><LogEntry><Channel>Application</Channel><Level>Information</Level><EventId>1</EventId><Message>This is a sample log message.</Message></LogEntry>
VERBOSE: This is a sample log message.
[stdout] This is a sample log message.
[2020-08-27T22:00:18][3855BD855979] This is a sample log message.
<Source>EventLog</Source><Time>2020-08-27T22:00:18.000Z</Time><LogEntry><Channel>Application</Channel><Level>Information</Level><EventId>1</EventId><Message>This is a sample log message.</Message></LogEntry>
...
```