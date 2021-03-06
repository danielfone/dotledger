require 'spec_helper'

describe Api::AccountsController do
  let!(:account) { FactoryGirl.create :account, :name => 'Account Name' }

  describe "GET index" do
    before { get :index }

    it { should respond_with :success }

    it "should return all accounts" do
      expect(assigns(:accounts)).to eq [account]
    end
  end

  describe "GET show" do
    before { get :show, :id => account.id }

    it { should respond_with :success }

    it "should return the account" do
      expect(assigns(:account)).to eq account
    end
  end

  describe "POST create" do
    def valid_request
      post :create,
        :name => 'Account Name',
        :number => '1212341234567120',
        :type => 'Cheque'
    end

    it "should respond with 200" do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it "should create an account" do
      expect {
        valid_request
      }.to change(Account, :count).by(1)
    end
  end

  describe "PUT update" do
    def valid_request
      put :update,
        :id => account.id,
        :name => 'New Account Name'
    end

    it "should respond with 200" do
      valid_request
      expect(subject).to respond_with(:success)
    end

    it "should update the name" do
      expect {
        valid_request
      }.to change {account.reload.name}.from('Account Name').to('New Account Name')
    end
  end

  describe "DELETE destroy" do
    def valid_request
      delete :destroy,
        :id => account.id
    end

    it "should respond with 204" do
      valid_request
      expect(subject).to respond_with(:no_content)
    end

    it "should delete the account" do
      expect {
        valid_request
      }.to change(Account, :count).by(-1)
    end
  end
end
