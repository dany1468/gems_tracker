require 'twitter/rest/utils'
require 'twitter/tweet'
require 'twitter/user'

module Twitter
  module REST
    module Timelines
      def timeline_with_paging(since_id, options = {}, max_id = nil, timelines = [], &block)
        options.merge!(count: 200, since_id: since_id)
        options.merge!(max_id: max_id) if max_id

        tls = block.call(options)

        timelines.concat(tls)

        if tls.size < options[:count]
          timelines
        else
          timeline_with_paging(since_id, options, tls.last.id, timelines, &block)
        end
      end
    end
  end
end
