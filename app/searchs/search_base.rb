class SearchBase
  def initialize(query, options = {})
    @query = query
    @options = options
  end

  def search_ids
    ids_options
    search.map { |q| q.id.to_i }
  end

  private

  attr_reader :options, :query

  def ids_options
    default_id_options
    @options.merge! select: [ "id" ]
  end

  def default_id_options
    default_options
    @options.merge! limit: 9999
  end

  def default_options
    options.reverse_merge!(
      fields: [ :name, :nickname, :organization, :location ],
      operator: "or",
      limit: 10,
      body_options: { min_score: 0.5 },
      misspellings: { below: 5, edit_distance: 2 }
    )
  end
end
