using System;
using System.Collections.Generic;
using System.Collections;
// using System.Linq;

namespace AppVeyor
{
    public enum ArtifactType
    {
        File
    }

    public enum OSType
    {
        Ubuntu
    }

    public enum Status
    {
        success
    }

    public enum RepositoryType
    {
        gitHub
    }

    public enum RepositoryScm
    {
        git
    }

    public class Project
    {
        public UInt32 ProjectId { get; set; }
        public UInt32 AccountId { get; set; }
        public String AccountName { get; set; }
        public Build[] Builds { get; set; }
        public String Name { get; set; }
        public String Slug { get; set; }
        public RepositoryType RepositoryType { get; set; }
        public RepositoryScm RepositoryScm { get; set; }
        public String RepositoryName { get; set; }
        public String RepositoryBranch { get; set; }
        public Boolean IsPrivate { get; set; }
        public Boolean SkipBranchesWithoutAppveyorYml { get; set; }
        public Boolean EnableSecureVariablesInPullRequests { get; set; }
        public Boolean EnableSecureVariablesInPullRequestsFromSameRepo { get; set; }
        public Boolean EnableDeploymentInPullRequests { get; set; }
        public Boolean SaveBuildCacheInPullRequests { get; set; }
        public Boolean RollingBuilds { get; set; }
        public Boolean RollingBuildsDoNotCancelRunningBuilds { get; set; }
        public Boolean RollingBuildsOnlyForPullRequests { get; set; }
        public Boolean AlwaysBuildClosedPullRequests { get; set; }
        public String Tags { get; set; }
        public nuGetFeed nuGetFeed { get; set; }
        // public SecurityDescriptor SecurityDescriptor { get; set; }
        public DateTime Created { get; set; }
        public DateTime Updated { get; set; }
    }

    public class Build
    {
        public UInt32 BuildId { get; set; }
        public Job Jobs { get; set; }
        public UInt32 BuildNumber { get; set; }
        public String Version { get; set; }
        public String Message { get; set; }
        public String Branch { get; set; }
        public Boolean IsTag { get; set; }
        public String CommitId { get; set; }
        public String AuthorName { get; set; }
        public String AuthorUsername { get; set; }
        public String CommitterName { get; set; }
        public String CommitterUsername { get; set; }
        public DateTime Committed { get; set; }
        public String[] Messages { get; set; }
        public Status Status { get; set; }
        public DateTime Started { get; set; }
        public DateTime Finished { get; set; }
        public DateTime Created { get; set; }
        public DateTime Updated { get; set; }
    }

    public class Job
    {
        public String JobId { get; set; }
        public String Name { get; set; }
        public OSType OsType { get; set; }
        public Boolean AllowFailure { get; set; }
        public UInt32 MessagesCount { get; set; }
        public UInt32 CompilationMessagesCount { get; set; }
        public UInt32 CompilationErrorsCount { get; set; }
        public UInt32 CompilationWarningsCount { get; set; }
        public UInt32 TestsCount { get; set; }
        public UInt32 PassedTestsCount { get; set; }
        public UInt32 FailedTestsCount { get; set; }
        public UInt32 ArtifactsCount { get; set; }
        public Status Status { get; set; }
        public DateTime Started { get; set; }
        public DateTime Finished { get; set; }
        public DateTime Created { get; set; }
        public DateTime Updated { get; set; }
    }

    public class Artifact
    {
        public String FileName { get; set; }
        public ArtifactType Type { get; set; }
        public UInt32 Size { get; set; }
        public DateTime Created { get; set; }
    }

    public class nuGetFeed
    {
        public String Id { get; set; }
        public String Name { get; set; }
        public UInt32 AccountId { get; set; }
        public UInt32 ProjectId { get; set; }
        public Boolean IsPrivateProject { get; set; }
        public Boolean PublishingEnabled { get; set; }
        public String AccountTimeZoneId { get; set; }
        public DateTime Created { get; set; }
    }

    public class SecurityDescriptor
    {
        public AccessRightDefinition[] AccessRightDefinitions { get; set; }
        public RoleAce[] RoleAces { get; set; }
    }

    public class AccessRightDefinition
    {
        public String Name { get; set; }
        public String Description { get; set; }
    }

    public class RoleAce
    {
        public UInt32 RoleId { get; set; }
        public String Name { get; set; }
        public Boolean IsAdmin { get; set; }
        public AccessRight AccessRights { get; set; }
    }

    public class AccessRight
    {
        public String Name { get; set; }
        public Boolean Allowed { get; set; }
    }
}
