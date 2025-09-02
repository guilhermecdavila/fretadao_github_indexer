class GithubUserSearch < SearchBase
  def search
    default_options
    ::GithubUser.search(query, **options)
  end
end
