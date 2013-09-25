require 'spec_helper'

feature "Accounts", :truncate => true, :js => true do
  describe "Show" do
    let(:account) do
      FactoryGirl.create :account,
        :name => "Test Account 1",
        :balance => 2000.00,
        :number => "12-3456-1234567-123",
        :type => "Savings"
    end

    background do
      FactoryGirl.create :transaction,
        :name => "Test Unsorted Transaction",
        :posted_at => Date.parse("2012-10-13"),
        :account => account,
        :amount => 19.95

      FactoryGirl.create :transaction_review,
        :name => "Test Review Transaction",
        :posted_at => Date.parse("2012-10-14"),
        :account => account,
        :amount => 234.56

      FactoryGirl.create :transaction_sorted,
        :name => "Test Sorted Transaction",
        :posted_at => Date.parse("2012-10-15"),
        :account => account,
        :amount => -1000.00
    end

    before do
      visit "/accounts/#{account.id}"
    end

    it "shows the account name" do
      expect(page).to have_content "Test Account 1"
    end

    it "shows the account type" do
      expect(page).to have_content "Savings"
    end

    it "shows the account number" do
      expect(page).to have_content "12-3456-1234567-123"
    end

    describe "Unsorted Transactions" do
      before do
        click_on "Unsorted"
      end

      it "shows the transaction name" do
        expect(page).to have_content "Test Unsorted Transaction"
      end

      it "shows the transaction date" do
        expect(page).to have_content "13 Oct 2012"
      end

      it "shows the transaction amount" do
        expect(page).to have_content "$19.95"
      end
    end

    describe "Review Transactions" do
      before do
        click_on "Review"
      end

      it "shows the transaction name" do
        expect(page).to have_content "Test Review Transaction"
      end

      it "shows the transaction date" do
        expect(page).to have_content "14 Oct 2012"
      end

      it "shows the transaction amount" do
        expect(page).to have_content "$234.56"
      end
    end

    describe "Sorted Transactions" do
      before do
        click_on "Sorted"
      end

      it "shows the transaction name" do
        expect(page).to have_content "Test Sorted Transaction"
      end

      it "shows the transaction date" do
        expect(page).to have_content "15 Oct 2012"
      end

      it "shows the transaction amount" do
        expect(page).to have_content "$1,000.00"
      end
    end
  end
end