#region Dependencies
#region ModuleConfig
# Add our own Converters for serialization
function Get-Widget {
    [CmdletBinding()]
    param (

    )

    begin {
    }

    process {
        Write-Host "aaa"
    }

    end {
    }
}

function Verb-Noun {
    [CmdletBinding()]
    param (

    )

    begin {
    }

    process {
        Write-Host "argh!"
    }

    end {
    }
}


