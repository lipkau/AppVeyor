function ConvertTo-Project {
    <#
    .SYNOPSIS
        Extracted the conversion to private function in order to have a single place to
        select the properties to use when casting to custom object type
    #>
    [CmdletBinding()]
    [OutputType( [AppVeyor.Project] )]
    param(
        # object to convert
        [Parameter( ValueFromPipeline )]
        [PSCustomObject]
        $InputObject
    )

    process {
        foreach ($object in $InputObject) {
            Write-Verbose "Converting Object to Space"

            [AppVeyor.Project](ConvertTo-Hashtable -InputObject ($object | Select-Object `
                ProjectId,
                AccountId,
                AccountName,
                @{Name = "Builds"; Expression = {
                    if ($_.builds) {
                        ConvertTo-Build $_.builds
                    }
                    else {
                        $null
                    }
                }},
                Name,
                Slug,
                RepositoryType,
                RepositoryScm,
                RepositoryName,
                RepositoryBranch,
                IsPrivate,
                SkipBranchesWithoutAppveyorYml,
                EnableSecureVariablesInPullRequests,
                EnableSecureVariablesInPullRequestsFromSameRepo,
                EnableDeploymentInPullRequests,
                SaveBuildCacheInPullRequests,
                RollingBuilds,
                RollingBuildsDoNotCancelRunningBuilds,
                RollingBuildsOnlyForPullRequests,
                AlwaysBuildClosedPullRequests,
                Tags,
                @{Name = "nuGetFeed"; Expression = {
                    if ($_.nuGetFeed) {
                        ConvertTo-nuGetFeed $_.nuGetFeed
                    }
                    else {
                        $null
                    }
                }},
                Created,
                Updated
            ))
        }
    }
}
