require 'rails_helper'

RSpec.describe 'Surveys', type: :request do
  describe 'Viewing the survey completion page' do
    it 'thanks the participant for submitting a response' do
      get feedback.thanks_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Thank you')
    end
  end
end
