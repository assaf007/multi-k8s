docker build -t assaf007/multi-client:latest -t assaf007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t assaf007/multi-server:latest -t assaf007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t assaf007/multi-worker:latest -t assaf007/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push assaf007/multi-client:latest
docker push assaf007/multi-server:latest
docker push assaf007/multi-worker:latest

docker push assaf007/multi-client:$SHA
docker push assaf007/multi-server:$SHA
docker push assaf007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=assaf007/multi-server:$SHA
kubectl set image deployments/client-deployment client=assaf007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=assaf007/multi-worker:$SHA
