class DependencyUpdateHooksController < ApplicationController
  include GithubWebhook::Processor

  skip_before_action :verify_authenticity_token

  def github_push(payload)
    processor = WebhookProcessors::DependencyPush.new(payload)
    processor.save!
    head :ok
  end

  private

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end