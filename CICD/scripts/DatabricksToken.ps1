param
{
    [parameter(Mandatory = $true)] [string] $databricksWorkspaceResourceId,
    [parameter(Mandatory = $true)] [string] $databricksWorkspaceUrl,
    [parameter(Mandatory = $false)] [int] $tokenLifeTimeSecods = 300
}

$azureDatabricksPricipalId = ''

$headers = @{}
$headers["Authorization"] = "Bearer $((az account get-access-token --resource $azureDatabricksPricipalId | convertFrom-Json).accessToken)"
$headers["X-Databricks-Azure-SP-Management-Token"] = "$"