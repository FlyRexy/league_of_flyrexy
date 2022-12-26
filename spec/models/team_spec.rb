require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'validations' do
    let!(:team_data) do
      { name: 'Fly Esports', players: %w[Nikita Azamat Igor Yan Ruslan], coach: 'Valera', shortname: 'LOSERS', region: 'EMEA'}
    end

    let!(:team_mail) { Team.new(team_data) }

    it "shouldn't allow long shortnames" do
      expect(team_mail.valid?).to eq(false)
    end

    it { should validate_presence_of(:name).with_message('не может быть пустым') }
    it { should validate_presence_of(:players).with_message('не может быть пустым') }
    it { should validate_presence_of(:coach).with_message('не может быть пустым') }
    it { should validate_presence_of(:shortname).with_message('не может быть пустым') }
    it { should validate_presence_of(:region).with_message('не может быть пустым') }
  end
end
