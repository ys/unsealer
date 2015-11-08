class UnsealersController < ApplicationController
  def index
    @status = Vault.sys.seal_status
    render :index
  end

  USER_AGENT = "VaultRuby/0.0.1 (+github.com/hashicorp/vault-ruby)".freeze
  # The default headers that are sent with every request.
  DEFAULT_HEADERS = {
    "Content-Type" => "application/json",
    "Accept"       => "application/json",
    "User-Agent"   => USER_AGENT,
  }
  def create
    shard = ENV["VAULT_SHARD"]
    # @status = Vault.sys.unseal()
    require "pp"
    pp Excon.put("#{ENV["VAULT_ADDR"]}/v1/sys/unseal", body: {key: shard}.to_json, headers: DEFAULT_HEADERS)
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to root_path
  end

  def destroy
    Vault.sys.seal
    redirect_to root_path
  end
end
