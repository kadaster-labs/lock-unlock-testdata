# Deploy using Helm Charts

## Test on a local Docker Desktop Kubernetes environment:
For IngressController (to access the Fuseki endpoint in the browser), install something like [ingress-nginx](https://kubernetes.github.io/ingress-nginx/).
```bash
helm upgrade --install ingress-nginx ingress-nginx  \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace
```

The next step assumes you've built the fuseki-docker and lock-unlock-dataloader images, as a reminder:
```bash
docker build --build-arg JENA_VERSION=4.10.0 -t lock-unlock-testdata/fuseki:4.10.0 ./fuseki-docker/
docker build -t lock-unlock-dataloader:latest ./lock-unlock-dataloader
```

Then, the deployment can be done using the following command:
```bash
helm install fuseki charts/ --values charts/values.localhost.yaml --namespace lock-unlock --create-namespace
```

You should now be able to access the dataset at http://fuseki.127.0.0.1.nip.io/

## Deploying multiple dataset
You might do something like:
```bash
helm install fuseki-anbi charts/ \
  --namespace lock-unlock-anbi --create-namespace \
  --set fuseki.image=lock-unlock-testdata/fuseki \
  --set ingress.host=anbi.127.0.0.1.nip.io \
  --set fuseki.dataset.file_url="https://raw.githubusercontent.com/kadaster-labs/lock-unlock-testdata/main/testdata-anbi/lock-unlock-anbi.ttl.gz"

helm install fuseki-brk charts/ \
  --namespace lock-unlock-brk --create-namespace \
  --set fuseki.image=lock-unlock-testdata/fuseki \
  --set ingress.host=brk.127.0.0.1.nip.io \
  --set fuseki.dataset.file_url="https://raw.githubusercontent.com/kadaster-labs/lock-unlock-testdata/main/testdata-brk/lock-unlock-brk.ttl.gz"

helm install fuseki-brp charts/ \
  --namespace lock-unlock-brp --create-namespace \
  --set fuseki.image=lock-unlock-testdata/fuseki \
  --set ingress.host=brp.127.0.0.1.nip.io \
  --set fuseki.dataset.file_url="https://raw.githubusercontent.com/kadaster-labs/lock-unlock-testdata/main/testdata-brp/lock-unlock-brp.ttl.gz"

helm install fuseki-nhr charts/ \
  --namespace lock-unlock-nhr --create-namespace \
  --set fuseki.image=lock-unlock-testdata/fuseki \
  --set ingress.host=nhr.127.0.0.1.nip.io \
  --set fuseki.dataset.file_url="https://raw.githubusercontent.com/kadaster-labs/lock-unlock-testdata/main/testdata-nhr/lock-unlock-nhr.ttl.gz"
```

You can then access http://<DATASET>.127.0.0.1.nip.io/
