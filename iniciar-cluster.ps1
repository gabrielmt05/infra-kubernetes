# Define o comportamento em caso de erro (opcional, para parar se o 'up' falhar)
$ErrorActionPreference = "Stop"

Write-Host "🚀 Iniciando o ambiente Vagrant (Master, Worker1, Worker2)..." -ForegroundColor Cyan
vagrant up

Write-Host "`n🔧 Forçando o provisionamento dos Workers..." -ForegroundColor Cyan
vagrant provision worker1 worker2

Write-Host "`n✅ Processo finalizado com sucesso!" -ForegroundColor Green

# Pausa para você ver o resultado antes da janela fechar (se rodar com duplo clique)
Read-Host "Pressione ENTER para sair..."