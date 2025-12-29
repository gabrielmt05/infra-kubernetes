$ErrorActionPreference = "Stop"

Write-Host "🚀 Iniciando o ambiente Vagrant (Master, Worker1, Worker2)..." -ForegroundColor Cyan
vagrant up

Write-Host "`n🔧 Forçando o provisionamento dos Workers..." -ForegroundColor Cyan
vagrant provision worker1 worker2

Write-Host "`n✅ Processo finalizado com sucesso!" -ForegroundColor Green

Read-Host "Pressione ENTER para sair..."