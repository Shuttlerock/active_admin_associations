require 'spec_helper'

describe AutocompleteController, type: :controller do
  routes { ActiveAdminAssociations::Engine.routes }

  let!(:tag) { create(:tag, name: 'Music') }

  describe 'get #index' do
    before do
      get :index, params: { model: 'tag', q: 'Mus', format: 'json' }
    end

    it { is_expected.to respond_with(:success) }

    it 'responds with json' do
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end
  end

  describe 'get #index with autocomplete_query_term_param_names config setting set' do
    before do
      Rails.application.config.activeadmin_associations.autocomplete_query_term_param_names = %i[q term]
      get :index, params: { model: 'tag', q: 'Mus', format: 'json' }
    end

    after do
      Rails.application.config.activeadmin_associations.autocomplete_query_term_param_names = nil
    end

    it { is_expected.to respond_with(:success) }

    it 'responds with json' do
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end
  end

  describe 'get #index with no value' do
    before do
      get :index, params: { model: 'tag', format: 'json' }
    end

    it { is_expected.to respond_with(:success) }

    it 'responds with json' do
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end
  end
end
