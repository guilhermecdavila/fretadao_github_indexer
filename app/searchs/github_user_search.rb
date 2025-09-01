class GithubUserSearch < DefaultSearch
  def search
    default_options
    ::GithubUser.search(query, **options)
  end
end
