# Descargar el archivo MSI del agente de CloudWatch
Invoke-WebRequest -Uri "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi" -OutFile "$env:USERPROFILE\Desktop\amazon-cloudwatch-agent.msi"

# Verificar si el archivo MSI se descargó correctamente
if (Test-Path -Path "$env:USERPROFILE\Desktop\amazon-cloudwatch-agent.msi") {
    Write-Host "El archivo MSI se descargó correctamente."
} else {
    Write-Host "No se pudo descargar el archivo MSI."
    exit
}

# Instalar el agente de CloudWatch utilizando el archivo MSI
msiexec /i "$env:USERPROFILE\Desktop\amazon-cloudwatch-agent.msi"

# Descargar el archivo de configuración desde GitHub
# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/FernandoFH/AGDate/main/config.json" -OutFile "$env:ProgramFiles\Amazon\AmazonCloudWatchAgent\config.json"
Invoke-WebRequest -Uri "https://github.com/FernandoFH/AGDate/blob/main/config.json" -OutFile "$env:ProgramFiles\Amazon\AmazonCloudWatchAgent\config.json"

# Ejecutar el comando de configuración del agente de CloudWatch
& "$env:ProgramFiles\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -c "file:$env:ProgramFiles\Amazon\AmazonCloudWatchAgent\config.json" -s

# Verificar el estado del agente de CloudWatch
& "$env:ProgramFiles\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a status
