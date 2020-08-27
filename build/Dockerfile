FROM mcr.microsoft.com/windows/servercore:ltsc2019
COPY src\ C:\\scripts
RUN dir C:\scripts

# LogMonitor directory needs to contain LogMonitor.exe and LogMonitorConfig.json file
COPY bin\ C:\\LogMonitor
COPY config\ C:\\LogMonitor
RUN dir C:\LogMonitor
WORKDIR C:\\LogMonitor
SHELL ["C:\\LogMonitor\\LogMonitor.exe", "powershell.exe"]

# Register the Event Log source that 'Start-LogMonitorDemo.ps1' uses
RUN ["powershell", "-command", "New-EventLog", "-LogName", "Application", "-Source", "LogMonitorDemo"]

ENTRYPOINT C:\scripts\Start-LogMonitorDemo.ps1 -Verbose