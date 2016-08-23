class UnreadGemsImporter
  def perform!
    RubyGem.collect_gems(current_cursor) do |ruby_gems, next_cursor|
      ActiveRecord::Base.transaction do
        ruby_gems.map {|gem|
          UnreadGem.create(
            name: gem.name,
            version: gem.version,
            description: gem.description,
            url: gem.url
          )
        }

        ExecutionHistory.create(latest_tweet_id: next_cursor, start_tweet_id: cursor)
      end
    end
  end

  private

  def current_cursor
    @current_cursor ||= ExecutionHistory.last.latest_tweet_id
  end
end
