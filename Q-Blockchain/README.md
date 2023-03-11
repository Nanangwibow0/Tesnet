# Q-Blockchain Tesnet 


### Official Link

* ​[Discord](https://discord.gg/BwVVzpBkAD)​
* ​[Guide](https://docs.qtestnet.org/how-to-setup-validator/)​
* ​[Gitlab](https://gitlab.com/q-dev)​
* ​[Reddit](https://www.reddit.com/r/QBlockchain/)​
* ​[Explorer](https://explorer.qtestnet.org/)​
* ​[Medium](https://medium.com/q-blockchain)​
* ​[Faucet](https://faucet.qtestnet.org/)​
* ​[Cek Validator](https://stats.qtestnet.org/)​

_____________


### mulai

```
wget -O QB.sh https://raw.githubusercontent.com/nanang472/Tesnet/main/Q-Blockchain/QB.sh && chmod +x QB.sh && ./QB.sh
```
_____________


### Membuat Password Wallet

```
cd
cd ~/testnet-public-tools/testnet-validator
nano keystore/pwd.txt
```
> * Simpan, CTRL+X Y Enter

_____________


### Create Wallet Baru

```
docker run --entrypoint="" --rm -v $PWD:/data -it qblockchain/q-client:testnet geth account new --datadir=/data --password=/data/keystore/pwd.txt
```
_____________


### Restore wallet

pastikan Anda memiliki atau telah mendownload file key json sebelumnya. upload file json wallet yang lama ke /root/testnet-public-tools/testnet-validator/keystore/

* Edit konfigurasi .env & config.json
```bash
cd
cd ~/testnet-public-tools/testnet-validator
nano .env
```
* ADDRES=<addres-lama-mu> tanpa 0x
* IP=<ip-vps-mu>
* Paste konfigurasi berikut di bawah BOOTNODE3_ADDR=enode:..
```bash
BOOTNODE4_ADDR=enode://85d6f24920a0f552a5e0360366d18fb1234880c4370f257abc09e8ec762173fb3c4b1b14a7af9a23a8c31751b3ba2905d6a98fb436dfe3092644527a89046977@3.68.108.12:30303
BOOTNODE5_ADDR=enode://ec40af9079c53e880f7e783ae5053b18d1f8bb8cd55b2dfbbfa3b7e1f5256c724ef7e22f23f785c2f119fbb7930769540e3c01c711c6ae26c83690b941a4886c@85.215.92.83:30303
BOOTNODE6_ADDR=enode://1032c556fbbfe37761951a20c2b98b4031234a8f871cc79dd8ff612a3e0436afe3458b325d2f25617b62134cfc8a8a4885e80c9760ecb4bb7c8deaee67a098ae@95.217.169.172:30303
BOOTNODE7_ADDR=enode://e974d9354ababd356a6bfecbb03a59d14ab715ffa02d431c6accfc5de250e9c8c345817bd5687c119a04df78f1a4673e97877ea5775fa84270d311dac4a2eca7@128.199.213.70:30313
```
CTRL X+Y ENTER

```
nano config.json
```
address=<adrees-lama-mu> tanpa 0x
password=<pasword-lama_mu>

```
docker compose run testnet-validator-node --datadir /data account update <Address-Lama-mu>
```
_____________


### Claim Faucet 

Klaim faucet: [faucet.qtestnet.org](https://faucet.qtestnet.org/)​
_____________


### Stake Contract
```
cd
cd ~/testnet-public-tools/testnet-validator
docker run --rm -v $PWD:/data -v $PWD/config.json:/build/config.json qblockchain/js-interface:testnet validators.js

```
_____________

_____________


### Daftar Validator
Daftarkan walletmu untuk menjalankan Node [Register Form](https://itn.qdev.li/)
Simpan ITN-nama-xx Pada notepad

**Jalankan Node**

```
cd
cd ~/testnet-public-tools/testnet-validator
rm -rf docker-compose.yaml
nano docker-compose.yaml
```

Paste konfigurasi dibwah ini : 
```
version: "3"

services:
  testnet-validator-node:
    image: $QCLIENT_IMAGE
    entrypoint: [
      "geth",
      "--testnet",
      "--datadir=/data",
      "--syncmode=full",
      "--ethstats=<VALIDATOR_STATS_ID>:qstats-testnet@stats.qtestnet.org",
      "--whitelist=3699041=0xabbe19ba455511260381aaa7aa606b2fec2de762b9591433bbb379894aba55c1",
      "--bootnodes=$BOOTNODE1_ADDR,$BOOTNODE2_ADDR,$BOOTNODE3_ADDR,$BOOTNODE4_ADDR,$BOOTNODE5_ADDR,$BOOTNODE6_ADDR,$BOOTNODE7_ADDR",
      "--verbosity=3",
      "--nat=extip:$IP",
      "--port=$EXT_PORT",
      "--unlock=$ADDRESS",
      "--password=/data/keystore/pwd.txt",
      "--mine",
      "--miner.threads=1",
      "--miner.gasprice=1",
      "--rpc.allow-unprotected-txs"
    ]
    volumes:
      - ./keystore:/data/keystore
      - ./additional:/data/additional
      - testnet-validator-node-data:/data
    ports:
      - $EXT_PORT:$EXT_PORT/tcp
      - $EXT_PORT:$EXT_PORT/udp
    restart: unless-stopped

volumes:
  testnet-validator-node-data:

```

Ganti **<VALIDATOR_STATS_ID>** dengan Stats ID validatormu yang diberikan dari [Register Form](https://itn.qdev.li/) seperti ITN-xxxxx-xxxxx dan buang tanda <> nya
Kemudian CTRL X+Y ENTER

_____________

### Run NODE
```bash
cd
cd ~/testnet-public-tools/testnet-validator
docker compose up -d
```

### Cek LOGS
```bash
cd
cd ~/testnet-public-tools/testnet-validator
docker compose logs -f
```
* Untuk keluar dari sesi logs gunakan `CTRL+C` atau `CTRL+Z`

_____________


### Cek status Validator
[Q Network Status](https://stats.qtestnet.org/)

_____________

### Set RPC Q-Testnet
- Name: Q Testnet
- RPC URL: https://rpc.qtestnet.org
- Chaind ID: 35443
- Ticker: Q
- Explorer: https://explorer.qtestnet.org/

_____________

### Delete Node
```
cd
cd ~/testnet-public-tools/testnet-validator
docker compose down
```
```
cd
rm -rf testnet-public-tools
rm -rf qb.sh
```