# docker-snmp-agent

Docker for Snmp-Agent

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

## Note

See [Makefile](./Makefile).

## Link

* [hakengineer/snmp\-agent: test](https://github.com/hakengineer/snmp-agent)
* [server \- Failed to start snmpd\.service on UBUNTU Linux OS \- Ask Ubuntu](https://askubuntu.com/questions/1334325/failed-to-start-snmpd-service-on-ubuntu-linux-os)
