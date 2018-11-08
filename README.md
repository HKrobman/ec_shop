# MY EC-SHOP
-使用言語: Ruby (rubyバージョン: 2.4.1)
-使用フレームワーク: Ruby on rails (railsバージョン: 5.2.0)
プログラム概要: <br>
  会員制のECサイト。<br>
  会員登録をすることで商品を購入することができる。<br>

<主な機能><br>

管理者<br>
・管理機能<br>
  - 商品の登録管理
  - 商品の在庫管理
  - 会員の管理
  - 注文の管理
  - お問い合わせの管理

ユーザー<br>
- 会員登録機能
- ログイン/ログアウト機能
- お問い合わせ機能
- カート機能
- 商品購入機能
- 商品購入履歴確認機能
- マイリスト機能
- レビュー投稿機能
- レビューに対する投票機能
- クレジットカード決済機能

細かい仕様<br>
- 購入した商品に限りレビューを投稿することができる
- 一度に購入できる同一商品は10個まで
- お問い合わせはアカウントを持ったユーザーのみが利用可能


今後の課題・改善点<br>
- もし在庫が残り1つの商品を同時に注文されてしまった場合、どのような処理を行うべきかを考えて実装すること。
- jquery autokanaの挙動が怪しいため原因を究明すること。
- テストコードをきちんと実装すること。
- お問い合わせ完了時に自動メール配信機能を追加すること。
- 配達日時をユーザーが選択できるようにすること。