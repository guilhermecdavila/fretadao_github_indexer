class GithubUserSearchForm < FormBase
  attr_accessor :query

  validates :query, presence: true
end