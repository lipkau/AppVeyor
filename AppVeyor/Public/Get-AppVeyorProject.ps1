function Get-AppVeyorProject {
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]
        $AccountName = $env:APPVEYOR_ACCOUNT_NAME,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]
        $ProjectName = $env:APPVEYOR_PROJECT_SLUG,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]
        $Token = $env:APPVEYOR_API_TOKEN
    )

    begin {
        if (-not $AccountName) {
            $throwErrorSplat = @{
                ExceptionType = "System.ApplicationException"
                Message       = "Missing AccountName"
                ErrorId       = "AppVeyor.MissingAccountName"
                Category      = "InvalidData"
                Cmdlet        = $PSCmdlet
            }
            ThrowError @throwErrorSplat
        }

        if (-not $ProjectName) {
            $throwErrorSplat = @{
                ExceptionType = "System.ApplicationException"
                Message       = "Missing ProjectName"
                ErrorId       = "AppVeyor.MissingProjectName"
                Category      = "InvalidData"
                Cmdlet        = $PSCmdlet
            }
            ThrowError @throwErrorSplat
        }

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
            Uri = "https://ci.appveyor.com/api/projects/$AccountName/$ProjectName"
            Method = "GET"
            Headers = @{
                "Authorization" = "Bearer $Token"
            }
            ContentType = "application/json"
        }
        Write-Debug "Using `$invokeRestMethodSplat"
        $response = Invoke-RestMethod @invokeRestMethodSplat

        New-Object -TypeName PSCustomObject -Property @{
            Project = [AppVeyor.Project]$response.project
            Build = [AppVeyor.Build]$response.build
        }
    }
}
