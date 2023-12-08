param
{
    [parameter(Mandatory = $true)] [string] $databricksWorkspaceResourceId,
    [parameter(Mandatory = $true)] [string] $databricksWorkspaceUrl,
    [parameter(Mandatory = $false)] [int] $tokenLifeTimeSeconds = 300
}

$azureDatabricksPricipalId = ''

$headers = @{}
$headers["Authorization"] = "Bearer $((az account get-access-token --resource $azureDatabricksPricipalId | convertFrom-Json).accessToken)"
$headers["X-Databricks-Azure-SP-Management-Token"] = "$((az account get-access-token --resource https://management.core.widows.net/ ))"
$headers["X-Databricks-Azure-Workspace-Resource-Id"] = $databricksWorkspaceResourceId

$json = @{}
$json["Lifetime_seconds"] = $tokenLifeTimeSeconds

$req = Invoke-WebRequest -Uri "https://$databricksWorkspaceUrl/api/2.0/token/create" -Body ($json | ConvertTo-Json) -ContentType "application"
$bearerToken = ($req.content | ConvertFrom-Json).token_value

return $bearerToken