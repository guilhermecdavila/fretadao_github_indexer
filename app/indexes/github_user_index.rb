module GithubUserIndex
  def self.included(base)
    base.send(:searchkick)
  end

  def search_data
    {
      name: name,
      nickname: nickname,
      organization: organization,
      location: location,
      github_url: github_url
    }
  end
end
