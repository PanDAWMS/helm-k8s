# How to deploy standalone harvester with helm

## Setup

```
wget https://github.com/PanDAWMS/helm-k8s/raw/master/panda-harvester/panda-harvester-helm.tgz
tar xvfz panda-harvester-helm.tgz
cd panda-harvester-helm
```

First, edit **panda_queueconfig.json** following
[the doc](https://github.com/HSF/harvester/wiki/Installation-and-configuration#queue-configuration-file).
You need to define all queues there if you don't use CRIC.

Next, edit **panda_harvester_configmap.json**.
The json entries correspond to attributes in panda_harvester.cfg 
[[ref](https://github.com/HSF/harvester/wiki/Installation-and-configuration#setup-and-system-configuration-files)].
For example,

```
{
    "db": {
        "database_filename": "FIXME",
```

in panda_harvester_configmap.json corresponds to

```
[db]
...
database_filename = FIXME
```

in panda_harvester.cfg.

Especially to enable token-based PanDA access, you need to set ```auth_origin``` and ```auth_token```.
The former is *organization:role*, such as *panda_dev:production*, which is a group defined in
[IAM](https://panda-wms.readthedocs.io/en/latest/advanced/iam.html).
The latter is an OIDC ID token string or a filename that contains an OIDC ID token string.
You can get an ID token string using [panda-client](https://panda-wms.readthedocs.io/en/latest/client/panda-client.html)
as follows:

```
export PANDA_AUTH_VO=organization:role
export PANDA_AUTH=oidc
export PANDA_URL_SSL=https://pandaserver-doma.cern.ch:25443/server/panda
export PANDA_URL=http://pandaserver-doma.cern.ch:25080/server/panda
python
```
Then,
```
# run the device code flow to get token
import pandaclient import Client
Client.hello()

# show token
import json, os.path
print(json.load(open(os.path.expanduser('~/.pathena/.token')))['id_token'])
```

## Start the service

Finally, you can install Harvester.

```
helm install myharvester ./
```

The service doesn’t get started automatically. To start it, set autoStart to true in values.yaml before installing it.

```
autoStart: true
```

Or

```
helm install myharvester ./ --set autoStart=true
```