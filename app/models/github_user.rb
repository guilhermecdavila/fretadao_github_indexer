class GithubUser < ApplicationRecord
  include GithubUserIndex

  validates :name, :github_url, presence: true
  validates :github_url, uniqueness: true, format: { with: URI::regexp(%w[http https]), message: "deve ser uma URL válida" }

  after_commit :reindex, on: [ :create, :update, :destroy ]
  after_create :start_webscrapper
  after_create :encrypt_github_url

  def start_webscrapper
    result = ::WebscrapperService.new(github_url: github_url).scam

    update(result) if result.present?
  end

  def encrypt_github_url
    return if encripted_github_url.present?

    short_url = TinyurlShortener.shorten(github_url)
    update(encripted_github_url: short_url)
  end
end
