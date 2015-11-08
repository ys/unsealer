Rails.application.config.middleware.use OmniAuth::Builder do
  case ENV["AUTH"]
  when "heroku"
    puts "Using: Heroku"
    provider :heroku, ENV['OAUTH_ID'], ENV['OAUTH_SECRET'], fetch_info: true
  when "github"
    puts "Using: GitHub"
    provider :github, ENV['OAUTH_ID'], ENV['OAUTH_SECRET'], scope: "user,read:org"
  when "google"
    puts "Using: Google"
    provider :google_oauth2, ENV["OAUTH_ID"], ENV["OAUTH_SECRET"]
  end
end
