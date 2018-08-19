function ConvertTo-Job {
    <#
    .SYNOPSIS
        Extracted the conversion to private function in order to have a single place to
        select the properties to use when casting to custom object type
    #>
    [CmdletBinding()]
    [OutputType( [AppVeyor.Job] )]
    param(
        # object to convert
        [Parameter( ValueFromPipeline )]
        [PSCustomObject]
        $InputObject
    )

    process {
        foreach ($object in $InputObject) {
            Write-Verbose "Converting Object to Space"

            [AppVeyor.Job](ConvertTo-Hashtable -InputObject ($object | Select-Object `
                        JobId,
                    Name,
                    OsType,
                    AllowFailure,
                    MessagesCount,
                    CompilationMessagesCount,
                    CompilationErrorsCount,
                    CompilationWarningsCount,
                    TestsCount,
                    PassedTestsCount,
                    FailedTestsCount,
                    ArtifactsCount,
                    Status,
                    Started,
                    Finished,
                    Created,
                    Updated
                ))
        }
    }
}
