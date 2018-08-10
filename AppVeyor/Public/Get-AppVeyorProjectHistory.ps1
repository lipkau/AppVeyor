function Get-AppVeyorProjectHistory {
    param(
        [Parameter( Mandatory, ValueFromPipeline )]
        [ValidateNotNullOrEmpty()]
        [AppVeyor.Project]
        $Project,

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
            Uri = "https://ci.appveyor.com/api/projects/$env:APPVEYOR_ACCOUNT_NAME/$env:APPVEYOR_PROJECT_SLUG/history"
            # ?recordsNumber=2
            Method = "GET"
            Headers = @{
                "Authorization" = "Bearer $Token"
            }
            ContentType = "application/json"
        }
        Invoke-RestMethod @invokeRestMethodSplat
    }
}
