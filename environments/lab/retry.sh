#!/bin/bash
while true; do
  echo "[$(date)] Tentando provisionar instâncias..."
  terraform apply -auto-approve
  if [ $? -eq 0 ]; then
    echo "🎉 Sucesso! A Oracle liberou as máquinas!"
    break
  else
    echo "Ainda sem capacidade. Aguardando 2 minutos..."
    sleep 120
  fi
done