require_relative '../../lib/token'

describe Token do
  let(:twitter_users) { %w{rhs fredsters_s} }
  let(:table_name) { Token.get_table_name(twitter_users) }

  context ".get_token" do
    subject { Token.get_token(twitter_users) }

    it "returns credentials" do
      expect(subject.has_key?(:session_token)).to eq(true)
      expect(subject.has_key?(:secret_access_key)).to eq(true)
      expect(subject.has_key?(:access_key_id)).to eq(true)
      expect(subject.has_key?(:table_name)).to eq(true)
    end

    it "has the expected table name" do
      expect { subject[:table_name] == table_name }
    end
  end 

  context ".get_table_name" do
    it "is the same regardless of order" do
      expect(Token.get_table_name(['rhs', 'fredsters_s'])).to eq(Token.get_table_name(['fredsters_s', 'rhs']))
    end
  end

  context ".sqs_policy" do
    it "includes the table name" do
      expect(Token.sqs_policy(table_name).to_json.include?(table_name)).to eq(true)
    end

    it "has a unique Sid" do
      expect(Token.sqs_policy(table_name)["Statement"].first["Sid"]).not_to eq(Token.sqs_policy(table_name)["Statement"].first["Sid"])
    end 
  end
end