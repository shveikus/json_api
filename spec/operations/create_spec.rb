# frozen_string_literal: true

require 'spec_helper'

RSpec.describe InterviewApp::Operations::Post::Create do
  subject { operation.call(params) }

  let(:operation) { Class.new(described_class).new(user_repo: user_repo)                }
  let(:user_repo) { instance_double('UserRepository', already_exist?: Post.new(params)) }

  describe '.call' do
    context 'when params are valid' do
      let(:params) do
        {
          body: 'some post body',
          title: 'lorem ipsum',
          login: 'f24ff4'
        }
      end

      it 'return success monad' do
        expect(subject).to be_a_kind_of(Dry::Monads::Result::Success)
      end

      it 'return success monad with post entity' do
        expect(subject.success).to be_a_kind_of(Post)
      end

      it 'return success monad with post entity' do
        expect(user_repo).to receive(:already_exist?).with('f24ff4')
        subject
      end
    end

    context 'when params are invalid' do
      subject { operation.call(params) }

      let(:params) do
        {
          body: '',
          login: 'f24ff4'
        }
      end

      it 'return failure monad' do
        expect(subject).to be_a_kind_of(Dry::Monads::Result::Failure)
      end

      it 'return filure monad with validation errors' do
        expect(subject.failure).to eq({ title: ['is missing'], body: ['must be filled'] })
      end

      it 'return success monad with post entity' do
        expect(user_repo).not_to receive(:already_exist?).with('f24ff4')
        subject
      end
    end
  end
end
