class RubyGem
  attr_reader :name, :version, :description, :url

  def initialize(name, version, description, url)
    @name = name
    @version = version
    @description = description
    @url = url
  end

  def ==(other_object)
    return false unless other_object
    return false if @name.nil? || other_object.name.nil?

    @name == other_object.name
  end

  class << self
    def client
      @client
    end

    def client=(client)
      @client = client
    end

    def collect_gems(since_id)
      ruby_gems_tweets = fetch_user_timeline(since_id)

      # TODO description 内の短縮 URL を展開する
      ruby_gems_tweets.each_with_object({}) {|tweet, gems|
        if /\A(?<gem_name>.+) \((?<gem_version>.+)\): (?<gem_description>.+) https:\/\/t.co/ =~ tweet.full_text
          gem_url = tweet.uris.find {|uri| uri.display_url.start_with?('rubygems.org') }.try(:expanded_url).try(:to_s)
          gem = RubyGem.new(gem_name, gem_version, gem_description, gem_url)

          gems << gem unless gems.include?(gem)
        end
      }
    end

    def fetch_user_timeline(since_id)
      client.timeline_with_paging(since_id) {|opt|
        client.user_timeline('rubygems', opt)
      }
    end
  end
end
