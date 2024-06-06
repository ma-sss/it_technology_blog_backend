◎*目次*  
　・ウェブアプリの概要  
　・使用技術  
　・データベース設計図  
　・機能説明

◎*ウェブアプリの概要*  
　このブログではウェブアプリ自体の作り方や技術を初心者の方でも理解しやすいように、わかりやすく解説しています。  
基本構造としてはバックエンドをRailsで、フロントエンドをReactで構成し、REST APIで接続したウェブアプリになります。  
基本的な機能としては管理者のみがログインして記事の投稿をして、一般ユーザーはログインなしで投稿の閲覧やコメントと返信の投稿が可能です。  
※ブログの投稿内容まだ完成していません。現在更新中ですのでご了承ください。  

◎*使用技術*  
　フロントエンド  
 　　・言語: JavaScript, TypeScript  
 　　・フレームワーク: React  
 　　・クラウド: AWS S3  
　バックエンド  
 　　・言語: Ruby  
 　　・フレームワーク: Rails(セキュリティ面に配慮し、管理者ユーザー認証にdevise_token_authを使用しています)  
 　　・テスト: Rspec  （単体テスト:model、　機能テスト:request）  
 　　・クラウド: AWS EC2  
 　データベース  
 　　・MySQL  
　

<img width="264" alt="image" src="https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/6967bd87-54d5-4b06-b511-984ceed50d49">　　

◎*機能説明*（一般ユーザーと管理者のみができることを分けて説明しています）  

一般ユーザーの場合  
TOP画面  URL:[http://it-technology-blog-frontend.s3-website-ap-northeast-1.amazonaws.com/build/]
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/35105354-6c5d-4981-b2f8-bc11f36909fa)
  
○上のTOP画面に表示されている『◯仮の投稿編(3件)』をクリック  
（実際はbackend編やfrontend編、説明編、その他編があります）    
（下に表示されている💬の横の数字は投稿に対してのコメント数を表示しています）  
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/bf804773-f255-45b6-9b61-762f02abc8ab)
  
次に上の画面で見たい投稿（例:仮の投稿タイトル0）をクリックすると投稿内容とその投稿に対してのコメントが閲覧でき、さらにブログの投稿に対してコメントの投稿ができる。（下に表示されている💬の横の数字はコメントに対しての返信数を表示しています）
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/59d1b72b-a4fd-4397-a371-cfa11ba3423c)
  
次に気になるコメント（例:一番上の管理者のコメント）をクリックするとコメントに対しての返信を見ることができ、そのコメントに対しての返信を投稿することができます。
![スクリーンショット 2024-05-10 21 10 52](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/cb071923-7b05-47c5-991b-b0c82f8136de)
  
ここまでが一般ユーザーができることです。  

  
次は管理者のみができることを説明します。  
まずTOP画面にて、signinをしていきます。
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/35105354-6c5d-4981-b2f8-bc11f36909fa)
  
Signinをクリックして
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/ce093f56-d35f-4cc5-b7ad-da0ea2f073a3)
  
ログインしていくと
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/8f8c7d7d-078e-4d54-89d5-a8dba644e4c8)
  
headerに投稿ページが表示されるのでこれをクリックして
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/b5d96581-547f-4b62-89cf-62d286d19fe7)
  
ここで投稿内容を入力することができる。

あとは投稿の編集やコメント編集、返信編集をすることができます。

投稿編集画面
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/055e8951-4eaf-4ec9-9325-6d2b6abded90)
  
コメント編集画面
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/acde1a5c-a66b-472c-8544-35ba8015a113)
  
返信編集画面
![image](https://github.com/ma-sss/it_technology_blog_backend/assets/120617383/52540dea-09fb-4bdc-a974-bf5493fc2818)
  


以上が機能紹介になります。
