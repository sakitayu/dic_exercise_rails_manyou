## railsのバージョン情報
rails 5.2.3

## taskテーブルの構造
|  カラム  |  データ型  |
| ---- | ---- |
|  name  |  string  |
|  detail  |  string  |


## Herokuへのデプロイ手順

1.  `heroku create` でherokuアプリを作成
2.  `rails assets:precompile RAILS_ENV=production` でプリコンパイル
3. `git add -A`
4. `git commit -m "コミットメッセージ"`
5. `git push heroku master`
6. `heroku run rails db:migrate` でheroku上でマイグレーションする