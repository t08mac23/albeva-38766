# アプリケーション名  
albeva (アルベバ)  
’alcoholic beverage’  


# アプリケーション概要  
新規登録またはログインし、自分の好きなお酒やカクテルの作り方を投稿しシェアできます。また、色んな投稿に「いいね」をクリックできたり、コメントもできるようにする予定です。  


# URL  
https://albeva-38766.onrender.com  


# テスト用アカウント  
basic認証 ID:  test  

basic認証 Password:  2222  

メールアドレス:  test@mail
パスワード:  111aaa


# 利用方法  

### 乾杯（投稿）するまで  
1,トップページの（一覧ページ）のヘッダーからユーザー新規登録を行う  
2,乾杯ボタンから、CHEERS（投稿の内容）を入力し、乾杯する（投稿する）  


# アプリケーションを作成した背景  

家でも簡単に低コストで本格的な味のカクテルを作りたい人向けのレシピ共有サービスを開発しました。理由としてコロナ禍でbarや居酒屋が閉まってしまい、宅飲みの需要が増え他ことと、私自身お酒を飲むのも作るのも好きだからです。また、色んな方と好きなお酒で繋がれるのもこのアプリならではの魅力の一つにしたいと思いました。  

また、このアプリ独特の名前も親しみのあるアプリにしたいため
# 洗い出した要件　  

[要件を定義したシート](https://docs.google.com/spreadsheets/d/1-k_UBMNJ6-_wT2_XmMVfI-Euuca0Lx0bzk_JvgNLELs/edit#gid=1247154864)  


# 実装予定の機能  

コメント機能、「いいね」機能、フォロー機能  


# データベース設計  
<img width="711" alt="スクリーンショット 2023-01-20 17 39 57" src="https://user-images.githubusercontent.com/118711928/213912438-fd0c7d14-d815-41da-b418-566a769e0125.png">

# 画面遷移図  


# 開発環境  

・フロントエンド  
・バックエンド  
・インフラ  
・テスト  
・テキストエディタ  
・タスク管理  


# ローカルでの動作方法  

以下のコマンドを順に実行お願いします。  

% git clone https://github.com/t08mac23/albeva-38766  

% cd albeva-38766  

% bundle install  

% yarn install  


# 工夫したポイント  
「投稿」ボタンを「乾杯」というワードに変更しました。また投稿されたものをあこのアプリ内では「CHEERS」と呼ぶようにしました。従来通りの「投稿する」や「投稿」といった固い言葉では、個性がなく一般的で面白みに欠けると感じたからです。名前を変えるだけでこのアプリに親しみが持てるとも考えました。  
現段階の機能面では、新規登録時、間違えてログインボタンを押してしまっても、「初めての方はコチラ」という新規登録ページへワンクリックでとべるようにしました。  
