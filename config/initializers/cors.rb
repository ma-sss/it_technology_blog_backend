Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        # origins 'example.com'の部分をorigins '*'に変更
        # '*' ですべてのHTTPリクエストを許可する
        origins "http://it-technology-blog-frontend.s3-website-ap-northeast-1.amazonaws.com"

        resource "*",
        headers: :any,

        # exposeの行を追加することで、ブラウザからアクセスできるヘッダー情報を指定
        expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
        # どのHTTPリクエストメソッドを許可するか指定
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
end
