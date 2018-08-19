function ConvertTo-nuGetFeed {
    <#
    .SYNOPSIS
        Extracted the conversion to private function in order to have a single place to
        select the properties to use when casting to custom object type
    #>
    [CmdletBinding()]
    [OutputType( [AppVeyor.nuGetFeed] )]
    param(
        # object to convert
        [Parameter( ValueFromPipeline )]
        [PSCustomObject]
        $InputObject
    )

    process {
        foreach ($object in $InputObject) {
            Write-Verbose "Converting Object to Space"

            [AppVeyor.nuGetFeed](ConvertTo-Hashtable -InputObject ($object | Select-Object `
                        Id,
                    Name,
                    AccountId,
                    ProjectId,
                    IsPrivateProject,
                    PublishingEnabled,
                    AccountTimeZoneId,
                    Created
                ))
        }
    }
}
