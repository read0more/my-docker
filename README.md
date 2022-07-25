# Requirements

1. [Docker Desktop 설치](https://www.docker.com/products/docker-desktop)
2. Docker Desktop의 설정에서 Experimental Features탭의 Enable VirtioFS accelerated directory sharing 항목 체크
 - 해당 기능이 없으면 container와 host간의 파일 공유가 끔찍하게 느려진다. 해당기능 못 쓸경우에는 [차선책](https://github.com/mutagen-io/mutagen-compose/releases)
 - 차선책 사용할 경우는 docker-compose_mutagen.yml를 참고 해서 docker-compose.yml 작성할것

# 실행

```
docker-compose up -d
```

# 종료

```
docker-compose down
```

# Magento 설치 예시

1. php 컨테이너 접속
2. (php 컨테이너)cd /var/www
3. (php 컨테이너) composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition <install-directory-name>
4. mysql 컨테이너 접속
5. (mysql 컨테이너)mysql -u root -p -e 'CREATE DATABASE my_magento;'
6. (php 컨테이너)php bin/magento setup:install --currency=USD --base-url=http://my-magento.loc --language=en_US --timezone=Asia/Seoul --db-host=mysql --db-name=my_magento --db-user=root --elasticsearch-host=elasticsearch --backend-frontname=admin --admin-user=yk --admin-firstname=yk --admin-lastname=park --admin-email=read0more@test.com --admin-password=password123
   - base-url, admin 정보와 같은 내용은 자신의 프로젝트의 정보에 맞춰 변경
7. (php 컨테이너)php bin/magento setup:upgrade
8. (php 컨테이너)php bin/magento setup:di:compile
9. (php 컨테이너)chmod -R 777 pub/\* var/\*

# Codeigniter 설치 예시

1. php 컨테이너 접속
2. (php 컨테이너)composer create-project codeigniter4/appstarter my-codeigniter

# 도메인 설정

1. project 디렉토리 안에 프로젝트를 추가.
2. codeigniter 프로젝트일 경우는 codeigniter.conf.sample을, magento 프로젝트일 경우는 magento.conf.sample을 복사한다.
3. 파일명을 자신의 프로젝트명에 맞게 바꾸고 .sample 확장자를 제거한다.
4. .conf 내부의 ${YOUR_DOMAIN}을 프로젝트 도메인으로 바꾼다.
5. 프로젝트 도메인을 /etc/hosts에 추가한다.
   - windows의 경우 C:\Windows\System32\drivers\etc\hosts
6. .conf 내부의 ${YOUR_PROJECT_DIR}을 프로젝트 디렉토리명으로 바꾼다.

# Apple chip을 지원하지 않는 모듈을 사용해야 할 경우(NICE 본인인증 실행모듈)

1. nginx 설정에서 php를 php-fpm-x86_64 이미지를 사용한다