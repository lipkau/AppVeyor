function Get-AppVeyorArtifact {
    param(
        [Parameter( Mandatory, ValueFromPipeline )]
        [ValidateNotNullOrEmpty()]
        # [AppVeyor.Job]
        [PSCustomObject]
        $Job,

        [String]
        $OutPath = (Get-Location -PSProvider FileSystem).Path,

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
            Uri         = "https://ci.appveyor.com/api/buildjobs/{0}/artifacts" -f $Job.JobId
            Method      = "GET"
            Headers     = @{
                "Authorization" = "Bearer $Token"
            }
            ContentType = "application/json"
        }
        $artifacts = Invoke-RestMethod @invokeRestMethodSplat

        if ($OutPath) {
            $artifacts | ForEach-Object {
                $artifact = $_
                $invokeRestMethodSplat = @{
                    Uri         = "https://ci.appveyor.com/api/buildjobs/{0}/artifacts/{1}" -f $Job.JobId, $artifact.fileName
                    Method      = "GET"
                    Headers     = @{
                        "Authorization" = "Bearer $Token"
                    }
                    OutFile     = "$OutPath/$($artifact.fileName)"
                }
                Invoke-RestMethod @invokeRestMethodSplat
            }
        }
        else {
            $artifacts
        }
    }
}
