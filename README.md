# SMB Global Mapping

## Persistent storage option for Windows Containers

One option for persistent storage for Windows Containers is an SMB share which via 'SMB global mapping' feature became available to (all) containers (on a particular host) with Windows Server 1709:

[SMB global mapping feature](https://docs.microsoft.com/en-us/windows-server/storage/file-server/file-server-smb-overview#features-added-in-windows-server-version-1709-and-windows-10-version-1709)

The 'global' refers to the fact that a share mapped in this way "*is accessible to all users on the local host, including containers.*"  This type of mapping is done with a cmdlet which requires a credential and it is with that credential that all users read/write to the share.

This article about [SMB Mounts](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/persistent-storage#configuration-steps) includes an example using the `New-SmbGlobalMapping`. Note that the cmdlet does not seem to be well documented but that there is a `[-Persistent]` switch which should allow the mapping to survive reboots (though there would be a gotcha I assume on a password change to the account used to make the mapping).  I am not sure if you can use a managed service account for a credential in this case.

## Topic Overview and Deep Dives

- [Docker Volumes](https://docs.docker.com/storage/volumes/)
- [Container Storage Support](https://techcommunity.microsoft.com/t5/failover-clustering/container-storage-support-with-cluster-shared-volumes-csv/ba-p/372140)
- [Failover clustering](https://techcommunity.microsoft.com/t5/failover-clustering/bg-p/FailoverClustering)

## Mirantis Related Issues

- [Windows Volume Permissions](https://mirantis.jira.com/browse/FIELD-2329)