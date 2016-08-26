describe '#perform!' do
  let(:importer) { UnreadGemsImporter.new }
  let(:unread_gem) { create(:unread_gem, name: 'gem1')}

  before do
    allow(RubyGem).to receive(:collect_gems).and_yield([unread_gem], 2)
  end

  before do
    ExecutionHistory.create(latest_tweet_id: 1)
  end

  subject { importer.perform! }

  its('first.name') { is_expected.to eq(unread_gem.name) }
end
