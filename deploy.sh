docker build -t k1r0n/multi-client:latest -t k1r0n/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t k1r0n/multi-server:latest -t k1r0n/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t k1r0n/multi-worker:latest -t k1r0n/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push k1r0n/multi-client:latest
docker push k1r0n/multi-server:latest
docker push k1r0n/multi-worker:latest

docker push k1r0n/multi-client:$SHA
docker push k1r0n/multi-server:$SHA
docker push k1r0n/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=k1r0n/multi-server:$SHA
kubectl set image deployments/client-deployment client=k1r0n/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=k1r0n/multi-worker:$SHA