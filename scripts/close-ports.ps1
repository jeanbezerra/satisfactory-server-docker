# Define as portas a serem verificadas
$ports = @(7777, 15000, 15777)

# Função para encerrar processos associados a portas
function Close-PortProcesses {
    param (
        [int]$Port,
        [string]$Protocol
    )
    
    if ($Protocol -eq "TCP") {
        $connections = Get-NetTCPConnection | Where-Object { $_.LocalPort -eq $Port -and $_.State -eq "Listen" }
    } elseif ($Protocol -eq "UDP") {
        $connections = Get-NetUDPEndpoint | Where-Object { $_.LocalPort -eq $Port }
    }
    
    foreach ($conn in $connections) {
        $processId = $conn.OwningProcess
        if ($processId -and ($process = Get-Process -Id $processId -ErrorAction SilentlyContinue)) {
            Write-Host "Encerrando processo $($process.ProcessName) (PID: $processId) na porta $Port/$Protocol"
            Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
        }
    }
}

# Itera sobre as portas e protocolos
foreach ($port in $ports) {
    Close-PortProcesses -Port $port -Protocol "TCP"
    Close-PortProcesses -Port $port -Protocol "UDP"
}