# frozen_string_literal: true
require 'spec_helper'

RSpec.describe InterviewApp::Operations::Post::IpList do
  subject { operation.call }

  let(:operation) { Class.new(described_class).new(user_repo: user_repo) }
  let(:user_repo) { instance_double('UserRepository', find_ip_list: []) }

  describe '.call' do

      it 'return success monad' do
       expect(subject).to be_a_kind_of(Dry::Monads::Result::Success)
      end

      it 'return success monad with post entity' do
        expect(subject.success).to be_a_kind_of(Array)
      end

      it 'return success monad with post entity' do
        expect(user_repo).to receive(:find_ip_list)
        subject
      end
  end
end
