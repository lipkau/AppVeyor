function ConvertTo-Build {
    <#
    .SYNOPSIS
        Extracted the conversion to private function in order to have a single place to
        select the properties to use when casting to custom object type
    #>
    [CmdletBinding()]
    [OutputType( [AppVeyor.Build] )]
    param(
        # object to convert
        [Parameter( ValueFromPipeline )]
        [PSCustomObject]
        $InputObject
    )

    process {
        foreach ($object in $InputObject) {
            Write-Verbose "Converting Object to Space"

            [AppVeyor.Build](ConvertTo-Hashtable -InputObject ($object | Select-Object `
                        BuildId,
                    @{Name = "Jobs"; Expression = {ConvertTo-Job $_.jobs}},
                    BuildNumber,
                    Version,
                    Message,
                    Branch,
                    IsTag,
                    CommitId,
                    AuthorName,
                    AuthorUsername,
                    CommitterName,
                    CommitterUsername,
                    Committed,
                    Messages,
                    Status,
                    Started,
                    Finished,
                    Created,
                    Updated
                ))
        }
    }
}
