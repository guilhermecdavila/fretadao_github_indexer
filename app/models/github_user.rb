class GithubUser < ApplicationRecord
  after_create :start_webscrapper
  after_create :encrypt_github_url

  def start_webscrapper
    result = Webscrapper.new(github_url: github_url).scam

    update(result) if result.present?
  end

  def encrypt_github_url
    return if encripted_github_url.present?

    short_url = TinyurlShortener.shorten(github_url)
    update(encripted_github_url: short_url)
  end
end
