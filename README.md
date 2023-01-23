# docker-snmp-agent

Docker for Snmp Agent

## Settings

### Environment variables

Customize variables if you need(optional).

```shell
cp .env.sample .env
vi .env
```

* `APP_PORT`: APP port(udp)
* `ADMIN`: Administrator info
* `SNMPTRAPS_HOST`: SMNP Trap server host name (**require for SNMP Trap test**)

## Run

Build and run service

```shell
make up
```

## Test

```shell
make test
```

## Usage

See [Makefile](./Makefile).

## Note

Here is the sample of adding private MIBs. (add into [entrypoint.sh](./snmp-agent/entrypoint.sh) after `download-mibs` action)


```shell
# Private MIBs
# NEC MIBs
mkdir -p ${MIBS_DIR}/nec
wget https://jpn.nec.com/univerge/ix/Manual/MIB/PICO-SMI-MIB.txt -O ${MIBS_DIR}/nec/PICO-SMI-MIB.txt
wget https://jpn.nec.com/univerge/ix/Manual/MIB/PICO-SMI-ID-MIB.txt -O ${MIBS_DIR}/nec/PICO-SMI-ID-MIB.txt
wget https://jpn.nec.com/univerge/ix/Manual/MIB/PICO-IPSEC-FLOW-MONITOR-MIB.txt -O ${MIBS_DIR}/nec/PICO-IPSEC-FLOW-MONITOR-MIB.txt

## Fujitsu MIBs
mkdir -p ${MIBS_DIR}/fujitsu
cd /var/tmp
wget https://fenics.fujitsu.com/products/downloads/products/download/sr-s/firm/rev22/SRS-MIB.zip
unzip SRS-MIB.zip
unzip SRS-MIB/srs.zip
mv srs.txt ${MIBS_DIR}/fujitsu/SRS-MIB.txt
rm -fr SRS-MIB*
cd

# YAMAHA MIBs
cd ${MIBS_DIR}
wget -O - 'http://www.rtpro.yamaha.co.jp/RT/docs/mib/yamaha-private-mib.tar.gz' | tar zxf -
mv yamaha-private-mib yamaha
chmod -x yamaha/*.txt*
cd
```

## Link

* https://github.com/hakengineer/snmp-agent
* https://qiita.com/caribou_hy/items/85dfb575c1b73a8d0d69
