require "pp"
class SessionsController < ApplicationController
  def create
    if %w{heroku google}.include? ENV["AUTH"]
      unless email.match(/@#{ENV["AUTHORIZED_DOMAIN"]}$/i)
        flash[:error] = "#{ENV["AUTH"].capitalize}: Unauthorized domain for #{email}"
        redirect_to root_path
        return
      end
    end
    if ENV["AUTH"] == "github"
      client = Octokit::Client.new(access_token: auth[:credentials][:token])
      orgs = client.organizations
      unless orgs.map(&:login).include? ENV["AUTHORIZED_ORG"]
        flash[:error] = "GitHub: Unauthorized organization for #{auth[:info][:nickname]}"
        redirect_to root_path
        return
      end
    end
    session[:user_email] = auth[:info][:email]
    session[:user_name] = auth[:info][:name]
    session[:user_image] = auth[:info][:image]
    redirect_to root_path
  end

  def destroy
    session[:user_email] = nil
    session[:user_name] = nil
    session[:user_image] = nil
    flash[:notice] = "Disconnected"
    redirect_to root_path
  end

  def email
    auth[:info][:email]
  end

  def auth
    pp env["omniauth.auth"]
  end
end


