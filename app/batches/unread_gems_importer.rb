class UnreadGemsImporter
  def perform!
    unread_gems = collect_unread_gems!

    unread_gems.reject! {|gem| gem.name.in?(ignoring_gem_names) }
  end

  private

  def collect_unread_gems!
    unread_gems = []

    RubyGem.collect_gems(current_cursor) do |ruby_gems, next_cursor|
      ActiveRecord::Base.transaction do
        unread_gems = ruby_gems.map {|gem|
          UnreadGem.create(
            name: gem.name,
            version: gem.version,
            description: gem.description,
            url: gem.url
          )
        }

        ExecutionHistory.create(latest_tweet_id: next_cursor, start_tweet_id: current_cursor)
      end
    end

    unread_gems
  end

  def current_cursor
    @current_cursor ||= ExecutionHistory.last.latest_tweet_id
  end

  def ignoring_gem_names
    @ignoring_gem_names = IgnoringGem.all.pluck(:nam)
  end
end
