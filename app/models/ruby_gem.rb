class RubyGem
  class << self
    def client
      @client
    end

    def client=(client)
      @client = client
    end

    def import_unread_gems
      since_id = ExecutionHistory.last.latest_tweet_id
      ruby_gems_tweets = fetch_user_timeline(since_id)

      ActiveRecord::Base.transaction do
        # TODO description 内の短縮 URL を展開する
        ruby_gems_tweets.each_with_object({}) {|tweet, gem_infos|
          if /\A(?<gem_name>.+) \((?<gem_version>.+)\): (?<gem_description>.+) https:\/\/t.co/ =~ tweet.full_text
            gem_url = tweet.uris.find {|uri| uri.display_url.start_with?('rubygems.org') }.try(:expanded_url).try(:to_s)
            unless gem_infos.key?(gem_name)
              gem_infos[gem_name] = {
                version: gem_version,
                description: gem_description,
                url: gem_url
              }
            end
          end
        }.map {|(gem_name, info)|
          UnreadGem.create(
            name: gem_name,
            version: info[:version],
            description: info[:description],
            url: info[:url]
          )
        }

        ExecutionHistory.create(laetst_tweet_id: ruby_gems_tweets.first.id, start_tweet_id: since_id)
      end
    end

    def fetch_user_timeline(since_id, max_id = nil, timelines = [])
      options = {count: 200, since_id: since_id}
      options.merge!(max_id: max_id) if max_id

      tls = client.user_timeline('rubygems', options)

      timelines.concat(tls)

      if tls.size < options[:count]
        timelines
      else
        fetch_user_time_line(since_id, tls.last.id, timelines)
      end
    end
  end
end
