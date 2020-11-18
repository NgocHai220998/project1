# README

プロジェクトを作成する前に、以下のリンクの通りにやってください。
https://docs.docker.com/compose/rails/

Error: Database is uninitialized and superuser password is not specified.というエラーが発生した場合、
dockerーcompose.ymlに　
  environment:
    POSTGRES_DB: "db"
    POSTGRES_HOST_AUTH_METHOD: "trust"
追加してください。

Import Database:
  テーブルを作成する
  psql -v -U postgres -h db -d project1_development -f project1/tmp/db/learning_db
