
# Blocktopia-01 Tesnet


*Instalasi Otomatis
```bash
wget https://raw.githubusercontent.com/nanang472/Tesnet/main/Blocktopia-01/block.sh
chmod +x block.sh
./block.sh
```

*Load variable ke system
```bash
source $HOME/.bash_profile
```

*SNAPSHOT SETIAP 10 JAM !!!
```bash
sudo apt install lz4 -y
sudo systemctl stop bonus-blockd
cp $HOME/.bonusblock/data/priv_validator_state.json $HOME/.bonusblock/priv_validator_state.json.backup
rm -rf $HOME/.bonusblock/data
curl -L https://snapshot.bonusblock.alfonova.app/bonusblock/bonusblock-snapshot-20230320.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.bonusblock
mv $HOME/.bonusblock/priv_validator_state.json.backup $HOME/.bonusblock/data/priv_validator_state.json
```
*restar 
```bash
sudo systemctl restart bonus-blockd && sudo journalctl -u bonus-blockd -f --no-hostname -o cat
```

# Informasi node

* cek sync node
```bash
bonus-blockd status 2>&1 | jq .SyncInfo
```

*cek log node
```bash
journalctl -fu bonus-blockd -o cat
```

* cek node info
```bash
bonus-blockd status 2>&1 | jq .NodeInfo
```

* cek validator info
```bash
bonus-blockd status 2>&1 | jq .ValidatorInfo
```

*cek node id
```bash
bonus-blockd tendermint show-node-id
```

# Membuat dan recover wallet

* Buat wallet baru
```bash
bonus-blockd keys add $WALLET
```

* recover wallet
```bash
bonus-blockd keys add $WALLET --recover
```

*list wallet
```bash
bonus-blockd keys list
```

*hapus wallet
```bash
bonus-blockd keys delete $WALLET
```

*Simpan informasi wallet
```
BONUS_WALLET_ADDRESS=$(bonus-blockd keys show $WALLET -a)
BONUS_VALOPER_ADDRESS=$(bonus-blockd keys show $WALLET --bech val -a)
echo 'export BONUS_WALLET_ADDRESS='${BONUS_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export BONUS_VALOPER_ADDRESS='${BONUS_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```

# Membuat validator

* daftar : [https://app.bonusblock.io](https://app.bonusblock.io?ref=DBXu4w7b)
* faucet : [https://faucet.bonusblock.io](https://faucet.bonusblock.io/)

* cek balance
```bash
bonus-blockd query bank balances $BONUS_WALLET_ADDRESS
```

*membuat validator
```bash
bonus-blockd tx staking create-validator \
  --amount 100000ubonus \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --identity="<your_keybase_id>" \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(bonus-blockd tendermint show-validator) \
  --moniker $NODENAME \
  --gas=auto \
  --gas-adjustment=1.2 \
  --gas-prices=0.025ubonus \
  --chain-id $BONUS_CHAIN_ID
```

* edit validator
```bash
bonus-blockd tx staking edit-validator \
  --new-moniker="nama-node" \
  --identity="<your_keybase_id>" \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$BONUS_CHAIN_ID \
  --gas=auto \
  --fees=260000000ubonus \
  --gas-adjustment=1.2 \
  --from=$WALLET
```

* unjail validator
```bash
bonus-blockd tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$BONUS_CHAIN_ID \
  --fees=200000000ubonus \
  --gas-adjustment=1.2 \
  --gas=auto
```

* Voting
```bash
bonus-blockd tx gov vote 1 yes --from $WALLET --chain-id=$BONUS_CHAIN_ID --gas=auto --fees=2500000ubonus
```

# Delegasi dan Rewards

* delegasi
```bash
bonus-blockd tx staking delegate $BONUS_VALOPER_ADDRESS 1000000000000ubonus --from=$WALLET --chain-id=$BONUS_CHAIN_ID --gas=auto --fees=250000ubonus
```

* withdraw reward
```bash
bonus-blockd tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$BONUS_CHAIN_ID --gas=auto --fees=2500000ubonus
```

* withdraw reward beserta komisi
```bash
bonus-blockd tx distribution withdraw-rewards $BONUS_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$BONUS_CHAIN_ID --gas=auto --fees=2500000ubonus
```

# Hapus Node
```bash
sudo systemctl stop bonus-blockd && \
sudo systemctl disable bonus-blockd && \
rm -rf /etc/systemd/system/bonus-blockd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf BonusBlock-chain && \
rm -rf bonus.sh && \
rm -rf .bonusblock && \
rm -rf $(which bonus-blockd)
```
