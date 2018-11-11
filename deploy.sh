docker build -t agc11/multi-client:latest -t agc11/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t agc11/multi-server:latest -t agc11/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t agc11/multi-worker:latest -t agc11/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push agc11/multi-client:latest
docker push agc11/multi-server:latest
docker push agc11/multi-worker:latest

docker push agc11/multi-client:$SHA
docker push agc11/multi-server:$SHA
docker push agc11/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=agc11/multi-client:$SHA
kubectl set image deployments/server-deployment server=agc11/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=agc11/multi-worker:$SHA
