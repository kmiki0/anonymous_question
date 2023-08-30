# anonymous_question

A new Flutter project.

### SSH接続
```
ssh ubuntu@ik1-218-79096.vs.sakura.ne.jp -p 22
```
GYFW6raweqU.



## 通信方法
-  ホスト
    1. サーバーに接続
    2. ホスト(押下)で、ルームのTokenとルーム名を入力して、サーバーに送信
    3. 生成した文字列とTokenをサーバーに送信
    4. サーバーから、ルームのTokenとルーム名を他端末に送信

- ゲスト
    1. サーバーに接続
    2. ゲスト(押下)で、ルーム名一覧を取得（更新ボタンで更新か、1分で更新）
    3. ルーム名を選択して、サーバーに送信
    4. スイッチエリアに画面遷移
    5. 押下で、ルームのTokenと（ON・OFF）をサーバーに送信
    6. ホストにカウントアップ・ダウンして送信





## テーブル構造
- ルームテーブル
    | name       |     type    | PRIMARY KEY |
    |:-----------|:------------|:-----------:|
    |id          | int         | ◯          |
    |room_roken  | varchar     |             |
    |room_name   | varchar     |             |

- ルームテーブル