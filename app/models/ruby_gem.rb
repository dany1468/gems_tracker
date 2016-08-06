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

    def fetch_user_timeline(since_id)
      client.timeline_with_paging(since_id) {|opt|
        client.user_timeline('rubygems', opt)
      }
    end
  end
end
