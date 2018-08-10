function Get-AppVeyorArtifact {
    param(
        [Parameter( Mandatory, ValueFromPipeline )]
        [ValidateNotNullOrEmpty()]
        [AppVeyor.Job]
        $Job,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]
        $Token = $env:APPVEYOR_API_TOKEN
    )

    begin {
        if (-not $Token) {
            $throwErrorSplat = @{
                ExceptionType = "System.ApplicationException"
                Message       = "Missing Authentication Token"
                ErrorId       = "AppVeyor.MissingToken"
                Category      = "InvalidData"
                Cmdlet        = $PSCmdlet
            }
            ThrowError @throwErrorSplat
        }
    }

    process {
        $invokeRestMethodSplat = @{
            Uri = "https://ci.appveyor.com/api/buildjobs/{0}/artifacts" -f $Job.Id
            Method = "GET"
            Headers = @{
                "Authorization" = "Bearer $Token"
            }
            ContentType = "application/json"
        }
        Invoke-RestMethod @invokeRestMethodSplat
    }
}
