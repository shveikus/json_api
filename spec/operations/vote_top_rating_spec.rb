# frozen_string_literal: true
require 'spec_helper'

RSpec.describe InterviewApp::Operations::Post::Vote do
  let(:operation) { Class.new(described_class).new(post_repo: post_repo) }
  let(:post_repo) { instance_double('PostRepository', update_avg_rating: Post.new(post)) }
  let(:post) do
    {
      id: 3,
      body: "some post body",
      title: "lorem ipsum",
      login: "f24ff4",
      votes: 1,
      total_rating: 1,
      avg_rating: 1
    }
  end
  let(:valid_params) do
    {
      post_id: 3,
      user_rate: 4
    }
  end
  let(:invalid_params) do
    {
      post_id: "fwfe",
      user_rate: 10
    }
  end


  describe '.call' do
    context 'when params are valid' do
      subject { operation.call(valid_params) }

      it 'return success monad' do
       expect(subject).to be_a_kind_of(Dry::Monads::Result::Success)
      end

      it 'return success monad with hash entity' do
        expect(subject.success).to be_a_kind_of(Hash)
        expect(subject.success).to eq({:avg_rating=>1})
      end

      it 'return success monad with post entity' do
        expect(post_repo).to receive(:update_avg_rating).with(valid_params)
        subject
      end
    end

    context 'when params are invalid' do subject { operation.call(params) }
      subject { operation.call(invalid_params) }

      it 'return failure monad' do
       expect(subject).to be_a_kind_of(Dry::Monads::Result::Failure)
      end

      it 'return filure monad with validation errors' do
        expect(subject.failure).to eq({:user_rate=>["must be less than 6", "must be greater than 0"], :post_id=>["must be an integer"]})
      end

      it 'return success monad with post entity' do
        expect(post_repo).not_to receive(:update_avg_rating).with(invalid_params)
        subject
      end
    end
  end
end
