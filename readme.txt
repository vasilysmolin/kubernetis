1. Создание configmap из файлов конфигов в namespace backend
    # kubectl create configmap api-config-map --from-file=local.conf
2. Создаем deployment
    # kubectl apply -f deployment.yaml
3. Созать и применить PersistentVolume
    # kubectl apply -f persistentVolume.yaml
4. Создать и применить PersistentVolumeClaim
    # kubectl apply -f persistentVolumeClaim.yaml


Создание образа и загрузка его в Container Registry Yandex Cloud
1. Получаем идентификатор реестра
    # REGISTRY_ID=$(yc container registry get --name containers --format json | jq .id -r)
2. Собирает Docker образ
    # docker build . -f nginx.dockerfile -t cr.yandex/$REGISTRY_ID/nginx:stable-alpine_v1.0
3. Загружаем Docker образ в реестр
    # docker push cr.yandex/${REGISTRY_ID}/nginx:stable-alpine_v1.0

Encrypt password to secret
1. Получение в формате base64
    # echo -n "test-pwd" | base64

SSl
1. Создание пространства имен
    # kubectl create ns cert-manager
2. Установка Cert-manager
    # kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml
